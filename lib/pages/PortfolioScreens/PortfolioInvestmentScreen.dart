import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:quantiinvest_app/constants/constants.dart';

class PortfolioInvestmentScreen extends StatefulWidget {
  const PortfolioInvestmentScreen({super.key});

  @override
  State<PortfolioInvestmentScreen> createState() =>
      _PortfolioInvestmentScreenState();
}

class _PortfolioInvestmentScreenState extends State<PortfolioInvestmentScreen> {
  List? stockList = [];
  List? uniqueStockCodes = [];
  List? realTimeValues = [];
  bool isLoading = false;
  final storage = const FlutterSecureStorage();

  Future getStocks() async {
    setState(() {
      isLoading = true;
    });
    final userId = await storage.read(key: 'userId');

    http.Response response;

    response = await http
        .get(Uri.parse('$API_URL/user_portfolio/getAll?userId=$userId'));

    final result = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        stockList = result['stockList'];
        uniqueStockCodes = result['uniqueStockCodes'];
      });
    }
    await _fetchStockData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getStocks();
    Timer.periodic(const Duration(minutes: 15), (timer) {
      getStocks();
    });
  }

  Future deleteStock(String stockId) async {
    await http.delete(Uri.parse('$API_URL/user_portfolio/remove?_id=$stockId'));
    getStocks();
  }

  Future getRealtimeStockData(String stockUniqeCode) async {
    http.Response response = await http.get(Uri.parse(
        'https://eodhd.com/api/real-time/$stockUniqeCode?api_token=demo&fmt=json'));
    final data = json.decode(response.body);
    return data;
  }

  Future _fetchStockData() async {
    List? tempList = [];
    for (String code in uniqueStockCodes!) {
      final data = await getRealtimeStockData(code);
      tempList.add({
        "uniqueCode": data['code'],
        "close": data['close'],
        "previousClose": data['previousClose'],
        "change": data['change'],
        "change_p": data['change_p'],
      });
    }
    setState(() {
      realTimeValues!.clear();
      realTimeValues!.addAll(tempList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: stockList!.isEmpty,
                  child: Container(
                    margin: EdgeInsets.only(top: 100.h),
                    child: Image.asset(
                      "assets/images/add-icon.png",
                      fit: BoxFit.cover,
                      height: 220.h,
                      width: 280.w,
                    ),
                  ),
                ),
                Visibility(
                  visible: stockList!.isEmpty,
                  child: Text(
                    "No data found",
                    style: TextStyle(
                      fontFamily: 'Gilroy-Bold',
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Visibility(
                  visible: !isLoading && stockList!.isNotEmpty,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5.h,
                        );
                      },
                      padding:
                          EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: stockList!.length,
                      itemBuilder: (context, index) {
                        final item = stockList![index];
                        var close = realTimeValues!.firstWhere((ele) =>
                                ele['uniqueCode'] ==
                                "${item['stockCode']}.${item['stockExchange']}")[
                            'close'];

                        var profitValue = (item['quantity'] * close) -
                            (item['quantity'] * item['buyPrice']);
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                    padding: EdgeInsets.only(bottom: 15.h),
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.red,
                                    icon: Icons.delete,
                                    onPressed: (context) {
                                      deleteStock(item['_id']);
                                    }),
                              ]),
                          child: Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              padding: EdgeInsets.only(
                                  top: 15.h,
                                  left: 10.w,
                                  right: 15.w,
                                  bottom: 15.h),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(193, 41, 39, 39),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.w,
                                            margin:
                                                EdgeInsets.only(right: 10.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    52, 0, 0, 0)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                '${item['imgUrl']}',
                                                width: 50.w,
                                                height: 50.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.network(
                                                      width: 50.w,
                                                      height: 50.h,
                                                      fit: BoxFit.cover,
                                                      'https://www.redhouseoriginals.com/wp-content/uploads/dark-placeholder.png');
                                                },
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator
                                                              .adaptive(),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                "${item['stockCode']}.${item['stockExchange']}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy-Bold',
                                                    fontSize: 13.sp,
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              SizedBox(
                                                width: 100.w,
                                                child: Text(
                                                  "${item['companyName']}",
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Medium',
                                                      fontSize: 10.sp,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              209,
                                                              209,
                                                              209)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                              visible: profitValue > 0,
                                              child: Icon(
                                                Icons.arrow_drop_up,
                                                color: AppColors.colors.lkGreen,
                                              )),
                                          Visibility(
                                              visible: profitValue <= 0,
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                color: AppColors.colors.lkRed,
                                              )),
                                          Text(
                                            '${profitValue.abs().toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Medium',
                                                fontSize: 14.sp,
                                                color: profitValue <= 0
                                                    ? AppColors.colors.lkRed
                                                    : AppColors.colors.lkGreen),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${item['quantity']}',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Medium',
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            " @ ",
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Medium',
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            '${item['buyPrice'].toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Medium',
                                              fontSize: 14.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${(item['quantity'] * item['buyPrice']).toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Medium',
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${close.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Medium',
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        '${(item['quantity'] * close).toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Medium',
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        );
                      }),
                )
              ],
            ),
          );
  }
}
