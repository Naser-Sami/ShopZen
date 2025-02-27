import 'package:flutter/material.dart';
import '/config/_config.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, this.onTap, this.autofocus = false, this.controller});

  final TextEditingController? controller;
  final void Function()? onTap;
  final bool autofocus;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SearchBar(
      focusNode: focusNode,
      autoFocus: widget.autofocus,
      controller: widget.controller,
      onTap: widget.onTap,
      hintText: 'Find your favorite items',
      keyboardType: TextInputType.name,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TRadius.r08),
        ),
      ),
      leading: IconButton(
        onPressed: null,
        icon: IconWidget(
          name: 'search',
          width: TSize.s20,
          height: TSize.s20,
          color: theme.colorScheme.onSurface,
        ),
      ),
      trailing: [
        IconButton(
          onPressed: () {},
          icon: IconWidget(
            name: 'search-visual',
            width: TSize.s20,
            height: TSize.s20,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
