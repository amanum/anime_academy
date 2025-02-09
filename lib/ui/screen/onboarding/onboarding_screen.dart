import 'package:anime_academy/localization/generated/ani_localization.dart';
import 'package:anime_academy/ui/screen/onboarding/widget/onboarding_slide.dart';
import 'package:anime_academy/ui/screen/onboarding/widget/slider_dots.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _sliderController = CarouselSliderController();

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: double.infinity,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentIndex.value = index;
                      });
                    }),
                carouselController: _sliderController,
                items: [
                  /// TODO(umurzakov): refactor images after img/gif/video will be ready
                  OnboardingSlide(
                    image: 'assets/images/naruto.png',
                    text: S.of(context).onboardingText1,
                  ),
                  OnboardingSlide(
                    image: 'assets/images/naruto.png',
                    text: S.of(context).onboardingText2,
                  ),
                  OnboardingSlide(
                    image: 'assets/images/naruto.png',
                    text: S.of(context).onboardingText3,
                  ),
                ],
              ),
            ),
            SliderDots(
              count: 3,
              activeIndex: _currentIndex.value,
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                  valueListenable: _currentIndex,
                  builder: (context, currentSlide, _) {
                    return ElevatedButton(
                      onPressed: () {
                        if (currentSlide < 2) {
                          _sliderController.nextPage();
                        }
                      },
                      child: Text(
                        currentSlide < 2
                            ? S.of(context).next
                            : S.of(context).start,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
