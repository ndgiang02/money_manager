import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_manager/widgets/screen_widgets/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screen_widgets/detail/detail_screen.dart';
import 'package:money_manager/widgets/screen_widgets/list_item/list_item_screen.dart';
import 'package:money_manager/widgets/screen_widgets/login/login_screen.dart';
import 'package:money_manager/widgets/screen_widgets/setting/setting_screen.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  switch(settings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case ListItemScreen.route:
      return MaterialPageRoute(builder: (context) => ListItemScreen());
    case DetailScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case AddEditScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}