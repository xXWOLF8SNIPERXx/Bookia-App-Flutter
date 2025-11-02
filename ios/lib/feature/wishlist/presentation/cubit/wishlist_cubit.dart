import 'package:bookia/feature/wishlist/data/models/wish_list_response/datum.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishListInitialState());

  List<WishlistProduct> books = [];

  getWishList() async {
    emit(WishListLoadingState());
    var res = await WishlistRepo.getWishList();

    if (res != null) {
      books = res.data?.data ?? [];
      emit(WishListSuccessState());
    } else {
      emit(WishListErorrState());
    }
  }

  removeFromWishList({required int productId}) async {
    emit(WishListLoadingState());
    var res = await WishlistRepo.removeFromWishList(productId: productId);

    if (res != null) {
      books = res.data?.data ?? [];
      emit(WishListSuccessState());
    } else {
      emit(WishListErorrState());
    }
  }
}
