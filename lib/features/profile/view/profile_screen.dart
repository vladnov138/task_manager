import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/router/router.dart';

import '../../../generated/l10n.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning")
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(S.of(context).plans),
              leading: const Icon(Icons.calendar_month),
              onTap: () {
                AutoRouter.of(context).push(const ScheduleListRoute());
              },
            ),
            ListTile(
              title: Text(S.of(context).analytics),
              leading: const Icon(Icons.analytics_outlined),
            ),
            ListTile(
              title: Text(S.of(context).settings),
              leading: const Icon(Icons.settings),
            ),
            ListTile(
              title: Text(S.of(context).logOut),
              leading: const Icon(Icons.logout_outlined),
              onTap: () {

              },
            ),
          ],
        )
      ),
    );
  }
}
