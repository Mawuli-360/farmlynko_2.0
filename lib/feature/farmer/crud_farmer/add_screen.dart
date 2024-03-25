import 'package:farmlynko/feature/farmer/crud_farmer/farmer_add_product.dart';
import 'package:farmlynko/main.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class FarmAddScreen extends ConsumerStatefulWidget {
  const FarmAddScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FarmAddScreenState();
}

class _FarmAddScreenState extends ConsumerState<FarmAddScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryProvider.notifier).state;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
          'Add Product',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 157,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 61, 170, 152),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 12.h,
                    width: 12.h,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.camera,
                        size: 5.h,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(3.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 20, 8, 0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Product Name',
                        ),
                        obscureText: false,
                      ),
                    ),
                    Gap(2.h),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Price',
                                  border: OutlineInputBorder()),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                  labelText: '/bag',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    DropdownButtonFormField<String>(
                      value: category,
                      onChanged: (value) {
                        ref.read(categoryProvider.notifier).state = value!;
                      },
                      items: ['Fruit', 'Vegetables', 'Grain'].map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                      ),
                    ),
                    Gap(2.h),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(5.h),
              Container(
                width: 40.h,
                height: 6.h,
                decoration: const ShapeDecoration(
                    shape: StadiumBorder(), color: AppColors.primaryColor),
                child: Center(
                  child: Text(
                    "Add Product",
                    style:
                        AppTextStyle.latoStyle(size: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
