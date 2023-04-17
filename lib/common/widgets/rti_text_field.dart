import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';

class RtiTextField extends StatelessWidget with AppMixin {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String? hintText;
  const RtiTextField({Key? key, required this.controller, this.prefixIcon, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        controller: controller,
        style: theme.body(color: Colors.black),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? 'Employee Name',
            hintStyle: theme.body(color: const Color(0xff949C9E)),
            //hintStyle: theme.overline(color: Colors.black),
            prefixIcon: const Icon(
              Icons.person_2_outlined,
              color: Color(0xff1DA1F2),
            )),
      ),
    );
  }
}
