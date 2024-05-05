import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/farmer/consultation/expertise_model.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:farmlynko/shared/resource/social_launch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

class ConsultationScreen extends ConsumerStatefulWidget {
  const ConsultationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConsultationScreenState();
}

class _ConsultationScreenState extends ConsumerState<ConsultationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ExpertiseData.data.length,
              (index) => Card(
                elevation: 2,
                child: ListTile(
                  leading: Text(ExpertiseData.data[index].name[0]),
                  title: TextButton(
                    onPressed: () {
                      SocialLaunch.launchPhoneCall(
                          ExpertiseData.data[index].number);
                    },
                    child: Text(ExpertiseData.data[index].number),
                  ),
                  subtitle: TextButton(
                    onPressed: () {
                      SocialLaunch.launchEmail(ExpertiseData.data[index].email);
                    },
                    child: Text(ExpertiseData.data[index].email),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        SocialLaunch.launchWhatsApp(
                            ExpertiseData.data[index].number);
                      },
                      icon: const Icon(
                        Icons.message_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
            )),
      ),
    );
  }
}

class ExpertiseScreen extends ConsumerStatefulWidget {
  const ExpertiseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExpertiseScreenState();
}

class _ExpertiseScreenState extends ConsumerState<ExpertiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
          'Consultancy',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: Column(
          children: [
            Gap(1.h),
            RichText(
              text: TextSpan(
                  text: 'Discover success with',
                  children: const [
                    TextSpan(
                        text: ' Farmlynco Consultancy',
                        style:
                            TextStyle(color: Color.fromARGB(255, 4, 135, 41))),
                    TextSpan(
                      text:
                          '.Our experts deliver tailored solutions for agribusiness, ensuring your business thrives. Elevate your success with us.',
                    ),
                  ],
                  style: TextStyle(color: AppColors.black, fontSize: 12.sp)),
            ),
            Gap(4.h),
            Card(
              elevation: 5,
              color: AppColors.white,
              shape: Border.all(color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 12.h,
                    height: 100,
                    margin: EdgeInsets.all(0.5.h),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.green, width: 0.2.h),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0I8LCRtRxqNnGKJhIZyM27AO3SMUeeHSmSg&usqp=CAU"))),
                  ),
                  Gap(1.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Mrs Franklina Owusu',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                        Gap(1.h),
                        Text(
                          'Age: 58',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                        Gap(1.h),
                        Text(
                          'Qualification: Lecturer',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            SocialLaunch.launchWhatsApp("+233543845970");
                          },
                          icon: const Icon(
                            Iconsax.message,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            SocialLaunch.launchPhoneCall("+233543845970");
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Gap(1.h),
            Card(
              elevation: 5,
              color: AppColors.white,
              shape: Border.all(color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 12.h,
                    height: 100,
                    margin: EdgeInsets.all(0.5.h),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.green, width: 0.2.h),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "https://cdn.modernghana.com/content__/500/330/1012019120258-nsjum8x432-nelson.jpg"))),
                  ),
                  Gap(1.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Mr Jokn Kwasi',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                        Gap(1.h),
                        Text(
                          'Age: 68',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                        Gap(1.h),
                        Text(
                          'Qualification: Agric Engineer',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            SocialLaunch.launchWhatsApp("+233543845970");
                          },
                          icon: const Icon(
                            Iconsax.message,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            SocialLaunch.launchPhoneCall("+233543845970");
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
