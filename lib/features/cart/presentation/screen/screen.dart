import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/features/cart/_cart.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(const GetCartsEvent(id: '8'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Cart'),
        actions: const [
          NotificationsIconWidget(),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          switch (state) {
            case CartLoading():
              return const Center(child: CircularProgressIndicator());
            case CartLoaded():
              final cart = (state).cart;
              return ListView(
                children: [
                  CartWidget(cart: cart),
                  const SizedBox(height: TSize.s32),
                  CartTotalWidget(cart: cart),
                  Padding(
                    padding: const EdgeInsets.all(TPadding.p20),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const TextWidget('Go to Checkout'),
                    ),
                  ),
                ],
              );
            case CartError():
              final error = (state).message;
              return Center(child: Text(error));
            default:
              return const EmptyCartWidget();
          }
        },
      ),
    );
  }
}
