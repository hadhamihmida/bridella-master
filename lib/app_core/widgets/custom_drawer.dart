/*import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/social/screens/friends_page.dart';
import 'package:bridella/users/screens/profile_screen.dart';
import 'package:bridella/wishes/screens/my_wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../planner/widgets/calendar_view.dart';

class BridellaDrawer extends StatelessWidget {
  const BridellaDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final settings = Provider.of<BridellaSettings>(context, listen: false);
    return Drawer(
      elevation: 1.0,
      backgroundColor: bridellaBGColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 40, 24, 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 0.5,
                height: 10,
                color: kSecondaryColor,
              ),
              const SizedBox(
                height: 20,
              ),
              /* PreferenceBuilder(
                  preference: settings.darkMode,
                  builder: (BuildContext context, bool darkMode) {
                    return SwitchListTile.adaptive(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.wb_sunny_outlined),
                          Text('Dark mode', textAlign: TextAlign.right),
                        ],
                      ),
                      dense: true,
                      activeColor: kPrimaryColor,
                      value: darkMode,
                      onChanged: (value) {
                        settings.darkMode.setValue(value);
                      },
                    );
                  }),
              const SizedBox(
                height: 30,
              ),*/
              DrawerItem(name: 'Home', icon: Icons.home, onPressed: () {}),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Profile',
                  icon: Icons.person,
                  onPressed: () {
                    Navigator.pushNamed(context, ProfilePage.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'My Wishlist',
                  icon: UniconsLine.gift,
                  onPressed: () {
                    Navigator.pushNamed(context, MywishlistBridge.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Friends',
                  icon: Icons.people,
                  onPressed: () {
                    Navigator.pushNamed(context, FriendsPage.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Planner',
                  icon: UniconsLine.calendar_alt,
                  onPressed: () {
                    Navigator.pushNamed(context, TableEventsExample.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Favourites',
                  icon: Icons.favorite_outline,
                  onPressed: () {}),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 0.5,
                height: 10,
                color: kSecondaryColor,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Settings', icon: Icons.settings, onPressed: () {}),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
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
                child: SizedBox(
                  height: 40,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'About us',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(name: 'Log out', icon: Icons.logout, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage(
            "assets/testImages/Profile Image.jpg",
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Rihab hmida',
                style: TextStyle(
                  fontSize: 14,
                )),
            SizedBox(
              height: 10,
            ),
            Text('person@email.com',
                style: TextStyle(
                  fontSize: 14,
                ))
          ],
        )
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/