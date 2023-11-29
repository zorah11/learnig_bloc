import 'package:flutter/material.dart';
import 'package:learning_bloc/features/cart/ui/cart_tile-widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/features/home/models/home_product_modle.dart';
import 'package:learning_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:learning_bloc/features/wishlist/ui/wishlist_tile_widget.dart';

class WishListPage extends StatefulWidget {
  WishListPage({
    super.key,
  });

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    super.initState();
    wishlistBloc.add(WishlistInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistErrorState:
              final errorState = state as WishlistErrorState;
              return Center(
                child: Text(errorState.error),
              );
            case WishlistLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                      item: successState.products[index],
                      wishlistBloc: wishlistBloc,
                    );
                  });

            default:
              return Container();
          }
        },
      ),
    );
  }
}
