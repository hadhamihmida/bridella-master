import 'dart:io';

import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

class CreateWishView extends StatefulWidget {
  const CreateWishView({Key? key}) : super(key: key);

  @override
  State<CreateWishView> createState() => _CreateWishViewState();
}

class _CreateWishViewState extends State<CreateWishView> {
  final TextEditingController _postTxtController = TextEditingController();

  File? _postImageFile;
  //final ImagePicker _imagePicker = ImagePicker();
  bool isLoading = false;

  ///select image from camera or gallery
  /* selectImage(ImageSource imageSource) async {
    XFile? file = await _imagePicker.pickImage(source: imageSource);
    File? croppedFile = await myImageCropper(file!.path);
    setState(() {
      _postImageFile = croppedFile;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Wish',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : TextButton(
                  onPressed: () {}

                  /* async {
                    if (_postImageFile != null) {
                      setState(() {
                        isLoading = true;
                      });
                      bool isSubmitted = await _postManager.submitPost(
                          postImage: _postImageFile!,
                          description: _postTxtController.text);

                      setState(() {
                        isLoading = false;
                      });
                      if (isSubmitted) {
                        Fluttertoast.showToast(
                            msg: _postManager.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: bridellaBGColor,
                            fontSize: 16.0);
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            msg: _postManager.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: bridellaBGColor,
                            fontSize: 16.0);
                      }
                    } else {
                      //no image file selected
                      Fluttertoast.showToast(
                          msg: "Please select your a picture",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: bridellaBGColor,
                          fontSize: 16.0);
                    }
                  },*/
                  ,
                  child: const Text('Submit'))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select a Picture',
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
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
            child: _postImageFile == null
                ? Image.asset(
                    'assets/icons/placeholder.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    _postImageFile!,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            minLines: 3,
            maxLines: 10,
            controller: _postTxtController,
            decoration: InputDecoration(
                hintText: 'Post description here',
                hintStyle: const TextStyle(color: Colors.grey),
                label: Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyText1,
                )),
          )
        ],
      ),
    );
  }
}
