import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:flutter/material.dart';

class SliderDots extends StatelessWidget {
  const SliderDots({
    required this.count,
    required this.activeIndex,
    super.key,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        for (int i = 0; i < count; i++) _SliderDot(isActive: i == activeIndex),
      ],
    );
  }
}

class _SliderDot extends StatelessWidget {
  const _SliderDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isActive ? 20 : 5,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isActive ? AniColors.accent : AniColors.accentWithOpacity,
      ),
    );
  }
}
