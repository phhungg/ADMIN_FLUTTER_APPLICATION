import 'package:admin/const/theme_data.dart';
import 'package:admin/provider/items_provider.dart';
import 'package:admin/provider/order_provider.dart';
import 'package:admin/provider/theme_provider.dart';
import 'package:admin/screens/inner_screens/dashbroad_screens.dart';
import 'package:admin/screens/inner_screens/edit_products_screens.dart';
import 'package:admin/screens/inner_screens/orders_screens.dart';
import 'package:admin/screens/inner_screens/search_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemsCategory(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Home Shop Admin",
            theme: Styles.themeData(
                isDarkTheme: themeProvider.getIsdarkTheme, context: context),
            home: const DashbroadScreens(),
            routes: {
              OrdersScreenFree.routeName: (context) => const OrdersScreenFree(),
              SearchScreens.routeName: (context) => const SearchScreens(),
              EditorUpdateProducts.routeName: (context) =>
                  const EditorUpdateProducts(),
            },
          );
        },
      ),
    );
  }
}
