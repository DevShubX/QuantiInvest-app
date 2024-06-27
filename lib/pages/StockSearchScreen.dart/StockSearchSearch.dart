import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:quantiinvest_app/constants/constants.dart';
import 'package:quantiinvest_app/pages/StockAddScreen.dart/StockAddScreen.dart';

class StockSearchScreen extends StatefulWidget {
  const StockSearchScreen({super.key});

  @override
  State<StockSearchScreen> createState() => _StockSearchScreenState();
}

class _StockSearchScreenState extends State<StockSearchScreen> {
  TextEditingController search_controller = TextEditingController();
  bool isLoading = false;
  List? data = [];

  Future getStockResults(String query) async {
    setState(() {
      isLoading = true;
    });
    http.Response response;

    response = await http.get(Uri.parse('$EODHD_SEARCH_API/?q=$query'));

    setState(() {
      data = json.decode(response.body);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade800),
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(179, 27, 27, 27),
              ),
              child: TextFormField(
                  onFieldSubmitted: (name) async {
                    await getStockResults(name);
                  },
                  controller: search_controller,
                  cursorColor: const Color.fromARGB(255, 190, 185, 185),
                  readOnly: false,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(fontFamily: 'Gilroy-Medium'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type AAPL or Apple as an example",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            search_controller.clear();
                            // Anime = [];
                            // isLoading = true;
                          });
                        },
                        icon: const Icon(Icons.clear),
                        color: AppColors.colors.tkLightGrey),
                    prefixIcon: Image.asset(
                      'assets/images/search-icon-32.png',
                      width: 32,
                      height: 32,
                    ),
                  )),
            ),
            Visibility(
                visible: isLoading,
                child: Container(
                  height: 500.h,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColors.colors.qtBlue,
                  ),
                )),
            Visibility(
              visible: !isLoading,
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final item = data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StockAddScreen(
                              stockData: item,
                              
                            ),
                          ),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          padding: EdgeInsets.only(
                              top: 15.h, left: 10.w, right: 15.w, bottom: 15.h),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(193, 41, 39, 39),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    margin: EdgeInsets.only(right: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            const Color.fromARGB(52, 0, 0, 0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        '$EODHD_URL/${item['image']}',
                                        width: 50.w,
                                        height: 50.h,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.network(
                                              width: 50.w,
                                              height: 50.h,
                                              fit: BoxFit.cover,
                                              'https://www.redhouseoriginals.com/wp-content/uploads/dark-placeholder.png');
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        "${item['code']}.${item['exchange']}",
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
                                          "${item['name']}",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Medium',
                                              fontSize: 10.sp,
                                              color: const Color.fromARGB(
                                                  255, 209, 209, 209)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${item['open']}',
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Medium',
                                              color:
                                                  AppColors.colors.lkDarkGrey),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          '${item['close']}',
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Medium',
                                              color: AppColors.colors.lkGreen),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${item['low']}',
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Medium',
                                                color:
                                                    AppColors.colors.qtBlue)),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text('${item['high']}',
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Medium',
                                                color:
                                                    AppColors.colors.lkSaffron))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
