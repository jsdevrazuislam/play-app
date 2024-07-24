import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/user_controller.dart';
import 'package:play/controller/video_controller.dart';
import 'package:play/routes/route_constant.dart';
import 'package:play/widget/app_bar.dart';
import 'package:play/widget/comment_section.dart';
import 'package:play/widget/image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> args;
  const VideoDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String videoId = args['videoId'];
    final String videoUrl = args['videoUrl'];
    final VideoController videoController = Get.put(VideoController());
    final UserController userController = Get.put(UserController());
    videoController.initializeVideo(videoUrl);

    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 
              --------------------- Video with Thumbnail  ---------------------------
            */
              Obx(() {
                if (videoController.errorMessage.isNotEmpty) {
                  return Text(videoController.errorMessage.value,
                      style: TextStyle(color: Colors.red));
                }
                return videoController.isInitialized.value
                    ? Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 170.h,
                            width: double.infinity,
                            child: videoController.isPlaying.value
                                ? AspectRatio(
                                    aspectRatio: videoController
                                        .videoPlayerController
                                        .value
                                        .aspectRatio,
                                    child: VideoPlayer(
                                        videoController.videoPlayerController),
                                  )
                                : Container(
                                    height: 150.h,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: AppImage(
                                        imageUrl: videoController
                                            .video.value.thumbnail
                                            .toString()),
                                  ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            width: MediaQuery.of(context).size.width * 1,
                            child: _buildVideoControls(
                                videoController, context), //Icon
                          ),
                        ],
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 170.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white,
                          ),
                        ),
                      );
              }),
              /* 
              --------------------- Video Details ---------------------------
            */
              SizedBox(height: 10.h),
              Obx(() {
                return Text(
                  videoController.video.value.title.toString(),
                  style: TextStyle(
                      fontFamily: AppFonts.poppinsRegular,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp),
                );
              }),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Obx(() {
                    return Text(
                        "${videoController.video.value.views.toString()} Views");
                  }),
                  SizedBox(width: 5.w),
                  Obx(() {
                    return Text(videoController.getTimeAgo(
                        videoController.video.value.createdAt.toString()));
                  }),
                  InkWell(
                    child: Text(' ...more'),
                    onTap: () {
                      print('object');
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              /* 
              --------------------- Channel Information ---------------------------
            */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() {
                        final avatarUrl = videoController
                            .video.value.owner?.avatar
                            ?.toString();

                        // Check if the avatar URL is valid
                        if (avatarUrl != null &&
                            avatarUrl.isNotEmpty &&
                            Uri.parse(avatarUrl).isAbsolute) {
                          return CircleAvatar(
                            backgroundImage: NetworkImage(avatarUrl),
                          );
                        } else {
                          return const CircleAvatar(
                            // Provide a placeholder image when the avatar URL is invalid
                            backgroundImage:
                                AssetImage('lib/assets/placeholder_avatar.png'),
                          );
                        }
                      }),
                      SizedBox(width: 5.w),
                      Obx(() {
                        return Text(videoController.video.value.owner!.username
                            .toString());
                      }),
                      SizedBox(width: 10.w),
                      Obx(() {
                        return Text(videoController
                            .totalChannelSubscribersCount.value
                            .toString());
                      }),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        videoController.toggleSubscriber(
                            videoController.video.value.owner?.sId);
                      },
                      child: Obx(() => Text(
                        videoController.isSubscribed.value ? 'Unsubscribe' : 'Subscribe'
                      ))),
                ],
              ),
              SizedBox(height: 10.h),
              /* 
              --------------------- Like And Dislike ---------------------------
            */
              Container(
                width: 130.w,
                padding: EdgeInsets.symmetric(horizontal: 1.h),
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (userController.accessToken != '')
                            videoController.handleToggleLike(videoId, "like");
                          else
                            _dialogBuilder(context);
                        },
                        icon: Obx(() => Icon(
                            videoController.isLike.value
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                            size: 25.sp))),
                    Obx(() => Text(videoController.likeCount.value.toString(),
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBold,
                            fontSize: 14.sp))),
                    SizedBox(width: 10.w),
                    Obx(() => Text(
                        videoController.dislikeCount.value.toString(),
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBold,
                            fontSize: 14.sp))),
                    IconButton(
                        onPressed: () {
                          if (userController.accessToken != '') {
                            videoController.handleToggleLike(
                                videoId, "dislike");
                          } else {
                            _dialogBuilder(context);
                          }
                        },
                        icon: Obx(() => Icon(
                            videoController.isDislike.value
                                ? Icons.thumb_down
                                : Icons.thumb_down_alt_outlined,
                            size: 25.sp)))
                  ],
                ),
              ),
              /* 
              --------------------- Comments ---------------------------
            */
              SizedBox(height: 20.h),
              Obx(() {
                return userController.accessToken.value != ''
                    ? TextFormField(
                        keyboardType: TextInputType.text,
                        controller: videoController.commentController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter email';
                        },
                        decoration: InputDecoration(
                          labelText: 'Add Comment',
                          fillColor: Colors.black,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.h),
                          filled: true,
                          hintText: 'Add Comment',
                          enabled: true,
                          suffixIcon: InkWell(
                            child: const Icon(Icons.send),
                            onTap: () {
                              videoController.createComment(videoId);
                            },
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        // obscureText: true,
                        onChanged: (value) {
                          videoController.comment.value = value;
                        },
                      )
                    : Center(
                        child: Text(
                          'Please login to post your comment',
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsRegular,
                              fontSize: 16.sp),
                        ),
                      );
              }),
              SizedBox(height: 20.h),
              /* 
              --------------------- All Comments Render Here ---------------------------
            */
              Obx(() {
                return videoController.comments.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Center(
                          child: Text(
                            "No Comments Found",
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsBold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      )
                    : VideoCommentSection(
                        content: videoController.comments[0].content.toString(),
                        avatar: videoController.comments[0].owner!.avatar
                            .toString(),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildVideoControls(
    VideoController videoController, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Obx(() {
        return Container(
          padding: EdgeInsets.zero,
          height: 5.h,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
                trackHeight: 5.h,
                thumbColor: Colors.transparent,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)),
            child: Slider(
              value: videoController.position.value.inSeconds.toDouble(),
              max: videoController.duration.value.inSeconds.toDouble(),
              activeColor: Colors.red,
              onChanged: (value) {
                videoController.videoPlayerController
                    .seekTo(Duration(seconds: value.toInt()));
              },
            ),
          ),
        );
      }),
      Obx(() {
        final position = videoController.position.value;
        final duration = videoController.duration.value;
        return Row(
          children: [
            Text(_formatDuration(position)),
            const Text(" / "),
            Text(_formatDuration(duration)),
            Obx(() {
              return IconButton(
                icon: Icon(
                  videoController.isPlaying.value
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: videoController.playPauseVideo,
              );
            }),
          ],
        );
      }),
    ],
  );
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sign In before to achieve this functionality'),
        content: const Text('Sign in to make your opinion count.'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Sign In'),
            onPressed: () {
              Get.offNamed(RoutesName.loginScreen);
            },
          ),
        ],
      );
    },
  );
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes.toString().padLeft(2, '0');
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
