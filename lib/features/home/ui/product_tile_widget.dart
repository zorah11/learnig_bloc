import 'package:flutter/material.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/data/wishlist_items.dart';
import 'package:learning_bloc/features/home/bloc/home_bloc.dart';
import 'package:learning_bloc/features/home/models/home_product_modle.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel item;
  final HomeBloc homeBloc;

  ProductTileWidget({
    super.key,
    required this.item,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    bool wishListed = false;
    bool carted = false;
    for (var _item in wishlistItems) {
      if (_item.id == item.id) {
        wishListed = true;
        break;
      }
    }
    for (var _item in cartItems) {
      if (_item.id == item.id) {
        carted = true;
        break;
      }
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(item.url))),
          ),
          Text(
            item.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(item.description),
          Row(
            children: [
              Text(
                '\$' + item.price.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeProductWishlistButtonClickedEvent(
                        clickedProduct: item));
                  },
                  icon: wishListed
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_outline,
                          color: Colors.black,
                        )),
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeProductCartButtonClickedEvent(
                        clickedProduct: item));
                  },
                  icon: carted
                      ? Icon(
                          Icons.shopping_cart,
                          color: const Color.fromARGB(255, 255, 140, 64),
                        )
                      : Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                        )),
            ],
          ),
        ],
      ),
    );
  }
}
