import 'package:bridella/app_core/screens/Bridella_Scaffold.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';

class ProfileWidget extends StatelessWidget {
  final BridellaUser user;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.user,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(8.0),
      // color: Colors.green,
      alignment: Alignment.center,
      height: getProportionateScreenHeight(100),
      width: getProportionateScreenHeight(100),
      child: !isEdit
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                buildImage(context, user.partnerAvatar ?? ''),
                Positioned(
                  top: 32,
                  right: 32,
                  child: buildImage(context, user.urlAvatar ?? ''),
                )
              ],
            )
          : Stack(
              clipBehavior: Clip.none,
              children: [
                buildEditIcon(context),
                Positioned(
                  top: 32,
                  right: 32,
                  child: buildEditIcon(context),
                )
              ],
            ),
    );
  }

  /*builddoubleimgs() => Center(
        child: Stack(
          children: [
            buildImage(),
            Positioned(
              top: 0,
              right: 4,
              child: buildImage(),
            )
          ],
        ),
      );
*/
  Widget buildImage(BuildContext c, String path) {
    return SizedBox(
      // padding: const EdgeInsets.all(8.0),
      child: ClipOval(
        child: Material(
          color: kPrimaryColor,
          child: Ink.image(
            image: NetworkImage(path),
            fit: BoxFit.cover,
            width: 70,
            height: 70,
            child: InkWell(onTap: onClicked),
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(BuildContext c) => buildCircle(
        color: bridellaBGColor,
        all: 3,
        child: buildCircle(
          color: kPrimaryColor,
          all: 8,
          child: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: c,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              //  Navigator.pop(context);
                              //   selectImage(ImageSource.camera);
                            },
                            icon: const Icon(UniconsLine.camera),
                            label: const Text('Select from Camera')),
                        const Divider(),
                        TextButton.icon(
                            onPressed: () {
                              //    Navigator.pop(context);
                              //   selectImage(ImageSource.gallery);
                            },
                            icon: const Icon(UniconsLine.picture),
                            label: const Text('Select from Gallery')),
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.add_a_photo,
              color: bridellaBGColor,
              size: 20,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
