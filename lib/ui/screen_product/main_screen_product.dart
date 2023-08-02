import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produk_list_project/bloc/product/product_bloc.dart';
import 'package:produk_list_project/bloc/product/product_event.dart';
import 'package:produk_list_project/bloc/product/product_state.dart';
import 'package:produk_list_project/model/product_model/product_model.dart';

import '../../service/product_api_service.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (BuildContext context) => ProductBloc(ProductService()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Mini Project App')),
        body: _bodyListProduct(),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _bodyListProduct() {
    return BlocProvider(
      create: (context) => ProductBloc(
        ProductService(),
      )..add(LoadProductEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductLoadedState) {
            List<ProductDataListModel> productList = state.product;
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                // width / height: fixed for *all* items
                childAspectRatio: 0.75,
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.favorite_border,
                                size: 15,
                                color: Colors.black54,
                              )),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(product.image,
                                height: 100, fit: BoxFit.fill),
                          ),
                          const SizedBox(height: 7),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                product.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              )),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                                size: 15,
                              ),
                              Text(
                                'Rating :${product.rating.rate}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text('Price :\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is ProductErrorState) {
            return const Center(
              child: Text("Error Tidak Dapat Menampilkan Data"),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _bottomNavigation() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Fav'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: 0,
        onTap: null,
      ),
    );
  }
}
