import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Icon(Icons.flash_on, size: 30.w, color: Color(0xffE50202)),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () => {print('object')},
                icon: Icon(
                  Icons.search,
                  size: 25.w,
                ),
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/92.jpg"),
              ),
            ],
          ),
        ),
      ],
      elevation: 0, // Remove elevation to maintain flat design
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.3), // Border height
        child: Container(
          height: 0.3,
          color: Colors.grey, // Border color
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1.0);
}