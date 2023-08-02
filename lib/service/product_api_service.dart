import 'package:dio/dio.dart';
import 'package:produk_list_project/app/constans/endpoint.dart';

import '../model/product_model/product_model.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<ProductDataListModel>> getProducts() async {
    try {
      final response = await _dio.get(EndPoint.listProduct);
      final List<ProductDataListModel> products = (response.data as List)
          .map((json) => ProductDataListModel.fromJson(json))
          .toList();
      return products;
    } catch (error) {
      throw Exception('Failed to fetch products');
    }
  }
}
  // final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));
  //
  // Future<List<ProductDataListModel>> getProducts() async {
  //   try {
  //     final response = await _dio.get('/products');
  //     final List<ProductDataListModel> products = (response.data as List)
  //         .map((productJson) => ProductDataListModel.fromJson(productJson))
  //         .toList();
  //     return products;
  //   } catch (error) {
  //     throw Exception('Failed to fetch products.');
  //   }
  // }
  //
  // Future<ProductDataListModel> getProductDetail(int productId) async {
  //   try {
  //     final response = await _dio.get('/products/$productId');
  //     final product = ProductDataListModel.fromJson(response.data);
  //     return product;
  //   } catch (error) {
  //     throw Exception('Failed to fetch product detail.');
  //   }
  // }

