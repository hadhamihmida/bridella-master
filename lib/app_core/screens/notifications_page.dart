import 'package:bridella/app_core/services/constants.dart';
import 'package:flutter/material.dart';

import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/custom_app_bar.dart';

class NotificationsPage extends StatefulWidget {
  static String routeName = "/notifications_page";
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  static const List _options = ['All', 'Likes', 'Comments', 'Support'];
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(
        context,
        title: 'Notifications',
      ),
      body: Column(children: [
        const SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: buildoptions()),
          ],
        ),
        const SizedBox(height: 20),
        const Center(child: Text('Nothing to show here.'))
      ]),
    );
  }

  Widget buildoptions() {
    return Container(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      height: 40,
      child: ListView.separated(
        itemCount: _options.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildCatItem,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget _buildCatItem(BuildContext context, int index) {
    final isActive = _selectIndex == index;
    const radius = BorderRadius.all(Radius.circular(19));
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: isActive ? kPrimaryColor : const Color(0xFFFFFFFF),
      ),
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: radius,
        onTap: () => _onTapItem(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          child: Text(
            _options[index].toString(),
            style: TextStyle(
              color: isActive ? const Color(0xFFFFFFFF) : kPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
