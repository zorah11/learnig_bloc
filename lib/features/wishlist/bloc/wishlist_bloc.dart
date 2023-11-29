import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learning_bloc/data/wishlist_items.dart';
import 'package:learning_bloc/features/home/models/home_product_modle.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<DeleteButtonClickedEvent>(deleteButtonClickedEvent);
  }

  Future<FutureOr<void>> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    try {
      emit(WishlistLoadingState());
      await Future.delayed(Duration(seconds: 2));
      emit(WishlistSuccessState(products: wishlistItems));
    } catch (e) {
      emit(WishlistErrorState(error: e.toString()));
    }
  }

  FutureOr<void> deleteButtonClickedEvent(
      DeleteButtonClickedEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.product);
    emit(WishlistSuccessState(products: wishlistItems));
  }
}
