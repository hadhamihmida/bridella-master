import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/app_core/services/show_snackbar.dart';
import 'package:bridella/app_core/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';

class RoleSelectorView extends StatefulWidget {
  final String email;
  final String password;
  const RoleSelectorView(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<RoleSelectorView> createState() => _RoleSelectorViewState();
}

class _RoleSelectorViewState extends State<RoleSelectorView> {
  bool groomSelected = false;
  bool brideSelected = false;
  bool guestSelected = false;
  late String selectedRole;
  DateTime? weddingDate;
  TextEditingController weddingDateController = TextEditingController();

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: widget.email,
          password: widget.password,
          accType: selectedRole,
          weddingDate: weddingDate != null
              ? DateFormat('yyyy-MM-dd').format(weddingDate!)
              : null,
          context: context,
        );
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeConfig.screenHeight * 0.45,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What's your role ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text.rich(TextSpan(
              //  text: "Press  Here to learn more about Bridella's roles.",
              children: [
                TextSpan(text: 'Press'),
                TextSpan(text: ' Here ', style: TextStyle(color: Colors.blue)),
                TextSpan(text: 'to learn more about Bridella\'s roles.')
              ],
              style: TextStyle(
                height: 1.4,
                fontSize: 13,
                // fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      brideSelected = !brideSelected;
                      groomSelected = false;
                      guestSelected = false;
                      selectedRole = 'bride';
                    });
                  },
                  child: CustomBoxInformation(
                    path: 'assets/testImages/bride2.png',
                    label: "Bride",
                    selected: brideSelected,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        groomSelected = !groomSelected;
                        brideSelected = false;
                        guestSelected = false;
                        selectedRole = 'groom';
                      });
                    },
                    child: CustomBoxInformation(
                      path: 'assets/testImages/groom.png',
                      label: "Groom",
                      selected: groomSelected,
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        guestSelected = !guestSelected;
                        brideSelected = false;
                        groomSelected = false;
                        selectedRole = 'guest';
                      });
                    },
                    child: CustomBoxInformation(
                      path: 'assets/testImages/wedding-invitation.png',
                      label: "Guest",
                      selected: guestSelected,
                    )),
              ],
            ),
            const SizedBox(height: 15),

            ///
            ///
            ///
            Visibility(
              visible: groomSelected || brideSelected ? true : false,
              child: SizedBox(
                height: SizeConfig.screenHeight * 0.08,
                child: TextFormField(
                  controller: weddingDateController,
                  decoration: decoration(
                      label: 'Wedding date',
                      hint: 'Pick your wedding date',
                      sufIcon: const Icon(Icons.calendar_month)),
                  readOnly: true,
                  onTap: () async {
                    /*  await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime
                            .now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));*/

                    weddingDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (weddingDate != null) {
                      print(
                          weddingDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(weddingDate!);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        weddingDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                  onChanged: (value) {
                    print('weddingdate $weddingDate');
                    print(value);
                  },
                ),
              ),
            ),

            ///
            ///
            ///
            ///
            const Spacer(),
            GestureDetector(
              onTap: (() {
                setState(() {
                  isLoading = true;
                });
                if (weddingDate != null || guestSelected == true) {
                  try {
                    signUpUser();
                  } catch (e) {
                    message('Somthing went wrong');
                    setState(() {
                      isLoading = false;
                    });
                  }
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  message('What is your wedding date please?');
                }
              }),
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.screenWidth,
                height: 50,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  isLoading ? 'loading...' : r"Confirm",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration decoration({String? label, String? hint, Widget? sufIcon}) {
  return InputDecoration(
    filled: true,
    focusColor: kPrimaryLightColor,
    border: InputBorder.none,
    // labelText: label,
    labelStyle: const TextStyle(color: kPrimaryColor),
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    hintText: hint,

    enabledBorder: InputBorder.none,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kPrimaryColor),
      gapPadding: 10,
    ),
    // fillColor: kPrimaryLightColor,
    hintStyle: const TextStyle(fontSize: 12),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    suffixIcon: sufIcon,
  );
}

class CustomBoxInformation extends StatelessWidget {
  const CustomBoxInformation(
      {Key? key,
      required this.path,
      required this.label,
      required this.selected})
      : super(key: key);
  final String path;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.26,
      height: SizeConfig.screenHeight * 0.14,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.3,
            color: selected ? kPrimaryColor : kSecondaryColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Icon(
              boxIcon,
              color: kSecondaryColor,
            ),*/
            Image.asset(
              path,
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(50),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: kSecondaryColor, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

void showRoleSelectorSheet(
    BuildContext context, String email, String password) {
  SizeConfig().init(context);
  showModalBottomSheet(
      backgroundColor: bridellaBGColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        //3
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return DraggableScrollableSheet(
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return RoleSelectorView(
                  email: email,
                  password: password,
                );
              });
        });
      });
}
