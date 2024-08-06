import 'package:admin/models/products_models.dart';
import 'package:admin/provider/items_provider.dart';
import 'package:admin/widgets/products_widget.dart';
import 'package:admin/widgets/title_text.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreens extends StatefulWidget {
  static const routeName = "/SearchScreens";
  const SearchScreens({super.key});

  @override
  State<SearchScreens> createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  late TextEditingController txtSearch;
  @override
  void initState() {
    txtSearch = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    txtSearch.dispose();
    super.dispose();
  }

  List<ProductsModels> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ItemsCategory>(context);
    String? passesCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductsModels> productList = passesCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passesCategory);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: TitleText(
              label: passesCategory ?? "Search",
            ),
          ),
          body: productList.isEmpty
              ? const Center(
                  child: TitleText(label: "No found food"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: txtSearch,
                        decoration: InputDecoration(
                          hintText: "Search",
                          filled: true,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              txtSearch.clear();
                              FocusScope.of(context).unfocus();
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            productListSearch = productProvider.searchQuery(
                                searchText: txtSearch.text,
                                passedList: productList);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (txtSearch.text.isNotEmpty &&
                          productListSearch.isEmpty) ...[
                        const Center(
                          child: TitleText(
                            label: "No results found",
                            fS: 30,
                          ),
                        )
                      ],
                      Expanded(
                        child: DynamicHeightGridView(
                          itemCount: txtSearch.text.isNotEmpty
                              ? productListSearch.length
                              : productList.length,
                          builder: (context, index) {
                            return ProductsWidget(
                              productId: txtSearch.text.isNotEmpty
                                  ? productListSearch[index].productId
                                  : productList[index].productId,
                            );
                          },
                          crossAxisCount: 2,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
