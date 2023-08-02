import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/product_model/product_model.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<ProductDataListModel> product;

  ProductLoadedState(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
