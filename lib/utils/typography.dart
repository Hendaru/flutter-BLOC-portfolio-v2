import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lime_commerce/utils/colors.dart';
import 'package:sizer/sizer.dart';

TextStyle titleProductTextStyle = GoogleFonts.ibmPlexSans(
    textStyle: TextStyle(
        fontSize: 10.sp,
        color: primaryColor,
        letterSpacing: 0,
        fontWeight: FontWeight.normal));

TextStyle subTitleProductTextStyle = GoogleFonts.ibmPlexSans(
    textStyle: TextStyle(
        fontSize: 10.sp,
        color: subPrimaryColor,
        letterSpacing: 0,
        fontWeight: FontWeight.normal));

TextStyle discountProductTextStyle = GoogleFonts.ibmPlexSans(
    textStyle: TextStyle(
        fontSize: 8.sp,
        color: priceDiscontColor,
        letterSpacing: 0,
        fontWeight: FontWeight.w700));

TextStyle priceProductTextStyle = GoogleFonts.ibmPlexSans(
    textStyle: TextStyle(
        fontSize: 11.sp,
        color: primaryColor,
        letterSpacing: 0,
        fontWeight: FontWeight.w700));

TextStyle priceLineThroughProductTextStyle = GoogleFonts.ibmPlexSans(
    textStyle: TextStyle(
        decoration: TextDecoration.lineThrough,
        fontSize: 9.sp,
        color: primaryColor,
        letterSpacing: 0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.normal));
