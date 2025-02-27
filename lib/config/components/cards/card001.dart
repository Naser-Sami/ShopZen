import 'dart:developer';

import '/config/_config.dart';
import '/core/_core.dart';
import 'package:flutter/material.dart';

class CardComponent001 extends StatelessWidget {
  const CardComponent001({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 367,
      width: 360,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(25.0),
              leading: const CircleImageWidget(
                imageUrl:
                    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
              ),
              title: const Text('Frank Esteban'),
              subtitle: const Text('Card Subtitle'),
              trailing: PopupMenuButtonComponent(
                onSelected: (value) {
                  log(value.index.toString());
                  log(value.name);
                },
                itemBuilder: (BuildContext context) {
                  return Menu.values.map((Menu choice) {
                    return PopupMenuItem<Menu>(
                      value: choice,
                      child: Text(choice.name),
                    );
                  }).toList();
                },
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/card-001.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: TextWidget(
                'This is a basic card',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
