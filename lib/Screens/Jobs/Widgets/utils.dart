import 'package:flutter/material.dart';
import 'dart:io';

class Utils {
  static String getDate() {

    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final date = DateTime.now().day;
    
    String dateToday = year.toString() +" / "+ month.toString() +" / "+ date.toString();

    print(dateToday);

    return dateToday;
  }
}
