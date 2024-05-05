import 'package:farmlynko/shared/components/custom_icon_button.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({Key? key}) : super(key: key);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
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
          'Seeds',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.black,
              size: 24,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                            '',
                          ).image,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.00, 0.00),
                            child: Container(
                              width: double.infinity,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1.5.h)),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  alignment:
                                      const AlignmentDirectional(0.00, 0.00),
                                  image: Image.network(
                                    'https://www.tastingtable.com/img/gallery/common-mistakes-everyone-makes-with-beans/intro-1656424788.jpg',
                                  ).image,
                                ),
                              ),
                              child: Align(
                                alignment:
                                    const AlignmentDirectional(1.00, -1.00),
                                child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 10, 0),
                                    child: CustomIconButton(
                                      height: 5,
                                      width: 5,
                                      color: AppColors.white,
                                      icon: Icons.bookmark_outline,
                                      onTap: () {},
                                      border: 10,
                                      iconColor: AppColors.black,
                                    )),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.h)),
                              color: const Color.fromARGB(220, 125, 187, 153),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(-1.00, 0.00),
                                    child: Text(
                                      'Beans',
                                      style: AppTextStyle.latoStyle(size: 14),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            -1.00, 0.00),
                                        child: Text(
                                          'GHC 2000.00',
                                          style: AppTextStyle.latoStyle(
                                              size: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 5, 5),
                                          child: CustomIconButton(
                                            height: 5,
                                            width: 5,
                                            color: AppColors.primaryColor,
                                            icon: Icons.add,
                                            onTap: () {},
                                            border: 10,
                                            iconColor: AppColors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
