import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GradientBtn extends StatelessWidget {
  final LinearGradient gradient;
  final String text;
  final VoidCallback onpress;
  const GradientBtn({
    super.key,
    required this.gradient,
    required this.text,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        elevation: 4,

        padding: EdgeInsets.zero, // Remove default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: Colors.transparent, // Required for Ink to show
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class GradientBtnIcon extends StatelessWidget {
  final LinearGradient gradient;
  final Icon icon;
  final VoidCallback onpress;
  const GradientBtnIcon({
    super.key,
    required this.gradient,
    required this.icon,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: EdgeInsets.zero, // Remove default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: Colors.transparent, // Required for Ink to show
        shadowColor: Colors.transparent,
      ),
      label: const SizedBox.shrink(),
      icon: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: const [],
          borderRadius: BorderRadius.circular(40),
        ),
        child: Container(
          alignment: Alignment.center,
          height: AppSize.appheight * .07,
          width: AppSize.appheight * .07,
          child: icon,
        ),
      ),
    );
  }
}

class GradientBtnwithPrefix extends StatelessWidget {
  final LinearGradient gradient;
  final String text;
  final VoidCallback onpress;
  const GradientBtnwithPrefix({
    super.key,
    required this.gradient,
    required this.text,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .04),
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          elevation: 10,

          padding: EdgeInsets.zero, // Remove default padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: Colors.transparent, // Required for Ink to show
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            //    color: Colors.grey,
            gradient: gradient,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Container(
            width: AppSize.appwidth,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.star),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
