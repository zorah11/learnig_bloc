import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/features/cart/ui/cart_page.dart';
import 'package:learning_bloc/features/home/bloc/home_bloc.dart';
import 'package:learning_bloc/features/home/ui/product_tile_widget.dart';
import 'package:learning_bloc/features/wishlist/wistlist_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WishListPage()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item added to cart')));
        } else if (state is HomeProductItemWishListedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item added to wishlist')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState:
            final sucessState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Center(child: Text("Zoora's Grocery App")),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: ListView.builder(
                  itemCount: sucessState.products.length,
                  itemBuilder: (context, index) => ProductTileWidget(
                        item: sucessState.products[index],
                        homeBloc: homeBloc,
                      )),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(child: Text('Something is wrong')),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
