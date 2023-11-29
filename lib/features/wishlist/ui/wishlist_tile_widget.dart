import 'package:flutter/material.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learning_bloc/features/home/bloc/home_bloc.dart';
import 'package:learning_bloc/features/home/models/home_product_modle.dart';
import 'package:learning_bloc/features/wishlist/bloc/wishlist_bloc.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel item;
  final WishlistBloc wishlistBloc;
  WishlistTileWidget({
    super.key,
    required this.item,
    required this.wishlistBloc,
  });

  @override
  Widget build(BuildContext context) {
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
                    wishlistBloc.add(DeleteButtonClickedEvent(product: item));
                  },
                  icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
