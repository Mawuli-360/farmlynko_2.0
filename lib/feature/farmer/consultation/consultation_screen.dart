import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/farmer/consultation/expertise_model.dart';
import 'package:farmlynko/main.dart';
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
            Gap(4.h),
            Card(
              elevation: 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 12.h,
                    height: 100,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0I8LCRtRxqNnGKJhIZyM27AO3SMUeeHSmSg&usqp=CAU"))),
                  ),
                  Gap(3.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Mrs Franklina Owusu',
                          style: AppTextStyle.latoStyle(size: 12),
                        ),
                        Gap(1.h),
                        Text(
                          'Age: 58',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                        Gap(1.h),
                        Text(
                          'Qualification: Lecturer',
                          style: AppTextStyle.latoStyle(size: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
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
              elevation: 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 12.h,
                    height: 100,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "https://cdn.modernghana.com/content__/500/330/1012019120258-nsjum8x432-nelson.jpg"))),
                  ),
                  Gap(3.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Dr Nofong',
                          style: AppTextStyle.latoStyle(size: 12),
                        ),
                        Gap(1.h),
                        Text(
                          'Age: 48',
                          style: AppTextStyle.latoStyle(size: 10),
                        ),
                        Gap(1.h),
                        Text(
                          'Qualification: Agric Engineer',
                          style: AppTextStyle.latoStyle(size: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                          onPressed: () {
                            SocialLaunch.launchWhatsApp("+233545786643");
                          },
                          icon: const Icon(
                            Iconsax.message,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            SocialLaunch.launchPhoneCall("+233545786643");
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
