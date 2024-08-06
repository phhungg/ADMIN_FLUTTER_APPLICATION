import 'package:admin/models/dashbroad_btn_models.dart';
import 'package:admin/provider/theme_provider.dart';
import 'package:admin/services/assets_manager.dart';
import 'package:admin/widgets/dashboard_btn_widgets.dart';
import 'package:admin/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashbroadScreens extends StatefulWidget {
  static const routeName = "/DashBoardScreens";
  const DashbroadScreens({super.key});

  @override
  State<DashbroadScreens> createState() => _DashbroadScreensState();
}

class _DashbroadScreensState extends State<DashbroadScreens> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(
          label: "Dash Board Screens",
          fS: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.admin),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.setDarkTheme(
                  themeValue: !themeProvider.getIsdarkTheme);
            },
            icon: Icon(
              themeProvider.getIsdarkTheme ? Icons.light_mode : Icons.dark_mode,
            ),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: List.generate(
            3,
            (index) => Padding(
                  padding: EdgeInsets.all(8),
                  child: DashboardBtnWidgets(
                    imagePath:
                        DashbroadBtnModels.dashbroadBtnList(context)[index]
                            .imagePath,
                    title: DashbroadBtnModels.dashbroadBtnList(context)[index]
                        .text,
                    onPressed:
                        DashbroadBtnModels.dashbroadBtnList(context)[index]
                            .onPressed,
                  ),
                )),
      ),
    );
  }
}
