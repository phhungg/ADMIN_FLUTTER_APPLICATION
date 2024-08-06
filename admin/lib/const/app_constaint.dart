import 'package:flutter/material.dart';

class AppConstaint {
  static const String productImageUrl =
      "https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/444769900_482059711007409_8898910557362404226_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=T7ZbTCCe4GIQ7kNvgHMbwj7&_nc_ht=scontent.fsgn5-6.fna&oh=00_AYDXP44DLvJzzqtKKMnwqNGc5nXfjGtPt9JdrhWCezLrPA&oe=66ABD0C1";
  static List<String> categoryList = [
    "Hamburgers",
    "Spaghettis",
    "Salads",
    "Desserts",
    "Drinks",
    "Sandwiches",
    "Coffees",
    "Ice Creams"
  ];
  static List<DropdownMenuItem<String>>? get itemDropdownlist {
    List<DropdownMenuItem<String>>? menuItems =
        List<DropdownMenuItem<String>>.generate(
      categoryList.length,
      (index) => DropdownMenuItem(
        value: categoryList[index],
        child: Text(
          categoryList[index],
        ),
      ),
    );
    return menuItems;
  }
}
