
class FinancialIncomeStatement {
  final DateTime date;
  final DateTime filingDate;
  final String currencySymbol;
  final double researchDevelopment;
  final double? effectOfAccountingCharges;
  final double incomeBeforeTax;
  final double? minorityInterest;
  final double netIncome;
  final double sellingGeneralAdministrative;
  final double? sellingAndMarketingExpenses;
  final double grossProfit;
  final double reconciledDepreciation;
  final double ebit;
  final double ebitda;
  final double depreciationAndAmortization;
  final double nonOperatingIncomeNetOther;
  final double operatingIncome;
  final double otherOperatingExpenses;
  final double interestExpense;
  final double taxProvision;
  final double interestIncome;
  final double netInterestIncome;
  final double? extraordinaryItems;
  final double? nonRecurring;
  final double? otherItems;
  final double incomeTaxExpense;
  final double totalRevenue;
  final double totalOperatingExpenses;
  final double costOfRevenue;
  final double totalOtherIncomeExpenseNet;
  final double? discontinuedOperations;
  final double netIncomeFromContinuingOps;
  final double netIncomeApplicableToCommonShares;
  final double? preferredStockAndOtherAdjustments;

  FinancialIncomeStatement({
    required this.date,
    required this.filingDate,
    required this.currencySymbol,
    required this.researchDevelopment,
    this.effectOfAccountingCharges,
    required this.incomeBeforeTax,
    this.minorityInterest,
    required this.netIncome,
    required this.sellingGeneralAdministrative,
    this.sellingAndMarketingExpenses,
    required this.grossProfit,
    required this.reconciledDepreciation,
    required this.ebit,
    required this.ebitda,
    required this.depreciationAndAmortization,
    required this.nonOperatingIncomeNetOther,
    required this.operatingIncome,
    required this.otherOperatingExpenses,
    required this.interestExpense,
    required this.taxProvision,
    required this.interestIncome,
    required this.netInterestIncome,
    this.extraordinaryItems,
    this.nonRecurring,
    this.otherItems,
    required this.incomeTaxExpense,
    required this.totalRevenue,
    required this.totalOperatingExpenses,
    required this.costOfRevenue,
    required this.totalOtherIncomeExpenseNet,
    this.discontinuedOperations,
    required this.netIncomeFromContinuingOps,
    required this.netIncomeApplicableToCommonShares,
    this.preferredStockAndOtherAdjustments,
  });

  factory FinancialIncomeStatement.fromJson(Map<String, dynamic> json) {
    return FinancialIncomeStatement(
      date: DateTime.parse(json['date']),
      filingDate: DateTime.parse(json['filing_date']),
      currencySymbol: json['currency_symbol'],
      researchDevelopment: double.parse(json['researchDevelopment']),
      effectOfAccountingCharges: json['effectOfAccountingCharges'] != null ? double.parse(json['effectOfAccountingCharges']) : null,
      incomeBeforeTax: double.parse(json['incomeBeforeTax']),
      minorityInterest: json['minorityInterest'] != null ? double.parse(json['minorityInterest']) : null,
      netIncome: double.parse(json['netIncome']),
      sellingGeneralAdministrative: double.parse(json['sellingGeneralAdministrative']),
      sellingAndMarketingExpenses: json['sellingAndMarketingExpenses'] != null ? double.parse(json['sellingAndMarketingExpenses']) : null,
      grossProfit: double.parse(json['grossProfit']),
      reconciledDepreciation: double.parse(json['reconciledDepreciation']),
      ebit: double.parse(json['ebit']),
      ebitda: double.parse(json['ebitda']),
      depreciationAndAmortization: double.parse(json['depreciationAndAmortization']),
      nonOperatingIncomeNetOther: double.parse(json['nonOperatingIncomeNetOther']),
      operatingIncome: double.parse(json['operatingIncome']),
      otherOperatingExpenses: double.parse(json['otherOperatingExpenses']),
      interestExpense: double.parse(json['interestExpense']),
      taxProvision: double.parse(json['taxProvision']),
      interestIncome: double.parse(json['interestIncome']),
      netInterestIncome: double.parse(json['netInterestIncome']),
      extraordinaryItems: json['extraordinaryItems'] != null ? double.parse(json['extraordinaryItems']) : null,
      nonRecurring: json['nonRecurring'] != null ? double.parse(json['nonRecurring']) : null,
      otherItems: json['otherItems'] != null ? double.parse(json['otherItems']) : null,
      incomeTaxExpense: double.parse(json['incomeTaxExpense']),
      totalRevenue: double.parse(json['totalRevenue']),
      totalOperatingExpenses: double.parse(json['totalOperatingExpenses']),
      costOfRevenue: double.parse(json['costOfRevenue']),
      totalOtherIncomeExpenseNet: double.parse(json['totalOtherIncomeExpenseNet']),
      discontinuedOperations: json['discontinuedOperations'] != null ? double.parse(json['discontinuedOperations']) : null,
      netIncomeFromContinuingOps: double.parse(json['netIncomeFromContinuingOps']),
      netIncomeApplicableToCommonShares: double.parse(json['netIncomeApplicableToCommonShares']),
      preferredStockAndOtherAdjustments: json['preferredStockAndOtherAdjustments'] != null ? double.parse(json['preferredStockAndOtherAdjustments']) : null,
    );
  }

  factory FinancialIncomeStatement.fromMap(Map<String, dynamic> map) {
    return FinancialIncomeStatement.fromJson(map);
  }
}
