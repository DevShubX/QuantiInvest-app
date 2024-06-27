class FinancialCashFlow {
  final DateTime date;
  final DateTime filingDate;
  final String currencySymbol;
  final double investments;
  final double? changeToLiabilities;
  final double totalCashflowsFromInvestingActivities;
  final double? netBorrowings;
  final double totalCashFromFinancingActivities;
  final double? changeToOperatingActivities;
  final double netIncome;
  final double changeInCash;
  final double beginPeriodCashFlow;
  final double endPeriodCashFlow;
  final double totalCashFromOperatingActivities;
  final double? issuanceOfCapitalStock;
  final double depreciation;
  final double otherCashflowsFromInvestingActivities;
  final double dividendsPaid;
  final double changeToInventory;
  final double changeToAccountReceivables;
  final double salePurchaseOfStock;
  final double otherCashflowsFromFinancingActivities;
  final double? changeToNetincome;
  final double capitalExpenditures;
  final double changeReceivables;
  final double? cashFlowsOtherOperating;
  final double? exchangeRateChanges;
  final double cashAndCashEquivalentsChanges;
  final double changeInWorkingCapital;
  final double stockBasedCompensation;
  final double otherNonCashItems;
  final double freeCashFlow;

  FinancialCashFlow({
    required this.date,
    required this.filingDate,
    required this.currencySymbol,
    required this.investments,
    this.changeToLiabilities,
    required this.totalCashflowsFromInvestingActivities,
    this.netBorrowings,
    required this.totalCashFromFinancingActivities,
    this.changeToOperatingActivities,
    required this.netIncome,
    required this.changeInCash,
    required this.beginPeriodCashFlow,
    required this.endPeriodCashFlow,
    required this.totalCashFromOperatingActivities,
    this.issuanceOfCapitalStock,
    required this.depreciation,
    required this.otherCashflowsFromInvestingActivities,
    required this.dividendsPaid,
    required this.changeToInventory,
    required this.changeToAccountReceivables,
    required this.salePurchaseOfStock,
    required this.otherCashflowsFromFinancingActivities,
    this.changeToNetincome,
    required this.capitalExpenditures,
    required this.changeReceivables,
    this.cashFlowsOtherOperating,
    this.exchangeRateChanges,
    required this.cashAndCashEquivalentsChanges,
    required this.changeInWorkingCapital,
    required this.stockBasedCompensation,
    required this.otherNonCashItems,
    required this.freeCashFlow,
  });

  factory FinancialCashFlow.fromJson(Map<String, dynamic> json) {
    return FinancialCashFlow(
      date: DateTime.parse(json['date']),
      filingDate: DateTime.parse(json['fillingDate']),
      currencySymbol: json['currenySymbol'],
      cashAndCashEquivalentsChanges:
          double.parse(json['cashAndCashEquivalentsChanges']),
      investments: double.parse(json['investments']),
      totalCashflowsFromInvestingActivities:
          double.parse(json['totalCashflowsFromInvestingActivities']),
      totalCashFromFinancingActivities:
          double.parse(json['totalCashFromFinancingActivities']),
      netIncome: double.parse(json['netIncome']),
      changeInCash: double.parse(json['changeInCash']),
      beginPeriodCashFlow: double.parse(json['beginPeriodCashFlow']),
      endPeriodCashFlow: double.parse(json['endPeriodCashFlow']),
      totalCashFromOperatingActivities:
          double.parse(json['totalCashFromOperatingActivities']),
      depreciation: double.parse(json['depreciation']),
      otherCashflowsFromInvestingActivities:
          double.parse(json['otherCashflowsFromInvestingActivities']),
      dividendsPaid: double.parse(json['dividendsPaid']),
      changeToInventory: double.parse(json['changeToInventory']),
      changeToAccountReceivables:
          double.parse(json['changeToAccountReceivables']),
      salePurchaseOfStock: double.parse(json['salePurchaseOfStock']),
      otherCashflowsFromFinancingActivities:
          double.parse(json['otherCashflowsFromFinancingActivities']),
      capitalExpenditures: double.parse(json['capitalExpenditures']),
      changeReceivables: double.parse(json['changeReceivables']),
      changeInWorkingCapital: double.parse(json['changeInWorkingCapital']),
      stockBasedCompensation: double.parse(json['stockBasedCompensation']),
      otherNonCashItems: double.parse(json['otherNonCashItems']),
      freeCashFlow: double.parse(json['freeCashFlow']),
    );
  }

  factory FinancialCashFlow.fromMap(Map<String, dynamic> map) {
    return FinancialCashFlow.fromJson(map);
  }
}
