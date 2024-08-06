import 'package:admin/screens/inner_screens/edit_products_screens.dart';
import 'package:admin/screens/inner_screens/orders_screens.dart';
import 'package:admin/screens/inner_screens/search_screens.dart';
import 'package:admin/services/assets_manager.dart';
import 'package:flutter/material.dart';

class DashbroadBtnModels {
  final String text, imagePath;
  final Function onPressed;

  DashbroadBtnModels(
      {required this.text, required this.imagePath, required this.onPressed});
  static List<DashbroadBtnModels> dashbroadBtnList(BuildContext context) => [
        DashbroadBtnModels(
            text: "Add new products",
            imagePath: AssetsManager.cloud,
            onPressed: () {
              Navigator.pushNamed(context, EditorUpdateProducts.routeName);
            }),
        DashbroadBtnModels(
            text: "Inspect all products",
            imagePath: AssetsManager.shoppingCart,
            onPressed: () {
              Navigator.pushNamed(context, SearchScreens.routeName);
            }),
        DashbroadBtnModels(
            text: "View Orders",
            imagePath: AssetsManager.order,
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreenFree.routeName);
            })
      ];
}
