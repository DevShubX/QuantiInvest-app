import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:quantiinvest_app/components/StockPriceCardSmall.dart';
import 'package:http/http.dart' as http;
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:quantiinvest_app/constants/constants.dart';

class StockAddScreen extends StatefulWidget {
  const StockAddScreen({super.key, required this.stockData});

  final stockData;

  @override
  State<StockAddScreen> createState() => _StockAddScreenState();
}

class _StockAddScreenState extends State<StockAddScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool _hasErrorText = false;
  String _errorText = "";
  dynamic realTimeData;
  bool isLoading = false;
  bool isSubmitting = false;

  Future getStockInfo(String stockName) async {
    setState(() {
      isLoading = true;
    });
    http.Response response;

    response = await http.get(Uri.parse(
        'https://eodhd.com/api/real-time/${stockName}?api_token=demo&fmt=json'));

    if (response.statusCode == 200) {
      setState(() {
        realTimeData = json.decode(response.body);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future addStock(dynamic data) async {
    http.Response response;

    print(data);

    setState(() {
      isSubmitting = true;
    });

    response = await http.post(Uri.parse('$API_URL/user_portfolio/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data);

    final body = json.decode(response.body);

    if (response.statusCode == 200) {
      if (body['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.colors.qtBlue,
            content: Text(
              body['msg'],
              style: TextStyle(
                  fontFamily: 'Gilroy-Medium', color: AppColors.colors.lkWhite),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.colors.lkRed,
            content: Text(
              body['errmsg'],
              style: TextStyle(
                  fontFamily: 'Gilroy-Medium', color: AppColors.colors.lkWhite),
            ),
          ),
        );
      }
    }

    setState(() {
      isSubmitting = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getStockInfo('${widget.stockData['code']}.${widget.stockData['exchange']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Stock",
          style: TextStyle(fontFamily: 'Gilroy-Bold'),
        ),
      ),
      body: SingleChildScrollView(
        child: !isLoading
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    StockPriceCardSmall(
                      stockData: widget.stockData,
                      imageUrl: widget.stockData['image'],
                      companyName: widget.stockData['name'],
                      stockExchange:
                          '${widget.stockData['code']}.${widget.stockData['exchange']}',
                      open: realTimeData['open'],
                      high: realTimeData['high'],
                      low: realTimeData['low'],
                      close: realTimeData['close'],
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: 16.sp,
                                      color: AppColors.colors.lkWhite),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color:
                                        const Color.fromARGB(255, 27, 27, 27),
                                  ),
                                  child: TextFormField(
                                    /// Amount
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter an amount";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => setState(() {
                                      _hasErrorText = false;
                                      _errorText = "";
                                    }),
                                    controller: _amountController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                        fontFamily: "Gilroy-Medium",
                                        fontSize: 15.sp,
                                        color: AppColors.colors.lkWhite),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "e.g. 100",
                                      hintStyle: TextStyle(
                                          color: AppColors.colors.tkLightGrey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 20.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: 16.sp,
                                      color: AppColors.colors.lkWhite),
                                ),
                                Container(
                                  ///// Price Box
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  margin: EdgeInsets.only(top: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color:
                                        const Color.fromARGB(255, 27, 27, 27),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter a price";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => setState(() {
                                      _hasErrorText = false;
                                      _errorText = "";
                                    }),
                                    controller: _priceController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                        fontFamily: "Gilroy-Medium",
                                        fontSize: 15.sp,
                                        color: AppColors.colors.lkWhite),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: AppColors.colors.tkLightGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 20.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: 16.sp,
                                      color: AppColors.colors.lkWhite),
                                ),
                                Container(
                                  ///// Date Box
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  margin: EdgeInsets.only(top: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color:
                                        const Color.fromARGB(255, 27, 27, 27),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter a date";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () async {
                                      DateTime? pickDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2055),
                                      );

                                      if (pickDate != null) {
                                        setState(() {
                                          _dateController.text =
                                              DateFormat('MMM d,y')
                                                  .format(pickDate);
                                        });
                                      }
                                      setState(() {
                                        _hasErrorText = false;
                                        _errorText = "";
                                      });
                                    },
                                    controller: _dateController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                        fontFamily: "Gilroy-Medium",
                                        fontSize: 15.sp,
                                        color: AppColors.colors.lkWhite),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Tap to select date",
                                      hintStyle: TextStyle(
                                        color: AppColors.colors.tkLightGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _hasErrorText,
                            child: Container(
                              margin: EdgeInsets.only(top: 20.h),
                              width: double.maxFinite,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _errorText,
                                style: TextStyle(
                                  fontFamily: "Gilroy-Bold",
                                  color: AppColors.colors.lkRed,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                final userId =
                                    await storage.read(key: 'userId');
                                final data = jsonEncode(<String, dynamic>{
                                  "stockCode": widget.stockData['code'],
                                  "stockExchange": widget.stockData['exchange'],
                                  "companyName": widget.stockData['name'],
                                  "imgUrl":
                                      'https://eodhd.com/${widget.stockData['image']}',
                                  "quantity":
                                      double.parse(_amountController.text),
                                  "buyPrice":
                                      double.parse(_priceController.text),
                                  "date": _dateController.text,
                                  "userId": userId,
                                });

                                await addStock(data);
                                // await login(_emailController.text,
                                //     _passwordController.text);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 40.h),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: AppColors.colors.qtBlue,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: isSubmitting
                                  ? const CircularProgressIndicator.adaptive(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Gilroy-Bold',
                                          fontSize: 16.sp),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 500.h,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppColors.colors.qtBlue,
                ),
              ),
      ),
    );
  }
}
