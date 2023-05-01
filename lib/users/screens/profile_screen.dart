import 'package:bridella/app_core/services/size_config.dart';
import 'package:bridella/backg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/screens/Bridella_Scaffold.dart';
import '../../app_core/services/constants.dart';
import '../../app_core/widgets/custom_app_bar.dart';

import '../../wishes/widgets/backfile.dart';
import '../models/user.dart';
import '../widgets/numbers_widget.dart';
import '../widgets/profile_widget.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile_page";
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //const user = UserPreferences.myUser;
    final user = Provider.of<BridellaUser>(context);

    // return Scaffold(
    //   appBar: ClassicAppBar.defaultAppBar(
    //     context,
    //     title: 'Profile',
    //     actions: [],
    //   ),

    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(
        context,
        title: 'Profile',
        actions: [],
      ),
      body: Container(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Color.fromRGBO(99, 93, 97, 1),
                  height: 200,
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Color.fromRGBO(225, 9, 157, 1),
                height: 180,
              ),
            ),
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  height: getProportionateScreenHeight(150),
                  alignment: Alignment.bottomCenter,
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage('assets/testImages/bridella_cover.png'),
                  //         fit: BoxFit.cover)),
                  child: ProfileWidget(
                    user: user,
                    isEdit: false,
                    onClicked: () {
                      Navigator.pushNamed(context, BridellaScaffold.routeName);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                buildName(user),
                const SizedBox(height: 24),
                const NumbersWidget(),
                const SizedBox(height: 24),
                buildAbout(user),
                /*  const Spacer(),
              Center(child: editProfileButton()), */
              ],
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, EditProfilePage.routeName) as void
                    Function();
              },
              icon: const Icon(Icons.edit),
              label: const Text(''),
            ),

            //  floatingActionButton: FloatingActionButton.extended(
            //   backgroundColor: kPrimaryColor,
            //   foregroundColor: Colors.white,
            //   onPressed: () {
            //     Navigator.pushNamed(context, EditProfilePage.routeName) as void
            //        Function();
            //  },
            // icon: const Icon(Icons.edit),
            //   label: const Text('Edit your profile'),
            // ),
          ],
        ),
      ),
    );

    // Scaffold(
    //   appBar: ClassicAppBar.defaultAppBar(
    //     context,
    //     title: 'Profile',
    //     actions: [],
    //   ),
    //   body: ListView(
    //     physics: const BouncingScrollPhysics(),
    //     children: [
    //       Container(
    //         height: getProportionateScreenHeight(150),
    //         alignment: Alignment.bottomCenter,
    //         decoration: const BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage('assets/testImages/bridella_cover.png'),
    //                 fit: BoxFit.cover)),
    //         child: ProfileWidget(
    //           user: user,
    //           isEdit: false,
    //           onClicked: () {
    //             Navigator.pushNamed(context, BridellaScaffold.routeName);
    //           },
    //         ),
    //       ),
    //       const SizedBox(height: 24),
    //       buildName(user),
    //       const SizedBox(height: 24),
    //       const NumbersWidget(),
    //       const SizedBox(height: 24),
    //       buildAbout(user),
    //       /*  const Spacer(),
    //       Center(child: editProfileButton()), */
    //     ],
    //   ),
    //   floatingActionButton: FloatingActionButton.extended(
    //     backgroundColor: kPrimaryColor,
    //     foregroundColor: Colors.white,
    //     onPressed: () {
    //       Navigator.pushNamed(context, EditProfilePage.routeName) as void
    //           Function();
    //     },
    //     icon: const Icon(Icons.edit),
    //     label: const Text('Edit your profile'),
    //   ),
    // );
  }

  Widget buildName(BridellaUser user) => Column(
        children: [
          Text(
            user.displayName ?? 'Undefined',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? 'Undefined',
            style: const TextStyle(color: Color.fromARGB(255, 16, 12, 14)),
          )
        ],
      );

  Widget editProfileButton() => SizedBox(
        width: SizeConfig.screenWidth * .7,
        height: getProportionateScreenHeight(56),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: bridellaBGColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, EditProfilePage.routeName) as void
                Function();
          },
          child: Text(
            "Edit profile",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: bridellaBGColor,
            ),
          ),
        ),
      );

  Widget buildAbout(BridellaUser user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bio',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            Text(
              user.bio ??
                  'Add a bio to make your friends know more about you :)',
              style: const TextStyle(
                  fontSize: 16, height: 1.4, color: Colors.black),
            ),
          ],
        ),
      );
}
