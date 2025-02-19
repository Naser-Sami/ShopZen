import 'package:flutter/material.dart';
import '/features/_features.dart';
import '/config/_config.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  static const routeName = '/';
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SavedItemsScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.primary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        elevation: 10,
        backgroundColor: theme.colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'home',
              color: _selectedIndex == 0 ? theme.colorScheme.primary : null,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'saved',
              color: _selectedIndex == 1 ? theme.colorScheme.primary : null,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'shopping-cart',
              color: _selectedIndex == 2 ? theme.colorScheme.primary : null,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: IconWidget(
              name: 'user',
              color: _selectedIndex == 3 ? theme.colorScheme.primary : null,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
