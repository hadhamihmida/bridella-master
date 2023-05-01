
import 'package:bridella/app_core/screens/notifications_page.dart';
import 'package:bridella/app_core/screens/settings_page.dart';
import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/social/screens/friends_page.dart';
import 'package:bridella/users/models/user.dart';
import 'package:bridella/users/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/services/auth_services.dart';

class GuestDrawer extends StatefulWidget {
  static const padding = EdgeInsets.symmetric(horizontal: 20);

  const GuestDrawer({super.key});
  
  @override
  State<GuestDrawer> createState() => _GuestDrawerState();
}

class _GuestDrawerState extends State<GuestDrawer> {
  void signOut() {
    context.read<FirebaseAuthMethods>().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BridellaUser?>(context);

    return
     Drawer(
      child: Container(
        color: bridellaBGColor,
        child: ListView(
          children: <Widget>[
            user == null
                ? const Center(child: CircularProgressIndicator())
                : buildHeader(
                    context,
                    urlImage: user.urlAvatar ?? 'assets/avatar/v2.png',
                    name: user.displayName ?? 'Unknown',
                    email: user.email ?? '',
                  ),
            Container(
              padding: GuestDrawer.padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    context,
                    onPressed: () {
                      Navigator.pushNamed(context, ProfilePage.routeName);
                    },
                    text: 'Profile',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    context,
                    onPressed: () {
                      Navigator.pushNamed(context, FriendsPage.routeName);
                    },
                    text: 'Friends',
                    icon: Icons.people,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    context,
                    onPressed: () {
                      Navigator.pushNamed(context, NotificationsPage.routeName);
                    },
                    text: 'Notifications',
                    icon: Icons.notifications_outlined,
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.black.withOpacity(0.3)),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    context,
                    onPressed: () {
                      Navigator.pushNamed(context, SettingPage.routeName);
                    },
                    text: 'Settings',
                    icon: Icons.settings,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    context,
                    onPressed: () {
                      Navigator.pop(context);
                      showAboutDialog(
                          context: context,
                          applicationIcon: Image.asset(
                            'assets/Bridella.png',
                            width: 80,
                            height: 80,
                          ),
                          applicationVersion: '0.0.1',
                          children: []);
                    },
                    text: 'About us',
                    icon: Icons.info_outline,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    context,
                    onPressed: () {
                      signOut();
                    },
                    text: 'Log out',
                    icon: Icons.logout_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context,
      {required String text,
      required IconData icon,
      required Function() onPressed}) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(text,
            style: const TextStyle(color: Colors.black, fontSize: 16)),
        onTap: onPressed,
      ),
    );
  }

  Widget buildHeader(
    BuildContext context, {
    required String urlImage,
    required String name,
    required String email,
  }) =>
      Material(
        color: kSecondaryColor.withOpacity(0.05),
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: GuestDrawer.padding
                .add(const EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: bridellaBGColor,
                    radius: 30,
                    backgroundImage: NetworkImage(urlImage)),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
 