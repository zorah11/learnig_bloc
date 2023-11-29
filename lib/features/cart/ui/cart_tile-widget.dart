import 'package:flutter/material.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learning_bloc/features/home/bloc/home_bloc.dart';
import 'package:learning_bloc/features/home/models/home_product_modle.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

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
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.url))),
          ),
          Text(
            productDataModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(productDataModel.description),
          Row(
            children: [
              Text(
                '\$' + productDataModel.price.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    cartBloc.add(CartRemoveItemFromCartEvent(
                        productDataModel: productDataModel));
                  },
                  icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
