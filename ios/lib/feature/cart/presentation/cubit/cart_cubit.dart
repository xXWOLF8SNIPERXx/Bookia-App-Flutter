import 'package:bookia/feature/Cart/data/repo/Cart_repo.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final govController = TextEditingController();
  CartResponse? cartResponse;

  getCart() async {
    emit(CartLoadingState());
    var res = await CartRepo.getCart();

    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErorrState());
    }
  }

  removeFromCart({required int cartItemId}) async {
    emit(CartLoadingState());
    var res = await CartRepo.removeFromCart(cartItemId: cartItemId);

    if (res != null) {
      cartResponse = res;

      emit(CartSuccessState());
    } else {
      emit(CartErorrState());
    }
  }

  updateCart({required int cartItemId, required int quantity}) async {
    var res = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );

    if (res != null) {
      cartResponse = res;

      emit(CartSuccessState());
    } else {
      emit(CartErorrState());
    }
  }
}
