import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VideoShimmerEffect extends StatelessWidget {
  const VideoShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: ListView.builder(
          itemCount: 10, // Adjust the count based on your needs
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 35.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.w),
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
                        SizedBox(height: 5.h),
                        Container(
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
