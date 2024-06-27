import 'package:flutter/material.dart';
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:quantiinvest_app/pages/PortfolioScreens/PortfolioAnalysisScreen.dart';
import 'package:quantiinvest_app/pages/PortfolioScreens/PortfolioInvestmentScreen.dart';

class Portfolioscreen extends StatefulWidget {
  const Portfolioscreen({super.key});

  @override
  State<Portfolioscreen> createState() => _PortfolioscreenState();
}

class _PortfolioscreenState extends State<Portfolioscreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              indicatorColor: AppColors.colors.qtBlue,
              dividerColor: Colors.transparent,
              labelColor: AppColors.colors.qtBlue,
              tabs: const [
                Tab(
                  child: Text(
                    "Investment",
                    style: TextStyle(fontFamily: 'Gilroy-Medium'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Analysis",
                    style: TextStyle(fontFamily: 'Gilroy-Medium'),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(children: [
            PortfolioInvestmentScreen(),
            PortfolioAnalysisScreen()
          ]),
        ));
  }
}
