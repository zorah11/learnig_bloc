part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class DeleteButtonClickedEvent extends WishlistEvent {
  final ProductDataModel product;
  DeleteButtonClickedEvent({required this.product});
}
