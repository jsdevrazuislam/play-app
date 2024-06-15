import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VideoShimmerEffect extends StatelessWidget {
  const VideoShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 700.h,
        margin: EdgeInsets.only(top: 10.h),
        child: ListView.builder(
          itemCount: 10, // Adjust the count based on your needs
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          height: 8.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
