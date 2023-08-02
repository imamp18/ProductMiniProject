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

