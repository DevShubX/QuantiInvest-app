import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:quantiinvest_app/constants/constants.dart';

class StockPriceCardSmall extends StatelessWidget {
  const StockPriceCardSmall({
    super.key,
    required this.stockData,
    this.imageUrl,
    this.stockExchange,
    this.companyName,
    this.low,
    this.high,
    this.open,
    this.close,
  });
  final stockData;
  final imageUrl;
  final stockExchange;
  final companyName;
  final low;
  final high;
  final open;
  final close;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding:
            EdgeInsets.only(top: 15.h, left: 10.w, right: 15.w, bottom: 15.h),
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
                      color: const Color.fromARGB(52, 0, 0, 0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '$EODHD_URL/$imageUrl',
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                            'https://www.redhouseoriginals.com/wp-content/uploads/dark-placeholder.png');
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "$stockExchange",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Bold',
                          fontSize: 13.sp,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        "$companyName",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Gilroy-Medium',
                            fontSize: 10.sp,
                            color: const Color.fromARGB(255, 209, 209, 209)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '$open',
                        style: TextStyle(
                            fontFamily: 'Gilroy-Medium',
                            color: AppColors.colors.lkDarkGrey),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        '$close',
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('$low',
                          style: TextStyle(
                              fontFamily: 'Gilroy-Medium',
                              color: AppColors.colors.qtBlue)),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text('$high',
                          style: TextStyle(
                              fontFamily: 'Gilroy-Medium',
                              color: AppColors.colors.lkSaffron))
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
