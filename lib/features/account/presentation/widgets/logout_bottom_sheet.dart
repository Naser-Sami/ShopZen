import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

Future<void> logoutBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: theme.colorScheme.surface,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.40,
        widthFactor: 1,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                TSize.s40.toHeight,
                TextWidget('Logout', style: textTheme.headlineMedium),
                TSize.s24.toHeight,
                Divider(),
                TSize.s24.toHeight,
                TextWidget(
                  "Are you sure you want to log out?",
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TFunctions.isDarkMode(context)
                              ? Colors.grey
                              : Colors.grey.shade300,
                        ),
                        child: TextWidget(
                          'Cancel',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    TSize.s16.toWidth,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // only for test sing out
                          if (context.mounted) {
                            context.read<UserCubit>().logout(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                        ),
                        child: TextWidget(
                          'Yes, Logout',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TSize.s24.toHeight,
              ],
            ),
          ),
        ),
      );
    },
  );
}
