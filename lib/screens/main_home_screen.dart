import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/home_list_controller.dart';
import 'package:play/widget/app_bar.dart';
import 'package:play/widget/loader/shimmer_effect_video.dart';
import 'package:play/widget/video.dart';
import 'package:shimmer/shimmer.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final HomeListController listController = Get.put(HomeListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
          child: Column(
            children: [
              /* 
                ---------------------------- Added Video List Here ---------------------------
              */
              Container(
                height: 25.h,
                child: Obx((){
                  return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listController.isLoading.value ? 10 : listController.categories.length,
                  itemBuilder: (context, index) {
                    return listController.isLoading.value ? Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white,
                          ),
                        ),
                      ) : GestureDetector(onTap: () {
                      listController.changeSelectIndex(index, listController.categories[index].sId);
                    }, child: Obx(() {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                            color: listController.selectedIndex != index
                                ? Color.fromARGB(27, 232, 229, 229)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Center(
                          child: Text(
                            listController.categories[index].content.toString(),
                            style: TextStyle(
                                color: listController.selectedIndex != index
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: AppFonts.poppinsRegular,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }));
                  },
                );
                }),
              ),
              SizedBox(height: 10.h),
              /* 
                --------------------- Render All Videos ---------------------------
              */
              Expanded(
                child: PagedListView<int, dynamic>(
                  pagingController: listController.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<dynamic>(
                    itemBuilder: (context, video, index) => VideoCard(
                      title: video.title.toString(),
                      avatar: video.owner!.avatar.toString(),
                      thumbnail: video.thumbnail.toString(),
                      username: video.owner!.username.toString(),
                      duration: video.duration.toString(),
                      videoId: video.sId.toString(),
                      videoUrl: video.videoFile.toString(),
                      channelId: video.owner!.sId.toString(),
                    ),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const VideoShimmerEffect(),
                    newPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    noItemsFoundIndicatorBuilder: (_) =>
                        const Center(child: Text('No videos found')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
