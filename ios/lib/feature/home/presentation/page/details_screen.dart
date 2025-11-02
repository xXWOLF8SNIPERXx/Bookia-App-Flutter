import 'package:bookia/components/app_bar/app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/home/data/models/best_seller_response/product.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.book});

  final Product book;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          showLoadingDialog(context);
        } else if (state is HomeSuccessState) {
          pop(context);
          showMyDialog(context, state.message ?? '', type: DialogType.success);
        } else if (state is HomeErrorState) {
          pop(context);
          showMyDialog(context, 'Something went wrong');
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBarWithBack(
            action: [
              IconButton(
                onPressed: () {
                  cubit.addRemoveWishList(productId: book.id ?? 00);
                },
                icon: cubit.checkIfWishlist(book.id ?? 0)
                    ? SvgPicture.asset(
                        AppImages.bookmarkSvg,
                        colorFilter: ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(AppImages.bookmarkSvg),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    Hero(
                      tag: book.id ?? "",
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: book.image ?? "",
                          height: 270,
                          errorWidget: (context, error, StackTrace) {
                            return Image.asset(
                              AppImages.welcome,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    Gap(25),
                    Text(book.name ?? "", style: TextStyles.styleSize24()),
                    Gap(10),
                    Text(
                      book.category ?? "",
                      style: TextStyles.styleSize16(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Gap(20),
                    Text(
                      book.description ?? "",
                      style: TextStyles.styleSize14(),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${book.priceAfterDiscount}',
                    style: TextStyles.styleSize24(),
                  ),
                  Gap(40),
                  Expanded(
                    child: MainButton(
                      bgColor: AppColors.darkColor,
                      text: 'Add to Cart',
                      onPressed: () {
                        cubit.addToCart(productId: book.id ?? 0);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
