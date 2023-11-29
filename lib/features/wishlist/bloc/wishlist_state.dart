part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistErrorState extends WishlistState {
  final String error;

  WishlistErrorState({required this.error});
}

final class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> products;

  WishlistSuccessState({required this.products});
}
