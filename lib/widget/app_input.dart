import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInput extends StatefulWidget {
  final FormFieldSetter onFiledSubmitedValue;
  final FormFieldValidator onValidator;
  final String hinit;
  final String label;
  final Icon icon;
  final TextInputType keyBoardType;
  final bool obscureText,
      enable,
      autoFocus,
      leftIcon,
      rightIcon,
      isFilled,
      otherColor;

  const AppInput(
      {Key? key,
      required this.onFiledSubmitedValue,
      required this.onValidator,
      this.hinit = 'Enter Value',
      this.obscureText = false,
      this.leftIcon = false,
      this.isFilled = true,
      this.icon = const Icon(Icons.email),
      this.rightIcon = false,
      this.otherColor = false,
      this.enable = true,
      required this.label, required this.keyBoardType, required this.autoFocus})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late bool passwordShow;

  void initState() {
    passwordShow = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyBoardType,
      validator: widget.onValidator,
      obscureText: passwordShow,
      decoration: InputDecoration(
        labelText: widget.label,
        fillColor: Colors.black,
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.h),
        filled: widget.isFilled,
        hintText: widget.hinit,
        enabled: widget.enable,
        prefixIcon: widget.leftIcon ? widget.icon : null,
        suffixIcon: widget.obscureText
            ? InkWell(
                onTap: () {
                  setState(() {
                    passwordShow = !passwordShow;
                  });
                },
                child: passwordShow
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.visibility_off))
            : null,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
      // obscureText: true,
      onChanged: widget.onFiledSubmitedValue,
    );
  }
}
