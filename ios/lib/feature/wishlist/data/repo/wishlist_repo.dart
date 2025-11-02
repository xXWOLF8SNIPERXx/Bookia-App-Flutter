import 'dart:developer';

import 'package:bookia/core/services/dio/api_endpoints.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/wishlist/data/models/wish_list_response/datum.dart';
import 'package:bookia/feature/wishlist/data/models/wish_list_response/wish_list_response.dart';

class WishlistRepo {
  static Future<WishListResponse?> getWishList() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.wishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveWishlistToLocal(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> addToWishList({
    required int productId,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.addToWishList,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveWishlistToLocal(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> removeFromWishList({
    required int productId,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.removeFromWishList,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveWishlistToLocal(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static saveWishlistToLocal(List<WishlistProduct> wishlistIds) {
    if (wishlistIds.isEmpty) {
      SharedPref.saveWishList([]);
    } else {
      List<int> bookIds = [];

      for (var id in wishlistIds) {
        bookIds.add(id.id ?? 0);
      }
      SharedPref.saveWishList(bookIds);
    }
  }
}
