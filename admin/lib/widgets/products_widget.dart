import 'package:admin/provider/items_provider.dart';
import 'package:admin/screens/inner_screens/edit_products_screens.dart';
import 'package:admin/widgets/subtitle_text.dart';
import 'package:admin/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatefulWidget {
  final String productId;
  const ProductsWidget({super.key, required this.productId});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ItemsCategory>(context);
    final getCurrProduct = productProvider.findByproductId(widget.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditorUpdateProducts(productsModels: getCurrProduct),
                  ),
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      width: double.infinity,
                      height: size.height * 0.22,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TitleText(
                    label: getCurrProduct.productTitle,
                    maxlines: 2,
                    fS: 18,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SubtitleText(
                      label: "\$${getCurrProduct.productPrice}",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
  }
}
