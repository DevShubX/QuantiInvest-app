import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:quantiinvest_app/pages/PortfolioScreens/PortfolioScreen.dart';
import 'package:quantiinvest_app/pages/StockSearchScreen.dart/StockSearchSearch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status3 = false;
  int selectedIndex = 0;

  static const List<TabItem> items = [
    TabItem(
      icon: Icons.candlestick_chart_outlined,
      title: 'Portfolio',
    ),
    TabItem(
      icon: Icons.add,
    ),
    TabItem(
      icon: Icons.account_box,
      title: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: Icon(
                    Icons.person,
                    size: 30.sp,
                  )),
              FlutterSwitch(
                activeColor: AppColors.colors.qtBlue,
                inactiveColor: AppColors.colors.lkDarkGreen,
                value: status3,
                onToggle: (val) {
                  setState(() {
                    status3 = val;
                  });
                },
              ),
              Container(
                  margin: EdgeInsets.only(left: 6.w, bottom: 5.h),
                  child: Icon(
                    Icons.settings_suggest,
                    size: 30.sp,
                  )),
            ],
          ),
        ),
        bottomNavigationBar: BottomBarCreative(
          items: items,
          backgroundColor: const Color.fromARGB(255, 29, 29, 29),
          color: const Color.fromARGB(255, 83, 86, 88),
          colorSelected: AppColors.colors.qtBlue,
          indexSelected: selectedIndex,
          isFloating: true,
          highlightStyle:
              const HighlightStyle(sizeLarge: true, isHexagon: true),
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: Column(
          children: [
            Visibility(
              visible: selectedIndex == 0,
              child: const Expanded(
                child: Portfolioscreen(),
              ),
            ),
            Visibility(
              visible: selectedIndex == 1,
              child: const Expanded(
                child: StockSearchScreen(),
              ),
            ),
          ],
        ));
  }
}
