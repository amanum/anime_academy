import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:flutter/material.dart';

class FullContentListScreen extends StatefulWidget {
  const FullContentListScreen({super.key});

  @override
  State<FullContentListScreen> createState() => _FullContentListScreenState();
}

class _FullContentListScreenState extends State<FullContentListScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AniColors.white,
      body: SafeArea(
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AniColors.greyLight)),
                ),
                child: TabBar(
                  controller: TabController(length: 7, vsync: this),
                  isScrollable: true,
                  indicatorColor: AniColors.accent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AniColors.accent,
                  labelPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  padding: EdgeInsets.zero,
                  unselectedLabelColor: AniColors.greyLight,
                  dividerHeight: 0,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Text('Все'),
                    Text('Математика'),
                    Text('Физика'),
                    Text('Физика'),
                    Text('Физика'),
                    Text('Физика'),
                    Text('Физика'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
