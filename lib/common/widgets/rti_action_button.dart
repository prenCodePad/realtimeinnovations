import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';

class RtiActionButton extends StatelessWidget with AppMixin {
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  const RtiActionButton({
    Key? key,
    this.onTap,
    this.backgroundColor,
    required this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xff1DA1F2),
          borderRadius: BorderRadius.circular(6),
        ),
        width: 73,
        height: 40,
        child: Text(text,
            style: theme.button(
              color: textColor ?? Colors.white,
            )),
      ),
    );
  }
}
