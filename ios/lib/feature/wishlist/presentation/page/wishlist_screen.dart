import 'dart:developer';

import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:bookia/feature/wishlist/presentation/widgets/wish_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(SharedPref.getUserData()?.token ?? "");
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishList(),
      child: Scaffold(
        appBar: AppBar(title: Text('WishList')),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            var cubit = context.read<WishlistCubit>();
            if (state is! WishListSuccessState) {
              return Center(child: CircularProgressIndicator());
            }
            if (cubit.books.isEmpty) {
              return _emptyUi();
            }
            return ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: cubit.books.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return WishListCard(
                  book: cubit.books[index],
                  onDelete: () {
                    cubit.removeFromWishList(
                      productId: cubit.books[index].id ?? 0,
                    );
                  },
                  onRefresh: () {
                    cubit.getWishList();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Center _emptyUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.bookmarkSvg,
            height: 100,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          Gap(20),
          Text('No Book Added To WishList'),
        ],
      ),
    );
  }
}
