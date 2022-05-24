import 'package:clocky_custom_app/constants/theme_data.dart';
import 'package:flutter/painting.dart';

class AlarmInfo{
  DateTime alarmDateTime;
  String description;
  bool? isActive;
  List<Color> gradientColors;
  AlarmInfo(this.description, {required this.alarmDateTime, required this.gradientColors});


}