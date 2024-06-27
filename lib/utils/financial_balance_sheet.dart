class FinancialBalanceSheet {
  final DateTime date;
  final DateTime filingDate;
  final String currencySymbol;
  final double totalAssets;
  final double? intangibleAssets;
  final double? earningAssets;
  final double otherCurrentAssets;
  final double totalLiabilities;
  final double totalStockholderEquity;
  final double? deferredLongTermLiab;
  final double otherCurrentLiab;
  final double commonStock;
  final double capitalStock;
  final double retainedEarnings;
  final double? otherLiab;
  final double? goodWill;
  final double otherAssets;
  final double cash;
  final double cashAndEquivalents;
  final double totalCurrentLiabilities;
  final double currentDeferredRevenue;
  final double netDebt;
  final double shortTermDebt;
  final double shortLongTermDebt;
  final double shortLongTermDebtTotal;
  final double otherStockholderEquity;
  final double propertyPlantEquipment;
  final double totalCurrentAssets;
  final double longTermInvestments;
  final double? netTangibleAssets;
  final double shortTermInvestments;
  final double netReceivables;
  final double longTermDebt;
  final double inventory;
  final double accountsPayable;
  final double? totalPermanentEquity;
  final double? noncontrollingInterestInConsolidatedEntity;
  final double? temporaryEquityRedeemableNoncontrollingInterests;
  final double accumulatedOtherComprehensiveIncome;
  final double? additionalPaidInCapital;
  final double? commonStockTotalEquity;
  final double? preferredStockTotalEquity;
  final double? retainedEarningsTotalEquity;
  final double? treasuryStock;
  final double? accumulatedAmortization;
  final double nonCurrrentAssetsOther;
  final double? deferredLongTermAssetCharges;
  final double nonCurrentAssetsTotal;
  final double? capitalLeaseObligations;
  final double longTermDebtTotal;
  final double nonCurrentLiabilitiesOther;
  final double nonCurrentLiabilitiesTotal;
  final double? negativeGoodwill;
  final double? warrants;
  final double? preferredStockRedeemable;
  final double capitalSurpluse;
  final double liabilitiesAndStockholdersEquity;
  final double cashAndShortTermInvestments;
  final double propertyPlantAndEquipmentGross;
  final double propertyPlantAndEquipmentNet;
  final double? accumulatedDepreciation;
  final double netWorkingCapital;
  final double netInvestedCapital;
  final double commonStockSharesOutstanding;

  FinancialBalanceSheet({
    required this.date,
    required this.filingDate,
    required this.currencySymbol,
    required this.totalAssets,
    this.intangibleAssets,
    this.earningAssets,
    required this.otherCurrentAssets,
    required this.totalLiabilities,
    required this.totalStockholderEquity,
    this.deferredLongTermLiab,
    required this.otherCurrentLiab,
    required this.commonStock,
    required this.capitalStock,
    required this.retainedEarnings,
    this.otherLiab,
    this.goodWill,
    required this.otherAssets,
    required this.cash,
    required this.cashAndEquivalents,
    required this.totalCurrentLiabilities,
    required this.currentDeferredRevenue,
    required this.netDebt,
    required this.shortTermDebt,
    required this.shortLongTermDebt,
    required this.shortLongTermDebtTotal,
    required this.otherStockholderEquity,
    required this.propertyPlantEquipment,
    required this.totalCurrentAssets,
    required this.longTermInvestments,
    this.netTangibleAssets,
    required this.shortTermInvestments,
    required this.netReceivables,
    required this.longTermDebt,
    required this.inventory,
    required this.accountsPayable,
    this.totalPermanentEquity,
    this.noncontrollingInterestInConsolidatedEntity,
    this.temporaryEquityRedeemableNoncontrollingInterests,
    required this.accumulatedOtherComprehensiveIncome,
    this.additionalPaidInCapital,
    this.commonStockTotalEquity,
    this.preferredStockTotalEquity,
    this.retainedEarningsTotalEquity,
    this.treasuryStock,
    this.accumulatedAmortization,
    required this.nonCurrrentAssetsOther,
    this.deferredLongTermAssetCharges,
    required this.nonCurrentAssetsTotal,
    this.capitalLeaseObligations,
    required this.longTermDebtTotal,
    required this.nonCurrentLiabilitiesOther,
    required this.nonCurrentLiabilitiesTotal,
    this.negativeGoodwill,
    this.warrants,
    this.preferredStockRedeemable,
    required this.capitalSurpluse,
    required this.liabilitiesAndStockholdersEquity,
    required this.cashAndShortTermInvestments,
    required this.propertyPlantAndEquipmentGross,
    required this.propertyPlantAndEquipmentNet,
    this.accumulatedDepreciation,
    required this.netWorkingCapital,
    required this.netInvestedCapital,
    required this.commonStockSharesOutstanding,
  });

  factory FinancialBalanceSheet.fromJson(Map<String, dynamic> json) {
    return FinancialBalanceSheet(
      date: DateTime.parse(json['date']),
      filingDate: DateTime.parse(json['filing_date']),
      currencySymbol: json['currency_symbol'],
      totalAssets: double.parse(json['totalAssets']),
      intangibleAssets: json['intangibleAssets'] != null
          ? double.parse(json['intangibleAssets'])
          : null,
      earningAssets: json['earningAssets'] != null
          ? double.parse(json['earningAssets'])
          : null,
      otherCurrentAssets: double.parse(json['otherCurrentAssets']),
      totalLiabilities: double.parse(json['totalLiab']),
      totalStockholderEquity: double.parse(json['totalStockholderEquity']),
      deferredLongTermLiab: json['deferredLongTermLiab'] != null
          ? double.parse(json['deferredLongTermLiab'])
          : null,
      otherCurrentLiab: double.parse(json['otherCurrentLiab']),
      commonStock: double.parse(json['commonStock']),
      capitalStock: double.parse(json['capitalStock']),
      retainedEarnings: double.parse(json['retainedEarnings']),
      otherLiab:
          json['otherLiab'] != null ? double.parse(json['otherLiab']) : null,
      goodWill:
          json['goodWill'] != null ? double.parse(json['goodWill']) : null,
      otherAssets: double.parse(json['otherAssets']),
      cash: double.parse(json['cash']),
      cashAndEquivalents: double.parse(json['cashAndEquivalents']),
      totalCurrentLiabilities: double.parse(json['totalCurrentLiabilities']),
      currentDeferredRevenue: double.parse(json['currentDeferredRevenue']),
      netDebt: double.parse(json['netDebt']),
      shortTermDebt: double.parse(json['shortTermDebt']),
      shortLongTermDebt: double.parse(json['shortLongTermDebt']),
      shortLongTermDebtTotal: double.parse(json['shortLongTermDebtTotal']),
      otherStockholderEquity: double.parse(json['otherStockholderEquity']),
      propertyPlantEquipment: double.parse(json['propertyPlantEquipment']),
      totalCurrentAssets: double.parse(json['totalCurrentAssets']),
      longTermInvestments: double.parse(json['longTermInvestments']),
      netTangibleAssets: json['netTangibleAssets'] != null
          ? double.parse(json['netTangibleAssets'])
          : null,
      shortTermInvestments: double.parse(json['shortTermInvestments']),
      netReceivables: double.parse(json['netReceivables']),
      longTermDebt: double.parse(json['longTermDebt']),
      inventory: double.parse(json['inventory']),
      accountsPayable: double.parse(json['accountsPayable']),
      totalPermanentEquity: json['totalPermanentEquity'] != null
          ? double.parse(json['totalPermanentEquity'])
          : null,
      noncontrollingInterestInConsolidatedEntity:
          json['noncontrollingInterestInConsolidatedEntity'] != null
              ? double.parse(json['noncontrollingInterestInConsolidatedEntity'])
              : null,
      temporaryEquityRedeemableNoncontrollingInterests:
          json['temporaryEquityRedeemableNoncontrollingInterests'] != null
              ? double.parse(
                  json['temporaryEquityRedeemableNoncontrollingInterests'])
              : null,
      accumulatedOtherComprehensiveIncome:
          double.parse(json['accumulatedOtherComprehensiveIncome']),
      additionalPaidInCapital: json['additionalPaidInCapital'] != null
          ? double.parse(json['additionalPaidInCapital'])
          : null,
      commonStockTotalEquity: json['commonStockTotalEquity'] != null
          ? double.parse(json['commonStockTotalEquity'])
          : null,
      preferredStockTotalEquity: json['preferredStockTotalEquity'] != null
          ? double.parse(json['preferredStockTotalEquity'])
          : null,
      retainedEarningsTotalEquity: json['retainedEarningsTotalEquity'] != null
          ? double.parse(json['retainedEarningsTotalEquity'])
          : null,
      treasuryStock: json['treasuryStock'] != null
          ? double.parse(json['treasuryStock'])
          : null,
      accumulatedAmortization: json['accumulatedAmortization'] != null
          ? double.parse(json['accumulatedAmortization'])
          : null,
      nonCurrrentAssetsOther: double.parse(json['nonCurrrentAssetsOther']),
      deferredLongTermAssetCharges: json['deferredLongTermAssetCharges'] != null
          ? double.parse(json['deferredLongTermAssetCharges'])
          : null,
      nonCurrentAssetsTotal: double.parse(json['nonCurrent AssetsTotal']),
      capitalLeaseObligations: json['capitalLeaseObligations'] != null
          ? double.parse(json['capitalLeaseObligations'])
          : null,
      longTermDebtTotal: double.parse(json['longTermDebtTotal']),
      nonCurrentLiabilitiesOther:
          double.parse(json['nonCurrentLiabilitiesOther']),
      nonCurrentLiabilitiesTotal:
          double.parse(json['nonCurrentLiabilitiesTotal']),
      negativeGoodwill: json['negativeGoodwill'] != null
          ? double.parse(json['negativeGoodwill'])
          : null,
      warrants:
          json['warrants'] != null ? double.parse(json['warrants']) : null,
      preferredStockRedeemable: json['preferredStockRedeemable'] != null
          ? double.parse(json['preferredStockRedeemable'])
          : null,
      capitalSurpluse: double.parse(json['capitalSurpluse']),
      liabilitiesAndStockholdersEquity:
          double.parse(json['liabilitiesAndStockholdersEquity']),
      cashAndShortTermInvestments:
          double.parse(json['cashAndShortTermInvestments']),
      propertyPlantAndEquipmentGross:
          double.parse(json['propertyPlantAndEquipmentGross']),
      propertyPlantAndEquipmentNet:
          double.parse(json['propertyPlantAndEquipmentNet']),
      accumulatedDepreciation: json['accumulatedDepreciation'] != null
          ? double.parse(json['accumulatedDepreciation'])
          : null,
      netWorkingCapital: double.parse(json['netWorkingCapital']),
      netInvestedCapital: double.parse(json['netInvestedCapital']),
      commonStockSharesOutstanding:
          double.parse(json['commonStockSharesOutstanding']),
    );
  }

  factory FinancialBalanceSheet.fromMap(Map<String, dynamic> map) {
    return FinancialBalanceSheet.fromJson(map);
  }
}
