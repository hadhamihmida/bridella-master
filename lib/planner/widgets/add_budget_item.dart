import 'dart:math';

import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/planner/models/budget.dart';
import 'package:bridella/planner/services/budget_db.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/default_button.dart';

// AlertDialog: Adding a task
addBudgetItem(
  BuildContext context,
) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          scrollable: true,
          content: AddingBudgetItemView(),
          elevation: 2,
        );
      });
}

class AddingBudgetItemView extends StatefulWidget {
  const AddingBudgetItemView({
    super.key,
  });
  @override
  _AddingBudgetItemViewState createState() => _AddingBudgetItemViewState();
}

class _AddingBudgetItemViewState extends State<AddingBudgetItemView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final h = SizeConfig.screenHeight;
  final w = SizeConfig.screenWidth;

  bool loading = false;

  BudgetDB budgetDb = BudgetDB();
  final Map<String, dynamic> _itemData = {
    'desc': '',
    'certifiedBridella': null,
    'price': null,
  };
  var list = [
    'toaster',
    'coffee maker',
    'blender',
    'forks',
    'spoons',
    'knives',
    'plates',
    'bowls',
    'cups'
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BridellaUser?>(context);
    final budgetList = Provider.of<Budget>(context);

    // generate a random index based on the list length
// and use it to retrieve the element
    final suggestedProductIndex = Random().nextInt(list.length);

    return SizedBox(
        width: SizeConfig.screenWidth * 0.75,
        child: loading
            ? Container(
                alignment: Alignment.center,
                height: SizeConfig.screenWidth * 0.75,
                child: const CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              )
            : Column(children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Add a new product to your Budget",
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Item ID field
                      TextFormField(
                        maxLines: 1,
                        decoration: decoration(
                            hint: "Example : ${list[suggestedProductIndex]} ",
                            label: 'Product name'),
                        onChanged: (value) {
                          _itemData['name'] = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field can't be empty";
                          } else if (value.contains(RegExp(r'^[1-9]'))) {
                            return 'The product name is invalid!';
                          }
                        },
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      // Item Name field
                      TextFormField(
                        decoration:
                            decoration(label: 'Estimated price', hint: 'dt'),
                        onChanged: (value) {
                          _itemData['estimatedPrice'] =
                              double.tryParse(value) ?? 0;
                          setState(() {});
                          print(_itemData);
                        },
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field can't be empty";
                          } else if (value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                            return 'Use only numbers!';
                          }
                        },
                      ),

                      const SizedBox(height: 6),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.65,
                        child: DefaultButton(
                          text: "Submit",
                          press: () async {
                            if (_formKey.currentState!.validate() &&
                                user != null) {
                              setState(() {
                                loading = true;
                              });

                              final Random random = Random();

                              String generateID() {
                                var id = random.nextInt(100).toString();
                                final List<String> idsList = [];
                                for (var item in budgetList.items) {
                                  idsList.add(item.id);
                                }
                                while (idsList.contains(id)) {
                                  id = random.nextInt(100).toString();
                                }

                                return id.toString();
                              }

                              budgetDb
                                  .createBudgetItem(
                                      user.uid, generateID(), _itemData)
                                  .then((value) => Navigator.pop(context));

                              /*   taskDB
                                  .createTask(user.uid, itemData)
                                  .then((value) {
                                Navigator.pop(context);
                              }); */
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ]));
  }

  InputDecoration decoration({String? label, String? hint, Widget? sufIcon}) {
    return InputDecoration(
      filled: true,
      focusColor: kPrimaryColor,
      border: InputBorder.none,

      //  floatingLabelAlignment: FloatingLabelBehavior.never,
      labelText: label,
      labelStyle: const TextStyle(color: kPrimaryColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      hintText: hint,

      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: kPrimaryColor),
        gapPadding: 2,
      ),
      // fillColor: kPrimaryLightColor,

      hintStyle: const TextStyle(fontSize: 12),
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: sufIcon,
    );
  }
}
