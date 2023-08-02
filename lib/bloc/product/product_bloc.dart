import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produk_list_project/bloc/product/product_event.dart';
import 'package:produk_list_project/bloc/product/product_state.dart';

import '../../service/product_api_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService;

  ProductBloc(this._productService) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productService.getProducts();
        emit(ProductLoadedState(products));
      } catch (e) {
        print(e.toString());
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
