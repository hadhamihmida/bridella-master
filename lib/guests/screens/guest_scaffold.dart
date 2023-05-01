import 'package:bridella/app_core/services/constants.dart';

import 'package:flutter/material.dart';

import '../../wishes/screens/timeline_screen.dart';
import '../widgets/guest_drawer.dart';

class GuestScaffold extends StatefulWidget {
  static String routeName = "/guest_Scaffold";
  const GuestScaffold({super.key});

  @override
  State<GuestScaffold> createState() => _GuestScaffoldState();
}

class _GuestScaffoldState extends State<GuestScaffold> {
  int _selectedIndex = 0;
  final int homeIndex = 0;
  final int chatIndex = 1;
  final int marketPlaceIndex = 2;
  final int plannerIndex = 3;
  final List _screens = [
    const TimeLinePage(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color inActiveIconColor = const Color(0XFF8B8B8B);
  @override
  Widget build(BuildContext context) {
    const titleLIst = ['Home', 'Chats', 'MarketPlace', 'Planner'];
    //
    return Scaffold(
        endDrawer: const GuestDrawer(),
        appBar: AppBar(
          elevation: 2,
          title: Text(
            titleLIst[_selectedIndex],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        body: Center(
          child: _screens.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconBottomBar(
                      text: "Search",
                      icon: Icons.search_outlined,
                      selected: false,
                      onPressed: () {}),
                  IconBottomBar(
                      text: "Chats",
                      icon: Icons.chat_bubble_outline_rounded,
                      selected: false,
                      onPressed: () {
                        _onItemTapped(chatIndex);
                      }),
                  IconBottomBar(
                      text: "Cart",
                      icon: Icons.local_grocery_store_outlined,
                      selected: false,
                      onPressed: () {
                        _onItemTapped(marketPlaceIndex);
                      }),
                  IconBottomBar(
                      text: "Calendar",
                      icon: Icons.date_range_outlined,
                      selected: false,
                      onPressed: () {
                        _onItemTapped(plannerIndex);
                      }),
                  const Spacer(),
                  IconBottomBar2(
                      text: "Home",
                      icon: Icons.home,
                      selected: true,
                      onPressed: () {
                        _onItemTapped(homeIndex);
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? kPrimaryLightColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
