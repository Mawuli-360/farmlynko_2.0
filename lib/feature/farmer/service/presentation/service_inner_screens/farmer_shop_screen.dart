import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';

class FarmShopScreen extends StatelessWidget {
  const FarmShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Farmer Shop',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Text("Farmer Shop Screen"),
      ),
    );
  }
}
