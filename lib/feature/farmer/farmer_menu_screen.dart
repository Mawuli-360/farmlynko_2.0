// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/farmer/community/farm_community.dart';
import 'package:farmlynko/feature/farmer/consultation/consultation_screen.dart';
import 'package:farmlynko/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import 'package:farmlynko/feature/farmer/chat_ai/ai_assisstant_screen.dart';
import 'package:farmlynko/shared/components/menu_tile.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';

class FarmerMenuScreen extends ConsumerWidget {
  const FarmerMenuScreen({
    super.key,
    required this.controller,
  });

  final ZoomDrawerController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userEmail = ref.watch(userEmailProvider);
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.primaryColor,
        child: Column(
          children: [
            Gap(10.h),
            Stack(
              children: [
                Container(
                  height: 18.h,
                  width: 18.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(162, 255, 255, 255)),
                ),
                Positioned(
                  left: 1.h,
                  top: 1.h,
                  child: Container(
                    height: 16.h,
                    width: 16.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1200px-User-avatar.svg.png"))),
                  ),
                ),
              ],
            ),
            Gap(2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Zigah Mawuli",
                  style: AppTextStyle.latoStyle(
                      size: 12, color: AppColors.white),
                )
              ],
            ),
            const Gap(0.5),
            MenuTile(
              icon: Icons.smart_toy,
              menu: "Chat Bot",
              onTap: () {
                print("sss");
                drawerController.close?.call()?.then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AssistantScreen(),
                        ),
                      ),
                    );
              },
            ),
            MenuTile(
              icon: Iconsax.people,
              menu: "Community",
              onTap: () {
                drawerController.close?.call()?.then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FarmCommunity(),
                        ),
                      ),
                    );
              },
            ),
            MenuTile(
              icon: Icons.psychology,
              menu: "Expertise",
              onTap: () {
                drawerController.close?.call()?.then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ExpertiseScreen(),
                        ),
                      ),
                    );
              },
            ),
            MenuTile(
              icon: Icons.help,
              menu: "Help",
              onTap: () {},
            ),
            Gap(15.h),
            MenuTile(
              icon: Iconsax.logout,
              menu: "Logout",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
