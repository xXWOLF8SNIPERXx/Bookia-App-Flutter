import 'dart:developer';

import 'package:bookia/core/services/dio/api_endpoints.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';

class CartRepo {
  static Future<CartResponse?> getCart() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.cart,
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> addToCart({required int productId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.addToCart,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeFromCart({required int cartItemId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.removeCart,
        data: {"cart_item_id": cartItemId},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> updateCart({required int cartItemId, required int quantity}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.updateCart,
        data: {"cart_item_id": cartItemId, "quantity" : quantity},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  // static saveCartToLocal(List<CartProduct> CartIds) {
  //   if (CartIds.isEmpty) {
  //     SharedPref.saveCart([]);
  //   } else {
  //     List<int> bookIds = [];

  //     for (var id in CartIds) {
  //       bookIds.add(id.id ?? 0);
  //     }
  //     SharedPref.saveCart(bookIds);
  //   }
  // }
}
