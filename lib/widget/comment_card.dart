import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/user_controller.dart';
import 'package:play/controller/video_controller.dart';

class CommentCard extends StatelessWidget {

  final String username;
  final String content;
  final String createdAt;
  final String avatar;
  final String id;

  const CommentCard({
    Key? key,
    required this.avatar,
    required this.content,
    required this.createdAt,
    required this.username,
    required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoController videoController = Get.put(VideoController());
    final UserController userController = Get.put(UserController());
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: avatar != ''
                ? NetworkImage(avatar)
                : const AssetImage('lib/assets/placeholder_avatar.png') as ImageProvider,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('@$username', style: TextStyle(fontFamily: AppFonts.poppinsRegular, fontSize: 12.sp)),
                    Text(videoController.getTimeAgo(createdAt), style: TextStyle(fontFamily: AppFonts.poppinsRegular, fontSize: 12.sp))
                  ],
                ),
                SizedBox(width: 5.w),
                Text(content,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.poppinsRegular
                ),
                ),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.thumb_up_alt_outlined, size: 18.sp), onPressed: (){},),
                    Text('200', style: TextStyle(fontFamily: AppFonts.poppinsRegular)),
                    SizedBox(width: 10.w),
                    Text('200', style: TextStyle(fontFamily: AppFonts.poppinsRegular)),
                    IconButton(icon: Icon(Icons.thumb_down_alt_outlined, size: 18.sp), onPressed: (){},),
                    if(userController.userId == id)
                    IconButton(icon: Icon(Icons.delete, size: 18.sp, color: Colors.red), onPressed: (){},),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
