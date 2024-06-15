import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String avatar;
  final String username;
  const VideoCard(
      {Key? key,
      required this.avatar,
      required this.thumbnail,
      required this.title,
      required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Container(
          height: 150.h,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r), color: Colors.red),
          child: Image(
            image: NetworkImage(thumbnail),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                avatar,
                height: 40.h,
                width: 40.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 5.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(title), Text(username)],
            )
          ],
        )
      ],
    );
  }
}
