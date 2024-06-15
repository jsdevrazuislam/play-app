import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/home_list_controller.dart';
import 'package:play/widget/app_bar.dart';
import 'package:play/widget/loader/shimmer_effect_video.dart';
import 'package:play/widget/video.dart';

final lists = [
  "All",
  "Something",
  "Javascript",
  "Typescript",
  "React.js",
  "Next.js",
  "English Tutorial"
];

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                /* 
                  ---------------------------- Added Video List Here ---------------------------
                */
                Container(
                  height: 25.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lists.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(onTap: () {
                        listController.changeSelectIndex(index);
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
                              lists[index],
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
                  ),
                ),
                SizedBox(height: 10.h),
                /* 
                  --------------------- Render All Videos ---------------------------
                */
                Obx(() {
                  if (listController.isLoading.value) {
                    return const VideoShimmerEffect();
                  } else if (listController.videoLists.isEmpty) {
                    return Center(child: Text('No videos found.'));
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height * 1,
                      child: ListView.builder(
                        itemCount: listController.videoLists.length,
                        itemBuilder: (context, index) {
                          final video = listController.videoLists[index];
                          return VideoCard(
                            title: video.title.toString(),
                            avatar: video.owner!.avatar.toString(),
                            thumbnail: video.thumbnail.toString(),
                            username: video.owner!.username.toString(),
                          );
                        },
                      ),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}



