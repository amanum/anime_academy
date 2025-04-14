import 'package:anime_academy/bloc/auth/auth_bloc.dart';
import 'package:anime_academy/ui/screen/auth/register_screen.dart';
import 'package:anime_academy/ui/screen/universe_select/universe_select_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:anime_academy/ui/widget/ani_button.dart';
import 'package:anime_academy/ui/widget/ani_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AniColors.white,
      appBar: AppBar(
        backgroundColor: AniColors.white,
        elevation: 0,
        title: Text('Вход', style: AniFonts.f_20_700),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Переходим на главный экран после успешной авторизации
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const UniverseSelectScreen(),
              ),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            // Показываем сообщение об ошибке
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Добро пожаловать',
                  style: AniFonts.f_20_700,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Войдите в свой аккаунт',
                  style: AniFonts.f_16_400,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                AniTextField(
                  controller: _identifierController,
                  labelText: 'Логин или Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите логин или email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AniTextField(
                  controller: _passwordController,
                  labelText: 'Пароль',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите пароль';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AniButton(
                      text: 'Войти',
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthLoginRequested(
                                  identifier: _identifierController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Нет аккаунта? Зарегистрироваться',
                    style: AniFonts.f_14_500.copyWith(
                      color: AniColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
