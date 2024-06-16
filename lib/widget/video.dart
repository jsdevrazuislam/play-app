import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/constant/font.dart';
import 'package:play/widget/image.dart';

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String avatar;
  final String username;
  final String duration;
  const VideoCard(
      {Key? key,
      required this.avatar,
      required this.thumbnail,
      required this.title,
      required this.duration,
      required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Stack(
          children: [
            Container(
              height: 150.h,
              width: MediaQuery.of(context).size.width * 1,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
              child: AppImage(imageUrl: thumbnail),
            ),
            Positioned(
              bottom: 10.h,
              right: 10.w,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 14.w),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Text(duration),
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              imageUrl: avatar,
              height: 35.h,
              width: 40.w,
              fit: BoxFit.cover,
              borderRadius: 50.r,
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.sp, fontFamily: AppFonts.poppinsBold)),
                  Text(username,
                      style: TextStyle(
                          fontSize: 12.sp, fontFamily: AppFonts.poppinsRegular))
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
