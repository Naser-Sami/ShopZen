import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/config/_config.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  static const routeName = '/home';
  const BottomNavigationBarWidget({super.key, required this.navigationShell});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: theme.colorScheme.primary,
        onTap: _onTap,
        elevation: 10,
        backgroundColor: theme.colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'home',
              color: navigationShell.currentIndex == 0 ? theme.colorScheme.primary : null,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'saved',
              color: navigationShell.currentIndex == 1 ? theme.colorScheme.primary : null,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'shopping-cart',
              color: navigationShell.currentIndex == 2 ? theme.colorScheme.primary : null,
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'user',
              color: navigationShell.currentIndex == 4 ? theme.colorScheme.primary : null,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
