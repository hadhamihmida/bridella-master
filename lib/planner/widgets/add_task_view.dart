import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/planner/services/task_db.dart';
import 'package:bridella/social/models/social.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/show_snackbar.dart';
import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/default_button.dart';
import 'input_decoration.dart';

// AlertDialog: Adding a task
showTaskAddingDialog(BuildContext context, String? title) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 248, 222, 231),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2000),
                    bottomRight: Radius.circular(1000))),
            bottom: PreferredSize(
                child: SizedBox(), preferredSize: Size.fromHeight(40)),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Color.fromARGB(255, 36, 34, 34),
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            scrollable: true,
            content: AddingTaskView(
              title: title,
            ),
            elevation: 2,
          ),
        );
      });
}

class AddingTaskView extends StatefulWidget {
  final String? title;
  const AddingTaskView({super.key, this.title});
  @override
  _AddingTaskViewState createState() => _AddingTaskViewState();
}

class _AddingTaskViewState extends State<AddingTaskView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final h = SizeConfig.screenHeight;
  final w = SizeConfig.screenWidth;

  bool loading = false;
  DateTime? startingDate;
  DateTime? endingDate;

  List<String> friends = ['Ahmed', 'Rami', 'Ziyed'];
  TextEditingController startingDateController = TextEditingController();

  TextEditingController endingDateController = TextEditingController();
  TaskDataBase taskDB = TaskDataBase();
  final Map<String, dynamic> taskData = {
    'status': 'active',
    'sharedWith': {},
    'comments': {},
    'completed': false
  };
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BridellaUser?>(context);
    final userSocial = Provider.of<Social?>(context);
    List<Friend> friendsList;
    if (userSocial != null) {
      friendsList = userSocial.friends;
    } else {
      friendsList = [];
    }

    return SizedBox(
      width: SizeConfig.screenWidth * 0.75,
      child: loading
          ? Container(
              alignment: Alignment.center,
              height: SizeConfig.screenWidth * 0.75,
              child: const CircularProgressIndicator(
                color: Color.fromARGB(255, 16, 15, 15),
              ),

/*
Scaffold(
              appBar: AppBar(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2000),
                )),
                backgroundColor: Colors.pink,
              ),*/
            )
          : Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Create a new Task",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: kSecondaryColor),
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                /*  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () async {
                          await showModalBottomSheet(
                              isScrollControlled:
                                  true, // required for min/max child size
                              context: context,
                              builder: (ctx) {
                                return MultiSelectBottomSheet(
                                  items: friendsList
                                      .map((e) => MultiSelectItem(e, e.name))
                                      .toList(),
                                  initialValue: const [],
                                  onConfirm: (values) {},
                                  maxChildSize: 0.8,
                                );
                              });
                        },
                        child: const Text('Shared with'))),*/
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Item ID field
                      SizedBox(
                        height: h * 0.06,
                        child: TextFormField(
                          initialValue: widget.title,
                          decoration: decoration(hint: 'Title'),
                          onChanged: (value) {
                            taskData['title'] = value;
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field can't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      // Item Name field
                      TextFormField(
                        decoration: decoration(hint: 'Description'),
                        onChanged: (value) {
                          taskData['desc'] = value;
                          setState(() {});
                        },
                        minLines: 2,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field can't be empty";
                          }
                        },
                      ),

                      SizedBox(
                        height: h * 0.05,
                      ),
                      /*
                  // picked friends show here
                  //
                  pickedOptions.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: pickedOptions.length,
                              itemBuilder: (context, i) {
                                return Chip(
                                  label: Text(
                                    pickedOptions[i],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  onDeleted: () {
                                    setState(() {
                                      pickedOptions.remove(pickedOptions[i]);
                                    });
                                  },
                                );
                              }),
                        ),
    */
                      SizedBox(
                        height: h * 0.08,
                        child: TextFormField(
                          controller: startingDateController,
                          decoration: decoration(
                              label: 'Starting Date',
                              hint: 'tape to pick a date',
                              sufIcon: const Icon(Icons.calendar_month)),
                          readOnly: true,
                          onTap: () async {
                            //taskData['startDate'] = startingDateController;

                            startingDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );

                            if (startingDate != null) {
                              print(
                                  startingDate); //pickedDate output format => 2021-03-10 00:00:00.000

                              setState(() {
                                startingDateController.text =
                                    DateFormat('yyyy-MM-dd')
                                        .format(startingDate!);
                                //set output date to TextField value.
                              });
                            } else {}
                          },
                          minLines: 2,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field can't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      SizedBox(
                        height: h * 0.08,
                        child: TextFormField(
                          controller: endingDateController,
                          decoration: decoration(
                              label: 'Deadline',
                              hint: 'tape to pick a date',
                              sufIcon: const Icon(Icons.calendar_month)),
                          readOnly: true,
                          onTap: () async {
                            endingDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );

                            if (endingDate != null) {
                              print(
                                  endingDate); //pickedDate output format => 2021-03-10 00:00:00.000

                              setState(() {
                                endingDateController.text =
                                    DateFormat('yyyy-MM-dd')
                                        .format(endingDate!);
                                //set output date to TextField value.
                              });
                            } else {}
                          },
                          minLines: 2,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field can't be empty";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.65,
                  child: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        taskData['startDate'] = startingDateController.text;
                        taskData['deadLine'] = endingDateController.text;
                        taskData['taskOwner'] = user!.uid;

                        if (widget.title != null) {
                          taskData['title'] = widget.title;
                        }

                        print(taskData);
                        // submit
                        // widget.catItemNames.add(taskData['itemId']);
                        // add the new item Id to the current category's items list
                        setState(() {
                          loading = true;
                        });
                        taskDB.createTask(taskData).then((value) {
                          showSnackBar(context, 'Task successfully added');
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                        });

                        // we add then the item to db
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  List<String> pickedOptions = [];
  DropdownButton dropdownOtpions(
    List<String> friends,
  ) {
    //  bool editPressed = false;

    return DropdownButton(
      hint: const Text('Assign to'),
      items: friends.map((friend) {
        return DropdownMenuItem<String>(
          value: friend,
          child: Text(friend),
        );
      }).toList(),
      onChanged: (newvalue) {
        setState(() {
          pickedOptions.add(newvalue);
          // taskData['iOpt'] = pickedOptions as Map<String, dynamic>;
        });
      },
    );
  }
}
// ignore: camel_case_types

//onpressed check


    
     
        
          
        
    
    
  

