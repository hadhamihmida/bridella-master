import 'package:bridella/business/screens/market_place_screen.dart';
import 'package:bridella/social/screens/chat_home.dart';
import 'package:bridella/wishes/screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../planner/screens/planner_screen.dart';
import '../services/constants.dart';
import '../widgets/custom_drawer2.dart';

class BridellaScaffold extends StatefulWidget {
  static String routeName = "/bridella_scaffold";
  const BridellaScaffold({super.key});

  @override
  State<BridellaScaffold> createState() => _BridellaScaffoldState();
}

class _BridellaScaffoldState extends State<BridellaScaffold> {
  int _selectedIndex = 0;
  final int homeIndex = 0;
  final int marketPlaceIndex = 1;
  final int chatIndex = 2;
  final int plannerIndex = 3;
  final List _screens = [
    const TimeLinePage(),
    const MarketPlaceScreen(),
    const ChatHome(),
    const PlannerBridge()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color inActiveIconColor = const Color(0XFF8B8B8B);
  @override
  Widget build(BuildContext context) {
    const titleLIst = ['Timeline', 'Marketplace', 'Chats', ''];
    //
    return Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
        
      
            elevation: 2,
            title: Text(
              titleLIst[_selectedIndex],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: SvgPicture.asset("assets/icons/nav.svg",
                      height: 22, width: 22, color:Colors.pink),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ]),
        body: Center(
          child: _screens.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: bridellaBGColor, //
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: Colors.white.withOpacity(0.15),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), 
              topRight: Radius.circular(40),
            ),
          ),
          child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: iconWidget("home.svg", homeIndex),
                  

                    /*  const Icon(
                      Icons.home_filled,
                      size: 26,
                    ),*/

                    onPressed: () => _onItemTapped(homeIndex),
                  ),
                  IconButton(
                    
                    icon: 
                     iconWidget("market.svg", marketPlaceIndex),
                   

                    //const Icon(Icons.shopping_bag_outlined, size: 26),

                    onPressed: () => _onItemTapped(marketPlaceIndex),
                  ),
                  IconButton(
                    icon: iconWidget("chat.svg", chatIndex),
                    // const Icon(Icons.chat_outlined, size: 26),

                    onPressed: () => _onItemTapped(chatIndex),
                  ),
                  IconButton(
                    icon: iconWidget("planner.svg", plannerIndex,),
                    
                    //const Icon(Icons.today_rounded, size: 26),

                    onPressed: () => _onItemTapped(plannerIndex),
                  ),
                ],
              )),
        ));
  }

  Widget iconWidget(String name, int index) => SvgPicture.asset(
      "assets/icons/$name",
      height: 22,
      width: 22,
      color: index == _selectedIndex ? kPrimaryColor : const Color(0XFF8B8B8B));
}
