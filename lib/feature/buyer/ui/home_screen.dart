import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/feature/buyer/model/product_model.dart';
import 'package:farmlynko/feature/buyer/provider/products_provider.dart';
import 'package:farmlynko/feature/buyer/provider/user_provider.dart';
import 'package:farmlynko/feature/buyer/ui/product_screen.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/data/home_data.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_strings.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  CarouselController controller = CarouselController();
  int _current = 0;
  String selectedValue = "Crop Protection";
  String query = "";

  ClipRRect _buildCarouselItem(
      {required String title, required AssetImage image}) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: const ColorFilter.mode(
                  Color(0x52000000), BlendMode.colorBurn),
              image: image,
              fit: BoxFit.fill),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(fetchSomeProductProvider);
    final user = ref.watch(userDetailsProvider);

    List<Widget> newsItem = [
      _buildCarouselItem(
        title: "Farmer Associations call for PFJ audit",
        image: AppImages.planting,
      ),
      _buildCarouselItem(
        title:
            "Cocoa farmers in the Western region welcome\npension scheme project",
        image: AppImages.cocoafarmers,
      ),
      _buildCarouselItem(
        title: "How to successfully grow and harvest carrots",
        image: AppImages.carrotfarming,
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("NO"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: const Text("YES"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        drawer: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5.h),
              bottomRight: Radius.circular(5.h),
            ),
            child: Drawer(
              width: 28.h,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 12.h,
                          width: 12.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.h)),
                              color: Colors.white,
                              image: const DecorationImage(
                                  image: AppImages.avatar),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(73, 255, 153, 0),
                                    spreadRadius: 0.3.h,
                                    offset: const Offset(2, 8),
                                    blurRadius: 2.h)
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 4.h, top: 4.h),
                        child: user.when(
                            data: (data) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    data.email,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              );
                            },
                            error: (error, st) => Text(error.toString()),
                            loading: () => const CircularProgressIndicator())),
                    Expanded(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: HomeData.menuData(context: context).length,
                          itemBuilder: (context, index) {
                            return _buildMenuItem(
                              onTap: HomeData.menuData(context: context)[index]
                                  .onTap,
                              icon: HomeData.menuData(context: context)[index]
                                  .icon,
                              title: HomeData.menuData(context: context)[index]
                                  .title,
                            );
                          }),
                    ),
                    _buildMenuItem(
                        onTap: () {
                          ref.read(authServiceProvider.notifier).signOut();
                        },
                        title: "Sign Out",
                        icon: Icons.exit_to_app_outlined),
                    Gap(15.h)
                  ],
                ),
              ),
            )),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            "Farmlynco",
            style: AppTextStyle.latoStyle(
                size: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: AnimationLimiter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 100.0,
                      child: FadeInAnimation(
                        curve: Curves.easeIn,
                        child: widget,
                      ),
                    ),
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      const Text(
                        AppStrings.newsFeed,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 25.h,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigation.openNewsScreen(context: context);
                              },
                              child: SizedBox(
                                height: 20.h,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: CarouselSlider(
                                    items: newsItem,
                                    options: CarouselOptions(
                                        height: 360,
                                        viewportFraction: 1,
                                        enableInfiniteScroll: true,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 5),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 900),
                                        autoPlayCurve: Curves.easeInOut,
                                        pauseAutoPlayOnTouch: true,
                                        aspectRatio: 1.0,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: newsItem.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.animateToPage(entry.key),
                                    child: AnimatedContainer(
                                      curve: Curves.easeIn,
                                      width: 2.h,
                                      height: 1.h,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 0.5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green.withOpacity(
                                              _current == entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                      duration:
                                          const Duration(milliseconds: 600),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        AppStrings.categories,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 15.h,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6.h,
                            mainAxisSpacing: 4.h,
                          ),
                          itemCount: HomeData.category(context: context).length,
                          itemBuilder: (context, index) => _buildCategoryItem(
                            image: HomeData.category(context: context)[index]
                                .image,
                            title: HomeData.category(context: context)[index]
                                .title,
                            onTap: HomeData.category(context: context)[index]
                                .onTap,
                          ),
                        ),
                      ),
                      const Text(
                        AppStrings.recommendedProduct,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                          height: 28.h,
                          child: productList.when(
                              data: (data) {
                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return _buildBestProductItem(
                                          context: context,
                                          product: data[index]);
                                    });
                              },
                              error: (error, st) => Text(error.toString()),
                              loading: () =>
                                  const CircularProgressIndicator())),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBestProductItem(
      {required BuildContext context, required ProductModel product}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(
                      product: product,
                    )));
      },
      child: Container(
        width: 40.w,
        margin: EdgeInsets.only(right: 2.h),
        height: 25.h,
        decoration: const BoxDecoration(
            color: Color.fromARGB(54, 202, 247, 219),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1.2.h),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 0.3.h,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            )),
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(left: 0.6.h, top: 0.5.h),
              height: 8.h,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    "GHC ${product.price}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF138F17),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {required void Function() onTap,
      required IconData icon,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      {required SvgPicture image,
      required String title,
      required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(94, 190, 190, 190),
              spreadRadius: 0.1.h,
              offset: const Offset(9, 12),
              blurRadius: 3.h,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 5.3.h,
              child: image,
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
