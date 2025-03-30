import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:flutter/material.dart';

class AniButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;

  const AniButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AniColors.primary,
          foregroundColor: isOutlined ? AniColors.primary : AniColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isOutlined
                ? BorderSide(color: AniColors.primary, width: 2)
                : BorderSide.none,
          ),
          elevation: isOutlined ? 0 : 2,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isOutlined ? AniColors.primary : AniColors.white,
                  ),
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: AniFonts.f_16_700.copyWith(
                  color: isOutlined ? AniColors.primary : AniColors.white,
                ),
              ),
      ),
    );
  }
} 
