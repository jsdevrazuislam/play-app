import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/video_controller.dart';
import 'package:get/get.dart';

class VideoComment extends StatelessWidget {
  final String content;
  final String avatar;

  VideoComment({Key? key, required this.content, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments 446',
            style: TextStyle(
              fontFamily: AppFonts.poppinsRegular,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 7.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (avatar != '' &&
                  avatar.isNotEmpty &&
                  Uri.parse(avatar).isAbsolute)
                CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                )
              else
                const CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/placeholder_avatar.png'),
                ),
              SizedBox(width: 5.h),
              Expanded(
                child: Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: AppFonts.poppinsRegular,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
