import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/home/data/models/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final Product book;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          pushTo(context, Routes.details, extra: book);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: book.id ?? "",
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: book.image ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.welcome,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Gap(15),
              SizedBox(
                height: 45,
                child: Text(
                  book.name ?? "",
                  style: TextStyles.styleSize16(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${book.priceAfterDiscount}',
                    style: TextStyles.styleSize16(),
                  ),
                  MainButton(
                    height: 30,
                    width: 75,
                    bgColor: AppColors.darkColor,
                    text: 'buy',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
