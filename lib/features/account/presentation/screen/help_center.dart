import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class HelpCenterScreen extends StatefulWidget {
  static const routeName = 'help-center';
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<HelpCenterScreen> {
  final repo = sl<IHelpCenterRepository>();
  List<HelpCenterFieldsEntity> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    data = repo.getHelpCenterFields();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        actions: [
          NotificationsIconWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: ListView(
          children: [
            TSize.s24.toHeight,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: TSize.s16),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    switch (data[index].name) {
                      case 'Customer Service':
                        context.push(CustomerServiceScreen.routeName);
                        break;
                      default:
                    }
                  },
                  minTileHeight: TSize.s64,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(TRadius.r08),
                    side:
                        BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.10)),
                  ),
                  leading: IconWidget(
                    name: data[index].icon,
                    color: colorScheme.onSurface,
                  ),
                  title: TextWidget(data[index].name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
