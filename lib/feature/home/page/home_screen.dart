import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            SvgPicture.asset(AppImages.logo, height: 24, width: 24),

            SizedBox(width: 6),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                AppImages.searchSvg,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              AppImages.rectangle,
              width: double.infinity,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset(AppImages.dots)],
          ),

          Gap(30),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Best Seller', style: TextStyles.styleSize24()),
              ),
            ],
          ),

          Gap(15),
        ],
      ),
    );
  }
}
