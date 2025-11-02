import 'package:bookia/components/app_bar/app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String total;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBarWithBack(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Place Your Order', style: TextStyles.styleSize30()),
                Gap(10),
                Text(
                  'Don\'t worry it occurs. Please enter the email address linked with your account.',
                  style: TextStyles.styleSize16(color: AppColors.greyColor),
                ),
                Gap(20),
                CustomTextField(
                  controller: cubit.fullNameController,
                  hint: 'Full Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Full Name';
                    }
                    return null;
                  },
                ),
                Gap(12),
                CustomTextField(
                  controller: cubit.emailController,
                  hint: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    return null;
                  },
                ),
                Gap(12),

                CustomTextField(
                  controller: cubit.addressController,
                  hint: 'Address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Address';
                    }
                    return null;
                  },
                ),
                Gap(12),

                CustomTextField(
                  controller: cubit.phoneController,
                  hint: 'Phone',
                ),
                Gap(12),
                Gap(12),

                CustomTextField(
                  controller: cubit.govController,
                  hint: 'Governate',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Government';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price', style: TextStyles.styleSize18()),
                Text(
                  '${cubit.cartResponse?.data?.total ?? 0} \$',
                  style: TextStyles.styleSize18(),
                ),
              ],
            ),
            Gap(20),
            MainButton(text: 'CheckOut', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
