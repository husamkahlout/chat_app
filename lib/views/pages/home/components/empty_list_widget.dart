import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../resources/colors_manager.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final double height;
  final Function()? onTap;
  const EmptyListWidget({
    Key? key,
    required this.text, required this.height, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        strokeWidth: 1.5,
        color: ColorsManager.neutral_70,
        radius: const Radius.circular(30),
        borderType: BorderType.RRect,
        dashPattern: [3.w],
        child: Container(
          // width: (screenWidth - 55) / 2,
          height: height,
          decoration: BoxDecoration(
              color: ColorsManager.neutral_20,
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, bottom: 12.h, top: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w800,
                          color: ColorsManager.neutral_100)),
                ),
                Align(
                  alignment: context.locale.toString() == "en"
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: ColorsManager.whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorsManager.secondaryColor.withOpacity(0.6),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: const Center(
                        child: Icon(
                      Icons.add,
                      size: 26,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
