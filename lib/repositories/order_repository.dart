import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/check_response_model.dart';
import 'package:active_ecommerce_flutter/data_model/common_response.dart';
import 'package:active_ecommerce_flutter/data_model/purchased_ditital_product_response.dart';
import 'package:active_ecommerce_flutter/helpers/response_check.dart';
import 'package:active_ecommerce_flutter/middlewares/banned_user.dart';
import 'package:active_ecommerce_flutter/repositories/api-request.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:active_ecommerce_flutter/data_model/order_mini_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_detail_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_item_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_mini_response.dart';
import 'package:active_ecommerce_flutter/data_model/purchased_ditital_product_response.dart';
import 'package:active_ecommerce_flutter/helpers/response_check.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  Future<dynamic> getOrderList(
      {page = 1, payment_status = "", delivery_status = ""}) async {
    String url=("${AppConfig.BASE_URL}/purchase-history" +
        "?page=${page}&payment_status=${payment_status}&delivery_status=${delivery_status}");
    print("url:" +url.toString());
    print("token:" +access_token.$!);
    final response = await ApiRequest.get(url: url,headers: {
      "Authorization": "Bearer ${access_token.$}",
      "App-Language": app_language.$!,
        },middleware: BannedUser());

    return orderMiniResponseFromJson(response.body);
  }

  Future<dynamic> getOrderDetails({ int? id = 0}) async {
    String url=(
        "${AppConfig.BASE_URL}/purchase-history-details/" + id.toString());

    final response = await ApiRequest.get(url: url,headers: {
      "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },middleware: BannedUser());
    return orderDetailResponseFromJson(response.body);
  }

  Future<CommonResponse> cancelOrder({ int? id = 0}) async {
    String url="${AppConfig.BASE_URL}/order/cancel/$id";

    final response = await ApiRequest.get(url: url,headers: {
      "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },middleware: BannedUser());
    return commonResponseFromJson(response.body);
  }

  Future<dynamic> getOrderItems({ int? id = 0}) async {
    String url=(
        "${AppConfig.BASE_URL}/purchase-history-items/" + id.toString());
    final response = await ApiRequest.get(url: url,headers: {
      "Authorization": "Bearer ${access_token.$}",
      "App-Language": app_language.$!,
        },middleware: BannedUser());

    return orderItemlResponseFromJson(response.body);
  }

  Future<dynamic> getPurchasedDigitalProducts(
      {
        page = 1,
      }) async {
    String url=("${AppConfig.BASE_URL}/digital/purchased-list?page=$page");

    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
    },middleware: BannedUser());

    return purchasedDigitalProductResponseFromJson(response.body);
  }
}
