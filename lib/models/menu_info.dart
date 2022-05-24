import 'package:clocky_custom_app/enums.dart';
import 'package:flutter/material.dart';

class MenuInfo extends ChangeNotifier{
  late MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(this.menuType,{required this.title,required this.imageSource});


  updateMenu(MenuInfo info){
    this.menuType = info.menuType;
    this.imageSource = info.imageSource;
    this.title = info.title;


    notifyListeners();
  }



}