import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget dividerVertical(double height) {
  return SizedBox(
    height: height,
    child: VerticalDivider(
      color: Colors.grey.withOpacity(0.5),
      thickness: 1,
      indent: 0,
      endIndent: 0,
      width: 10,
    ),
  );
}

Widget image(String link) {
  try {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), topLeft: Radius.circular(8)),
      child: CachedNetworkImage(
        useOldImageOnUrlChange: false,
        fit: BoxFit.cover,
        imageUrl: link,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                strokeWidth: 2,
              ),
              height: 5.w,
              width: 5.w,
            ),
          ),
        )),
        errorWidget: (context, url, error) => Image.asset(
          "images/no-pictures.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  } catch (e) {
    return Image.asset(
      "images/no-pictures.png",
      fit: BoxFit.cover,
    );
  }
}
