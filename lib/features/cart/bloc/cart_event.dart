part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveItemFromCartEvent extends CartEvent {
  final ProductDataModel productDataModel;

  CartRemoveItemFromCartEvent({required this.productDataModel});
}
