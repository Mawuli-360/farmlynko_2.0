import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class RateScreen extends ConsumerStatefulWidget {
  const RateScreen({super.key});

  @override
  ConsumerState<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends ConsumerState<RateScreen> {
  final reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 1.5.h, right: 1.5.h, top: 1.2.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 280,
                  color: Colors.yellow,
                  child: Stack(
                    children: [
                      Container(color: Colors.white),
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AppImages.ratebg, fit: BoxFit.fill),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(1.h),
                            height: 4.h,
                            width: 4.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1.h))),
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.7.h),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 2.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Container(
                                  height: 14.h,
                                  width: 14.h,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 22, 51, 32),
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 10.h,
                                      width: 10.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Image(image: AppImages.logo),
                                    ),
                                  ),
                                ),
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Farmlynco",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                const Text("www.farmlynco.com"),
                SizedBox(
                  height: 6.h,
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Text(
                    "Please Share Your Feedback With Us",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                TextField(
                  controller: reviewController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      hintText: "Write review",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ],
            ),
          ),
        )),
        bottomNavigationBar: CustomButton(
          title: "Submit",
          onTap: () {
            if (reviewController.text.isNotEmpty) {
              Navigation.openThankScreen(context: context);
            }
            showToast(context, "Fill the review field");
          },
        ));
  }
}
