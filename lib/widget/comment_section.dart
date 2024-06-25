import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/home_list_controller.dart';
import 'package:play/controller/video_controller.dart';
import 'package:play/models/comments_model.dart';
import 'package:play/widget/comment_card.dart';

class VideoCommentSection extends StatelessWidget {
  final String content;
  final String avatar;

  VideoCommentSection({
    Key? key,
    required this.content,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoController videoController = Get.put(VideoController());

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        onTap: () {
          _showBottomSheet(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
                  'Comments ${videoController.totalComments.value}',
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsRegular,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                )),
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
                    backgroundImage:
                        AssetImage('lib/assets/placeholder_avatar.png'),
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
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  final VideoController videoController = Get.put(VideoController());
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10.h),
          height: 400.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: AppFonts.poppinsBlack,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 25.sp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: PagedListView<int, Comments>(
                  pagingController: videoController.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Comments>(
                    itemBuilder: (context, comment, index) {
                      videoController
                          .fetchCommentLikes(comment.sId.toString());

                      return Obx(() {
                        final likesData = videoController
                            .commentLikesCache[comment.sId.toString()];

                            print("likesData from comment");
                        return CommentCard(
                          username: comment.owner!.username.toString(),
                          avatar: comment.owner!.avatar.toString(),
                          content: comment.content.toString(),
                          createdAt: comment.createdAt.toString(),
                          id: comment.owner!.sId.toString(),
                          totalLikes: likesData?['totalLike'] ?? 0,
                          totalDislikes: likesData?['totalDislike'] ?? 0,
                        );
                      });
                    },
                    firstPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    noItemsFoundIndicatorBuilder: (_) =>
                        const Center(child: Text('No comment found')),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
