import 'package:bridella/app_core/bridella_app.dart';
import 'package:bridella/app_core/widgets/custom_app_bar.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dummy_data.dart';
import '../widgets/profile_widget.dart';
import '../widgets/text_field_widget.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = "/edit_profile_page";
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BridellaUser>(context);
    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(context,
          title: 'Edit your informations', actions: []),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            user: user,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Diplay Name',
            
            text: user.displayName ?? '',
            onChanged: (name) {},

            
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Phone',
            text: user.email ?? '',
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Address',
            text: user.address ?? '',
            maxLines: 2,
            onChanged: (about) {},
          ),
          TextFieldWidget(
            label: 'Bio',
            maxLines: 5,
            text: user.bio ?? '',
            onChanged: (name) {},
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
 