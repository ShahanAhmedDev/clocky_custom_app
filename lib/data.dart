
import 'package:clocky_custom_app/constants/theme_data.dart';
import 'package:clocky_custom_app/models/alarm_info.dart';

import 'enums.dart';
import 'models/menu_info.dart';

List<MenuInfo> menuList = [
MenuInfo(MenuType.clock,imageSource: 'assets/clock_icon.png',title: 'Clock'),
MenuInfo(MenuType.alarm,imageSource: 'assets/alarm_icon.png',title: 'Alarm'),
MenuInfo(MenuType.timer,imageSource: 'assets/timer_icon.png',title: 'Timer'),
MenuInfo(MenuType.stopwatch,imageSource: 'assets/stopwatch_icon.png',title: 'Stop Watch'),
];

List<AlarmInfo> alarms = [
  AlarmInfo('Shit', alarmDateTime: DateTime.now().add(Duration(hours: 1)),gradientColors: GradientColors.fire),
  AlarmInfo('Shit-2', alarmDateTime: DateTime.now(),gradientColors: GradientColors.sea),
  AlarmInfo('Shit-3', alarmDateTime: DateTime.now(),gradientColors: GradientColors.sky),
];