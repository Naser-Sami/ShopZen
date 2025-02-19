import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class CustomerServiceScreen extends StatefulWidget {
  static const routeName = '/customer-service';
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Service'),
        actions: [
          NotificationsIconWidget(),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'Customer Service $index',
                          style: theme.textTheme.bodyLarge,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: TSize.s16),

                /// **Dynamic Expanding TextField**
                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(TSize.s12),
                            border: Border.all(
                              color: colorScheme.onSurface.withValues(alpha: 0.10),
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            controller: _controller,
                            minLines: 1,
                            maxLines: 6, // Adjust max height here
                            keyboardType: TextInputType.multiline,

                            placeholder: 'Write your message...',
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: TSize.s16),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: TSize.s56,
                        height: TSize.s56,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(TSize.s12),
                        ),
                        child: Container(
                          width: TSize.s56,
                          height: TSize.s56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(TSize.s12),
                            color: colorScheme.primary,
                          ),
                          child: Icon(
                            Icons.mic_none_outlined,
                            size: 33,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSize.s16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
