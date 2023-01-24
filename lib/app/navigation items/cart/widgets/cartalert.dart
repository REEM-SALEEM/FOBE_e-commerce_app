import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:flutter/material.dart';

class CartAlertWidget extends StatelessWidget {
  const CartAlertWidget({
    Key? key,
    required this.cart,
    required this.index,
  }) : super(key: key);

  final CartProvider cart;
  final int index;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Move from Cart',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Are you sure want to remove \nthis item from cart?',
        style: TextStyle(
          color: Color.fromARGB(255, 78, 77, 77),
          letterSpacing: 0.1,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        FittedBox(
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  cart.removeCart(
                    context,
                    cart.cartList!.products[index].product.id,
                  );
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
