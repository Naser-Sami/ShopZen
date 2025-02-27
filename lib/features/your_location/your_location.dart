import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/features/_features.dart';
import '/config/_config.dart';
import '/core/_core.dart';

class YourLocationScreen extends StatefulWidget {
  static const routeName = '/your-location';
  const YourLocationScreen({super.key, required this.lat, required this.lng});

  final double lat, lng;

  @override
  State<YourLocationScreen> createState() => _YourLocationScreenState();
}

class _YourLocationScreenState extends State<YourLocationScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode? focusNode = FocusNode();
  List<CountryModel> countries = [];

  bool inset = false;

  void _onInset(bool value) {
    setState(() {
      inset = value;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<SearchLocationCubit>().loadLocations('assets/json/countries.json');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _navTo() {
    if (mounted) {
      context.go(BottomNavigationBarWidget.routeName);
      ToastNotification.showSuccessNotification(context,
          message: 'Welcome to the ShopZen App');
    }
  }

  Future<void> _updateUserData(String address) async {
    try {
      await sl<IFirestoreService<UserModel>>().updateDocument(
        'users/${sl<UserCubit>().state?.uid}',
        {
          'address': address,
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _getCurrentLocation() async {
    final address =
        await sl<IGeoCodeService>().getAddressFromCoordinates(widget.lat, widget.lng);

    await _updateUserData('${address.countryName}, ${address.city}');
    _navTo();
  }

  Future<void> _getSelectedLocation(String location) async {
    try {
      final coordinates = await sl<IGeoCodeService>().getCoordinatesFromAddress(location);
      final address = await sl<IGeoCodeService>().getAddressFromCoordinates(
          coordinates.latitude ?? 0, coordinates.longitude ?? 0);

      await _updateUserData('${address.countryName}, ${address.city}');
      _navTo();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Location'),
      ),
      body: GestureDetector(
        onTap: () {
          _onInset(false);
          focusNode?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: ListView(
            children: [
              NeumorphismContainer(
                inset: inset,
                blurRadius: 2,
                offset: const Offset(2, 0),
                surfaceColor: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(TRadius.r08),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TPadding.p12),
                  child: TextField(
                    onTap: () async {
                      _onInset(true);
                      focusNode?.requestFocus();
                    },
                    controller: _controller,
                    onChanged: (value) {
                      context.read<SearchLocationCubit>().search(value);
                    },
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: TPadding.p12),
                      border: InputBorder.none,
                      hintText: 'Find your location',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TPadding.p12),
                        child: IconWidget(
                          name: 'search',
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSize.s24),
              ListTile(
                leading:
                    IconWidget(name: 'location-arrow', color: theme.colorScheme.primary),
                title: const TextWidget('Use my current Location'),
                onTap: () async => await _getCurrentLocation(),
              ),
              const Divider(),
              const SizedBox(height: TSize.s24),
              BlocBuilder<SearchLocationCubit, List<CountryModel>>(
                builder: (context, results) {
                  if (results.isEmpty) {
                    return const SizedBox();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconWidget(
                          name: 'location-arrow',
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(results[index].country ?? ""),
                        subtitle: results[index].cities != null
                            ? Text(results[index].cities?.first ?? "")
                            : null,
                        onTap: () async {
                          _controller.text = results[index].country ?? "";
                          context.read<SearchLocationCubit>().search('');
                          await _getSelectedLocation(
                              _controller.text = results[index].country ?? "");
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
