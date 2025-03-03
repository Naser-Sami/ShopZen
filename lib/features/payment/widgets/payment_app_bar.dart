import 'package:flutter/material.dart';
import '/config/_config.dart';

PreferredSizeWidget? paymentAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Payment'),
    bottom: PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 10),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: TPadding.p20),
        child: Divider(),
      ),
    ),
  );
}
