import 'package:clocky_custom_app/enums.dart';
import 'package:clocky_custom_app/models/menu_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuProvider = ChangeNotifierProvider<MenuInfo>((ref){
  return MenuInfo(MenuType.alarm, imageSource: '',title: '');
});