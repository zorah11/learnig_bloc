import 'dart:async';
import 'dart:js_interop_unsafe';

import 'package:bloc/bloc.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/data/grocert_data.dart';
import 'package:learning_bloc/data/wishlist_items.dart';
import 'package:learning_bloc/features/home/models/home_product_modle.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<WishlistProductDeleteButtonClickedEvent>(
        wishlistProductDeleteButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
  }

  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(HomeLoadedSuccessState(products: mapProducts()));
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
  }

  Future<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) async {
    bool found = false;

    for (var item in cartItems) {
      if (item.id == event.clickedProduct.id) {
        cartItems.remove(item);
        found = true;
        break;
      }
    }

    if (!found) {
      cartItems.add(event.clickedProduct);
    }

    emit(HomeLoadedSuccessState(products: mapProducts()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    bool found = false;

    for (var item in wishlistItems) {
      if (item.id == event.clickedProduct.id) {
        wishlistItems.remove(item);
        found = true;
        break;
      }
    }

    if (!found) {
      wishlistItems.add(event.clickedProduct);
    }

    emit(HomeLoadedSuccessState(products: mapProducts()));
  }

  FutureOr<void> wishlistProductDeleteButtonClickedEvent(
      WishlistProductDeleteButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadedSuccessState(products: mapProducts()));
  }

  List<ProductDataModel> mapProducts() {
    return GroceryData.groceryProducts
        .map((e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            price: e['price'],
            url: e['url']))
        .toList();
  }
}
