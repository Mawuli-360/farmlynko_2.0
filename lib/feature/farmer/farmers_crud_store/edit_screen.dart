import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  const EditProductScreen(this.product, {super.key});

  final DocumentSnapshot product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productNameController =
        TextEditingController(text: widget.product['name']);
    final productPriceController =
        TextEditingController(text: widget.product['price']);
    final productDescriptionController =
        TextEditingController(text: widget.product['description']);

    void updateProduct() {
      final updatedName = productNameController.text;
      final updatedPrice = productPriceController.text;
      final updatedDescription = productDescriptionController.text;

      widget.product.reference.update({
        'name': updatedName,
        'price': updatedPrice,
        'description': updatedDescription
      }).then((_) {
        Fluttertoast.showToast(msg: "Product updated successfully");
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update product: $error'),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[200],
        title: const Text("Farmer Edit Product"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        color: Colors.amber[200],
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Farmer Registration"),
              TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                      hintText: "product name", border: OutlineInputBorder())),
              TextFormField(
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "product price", border: OutlineInputBorder())),
              TextFormField(
                  controller: productDescriptionController,
                  decoration: const InputDecoration(
                      hintText: "product description",
                      border: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 300,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("upload image")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          // ImagePicker imagePicker = ImagePicker();
                          // XFile? file = await imagePicker.pickImage(
                          //     source: ImageSource.camera);

                          // if (file == null) return;
                          // String uniqueFileName =
                          //     DateTime.now().millisecondsSinceEpoch.toString();

                          // Reference referenceRoot =
                          //     FirebaseStorage.instance.ref();
                          // Reference referenceDirImages =
                          //     referenceRoot.child('product_images');

                          // Reference referenceImageToUpload =
                          //     referenceDirImages.child(uniqueFileName);

                          // try {
                          //   await referenceImageToUpload
                          //       .putFile(File(file.path));
                          //   imageUrl =
                          //       await referenceImageToUpload.getDownloadURL();
                          // } catch (error) {
                          //   //   //Some error occurred
                          // }
                        },
                        child: const Text("Take picture")),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    updateProduct();
                  },
                  child: const Text("add product")),
            ],
          ),
        ),
      ),
    );
  }
}
