import 'package:flutter/material.dart';

class ShortScreen extends StatelessWidget {
  const ShortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: Text("Short Video Screen"),
      ),
    );
  }
}