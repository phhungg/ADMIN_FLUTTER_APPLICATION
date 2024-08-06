import 'dart:io';

import 'package:admin/const/app_constaint.dart';
import 'package:admin/const/my_validator.dart';
import 'package:admin/models/products_models.dart';
import 'package:admin/screens/inner_screens/loading_manager.dart';
import 'package:admin/services/my_app_methods.dart';
import 'package:admin/widgets/title_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditorUpdateProducts extends StatefulWidget {
  static const routeName = "/EditOrUpdateProducts";

  const EditorUpdateProducts({super.key, this.productsModels});
  final ProductsModels? productsModels;

  @override
  State<EditorUpdateProducts> createState() => _EditorUpdateProductsState();
}

class _EditorUpdateProductsState extends State<EditorUpdateProducts> {
  final _fromKey = GlobalKey<FormState>();
  XFile? pickedImage;
  bool isEditing = false;
  String? productImageNetwork;
  late TextEditingController txtTitle, txtPrice, txtDes, txtQuaility;
  String? foodvale;
  bool isLoading = false;
  String? foodImageUrl;
  @override
  void initState() {
    if (widget.productsModels != null) {
      isEditing = true;
      productImageNetwork = widget.productsModels!.productImage;
      foodvale = widget.productsModels!.productCategory;
    }
    txtTitle = TextEditingController(text: widget.productsModels?.productTitle);
    txtPrice = TextEditingController(text: widget.productsModels?.productPrice);
    txtDes =
        TextEditingController(text: widget.productsModels?.productDescription);
    txtQuaility =
        TextEditingController(text: widget.productsModels?.productQuantity);
    super.initState();
  }

  void dispose() {
    txtTitle.dispose();
    txtPrice.dispose();
    txtDes.dispose();
    txtQuaility.dispose();
    super.dispose();
  }

  void clearForm() {
    txtTitle.clear();
    txtPrice.clear();
    txtDes.clear();
    txtQuaility.clear();
    removePickImage();
  }

  Future<void> uploadPro() async {
    final isValid = _fromKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _fromKey.currentState!.save();
      if (pickedImage == null) {
        MyAppMethods.showErrorOrWarningDialog(
            context: context,
            subtitle: "Make sure to pick up an image",
            fct: () {});
        return;
      }
      if (foodvale == null) {
        MyAppMethods.showErrorOrWarningDialog(
            context: context, subtitle: "Food is empty", fct: () {});
        return;
      }
      if (isValid) {
        _fromKey.currentState!.save();
        try {
          setState(() {
            isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child("foodImages")
              .child("${txtTitle.text.trim()}.jpg");
          await ref.putFile(File(pickedImage!.path));
          foodImageUrl = await ref.getDownloadURL();

          final foodId = Uuid().v4();
          await FirebaseFirestore.instance.collection("food").doc(foodId).set(
            {
              "foodId": foodId,
              "foodName": txtTitle.text,
              "foodImage": foodImageUrl,
              "foodPrice": txtPrice.text,
              "foodCategory": foodvale,
              "foodDescription": txtDes.text,
              "foodQuality": txtQuaility.text,
              "createdAt": Timestamp.now(),
            },
          );
          Fluttertoast.showToast(
            msg: "Food Added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 17,
          );
          if (!mounted) return;
          await MyAppMethods.showErrorOrWarningDialog(
              isError: false,
              context: context,
              subtitle: "Clear Form",
              fct: () {
                clearForm();
              });
        } on FirebaseAuthException catch (error) {
          if (!mounted) return;
          await MyAppMethods.showErrorOrWarningDialog(
              context: context,
              subtitle: "An error has been occured ${error.message}?",
              fct: () {});
        } catch (error) {
          if (!mounted) return;
          await MyAppMethods.showErrorOrWarningDialog(
              context: context,
              subtitle: "An error has been occured $error",
              fct: () {});
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    }

    if (pickedImage == null) {
      MyAppMethods.showErrorOrWarningDialog(
          context: context, subtitle: "Please pick an Image", fct: () {});
      return;
    }
    final isVaLid = _fromKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVaLid) {}
  }

  Future<void> editProduct() async {
    final isValid = _fromKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (pickedImage == null && productImageNetwork == null) {
      MyAppMethods.showErrorOrWarningDialog(
          context: context, subtitle: "Please pick up an image", fct: () {});
      return;
    }
    if (isValid) {}
  }

  void removePickImage() {
    setState(() {
      pickedImage = null;
      productImageNetwork = null;
    });
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
        context: context,
        cameraFCT: () async {
          pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFCT: () async {
          pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFCT: () {
          setState(() {
            pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LoadingManager(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          bottomSheet: SizedBox(
            height: kBottomNavigationBarHeight + 10,
            child: Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.clear),
                    label: const Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    icon: const Icon(Icons.upload),
                    onPressed: () {
                      if (isEditing) {
                        editProduct();
                      } else {
                        uploadPro();
                      }
                    },
                    label: Text(
                      isEditing ? "Edit Food" : "Upload Food",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title:
                TitleText(label: isEditing ? "Edit Food" : "Upload a new food"),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  if (isEditing && productImageNetwork != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        productImageNetwork!,
                        height: size.width * 0.3,
                        alignment: Alignment.center,
                      ),
                    )
                  ] else if (pickedImage == null) ...[
                    SizedBox(
                      width: size.width * 0.4 + 10,
                      height: size.width * 0.45,
                      child: Column(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          TextButton(
                            onPressed: () {
                              localImagePicker();
                            },
                            child: const Text("Pick Food Image"),
                          ),
                          TextButton(
                            onPressed: () {
                              removePickImage();
                            },
                            child: const Text(
                              "Remove image",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    )
                  ] else ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(pickedImage!.path),
                        height: size.width * 0.5,
                        alignment: Alignment.center,
                      ),
                    )
                  ],
                  if (pickedImage != null && productImageNetwork != null) ...[
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            localImagePicker();
                          },
                          child: const Text("Pick another image"),
                        )
                      ],
                    ),
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                      hint: const Text("Select Food"),
                      value: foodvale,
                      items: AppConstaint.itemDropdownlist,
                      onChanged: (value) {
                        setState(() {
                          foodvale = value;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Form(
                      key: _fromKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: txtTitle,
                            key: const ValueKey('Title'),
                            maxLength: 80,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: "Food Title",
                            ),
                            validator: (value) {
                              return MyValidator.uploadProText(
                                  value: value,
                                  toBeReturnedString:
                                      "Please enter a valid title");
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  controller: txtPrice,
                                  key: const ValueKey('\$ Price'),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^(\d+)?\.?\d{0,2}'),
                                    ),
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: 'Price',
                                  ),
                                  validator: (value) {
                                    return MyValidator.uploadProText(
                                        value: value,
                                        toBeReturnedString: 'Price is missing');
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: txtQuaility,
                                  keyboardType: TextInputType.number,
                                  key: const ValueKey("Quality"),
                                  decoration: const InputDecoration(
                                    hintText: "Qty",
                                  ),
                                  validator: (value) {
                                    return MyValidator.uploadProText(
                                      value: value,
                                      toBeReturnedString: "Quality is missed",
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            key: const ValueKey("Description"),
                            controller: txtDes,
                            minLines: 5,
                            maxLines: 8,
                            maxLength: 100,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                                hintText: "Food Description "),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
