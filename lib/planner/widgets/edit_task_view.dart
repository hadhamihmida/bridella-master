import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/planner/models/task.dart';
import 'package:bridella/planner/services/task_db.dart';
import 'package:bridella/social/models/social.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../app_core/services/show_snackbar.dart';
import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/default_button.dart';
import '../../authentication/widgets/role_selector_view.dart';
import 'friends_popup.dart';

// AlertDialog: Adding a task
showTaskEdditingDialog(BuildContext context, Task task) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: EditTaskView(
            task: task,
          ),
          elevation: 2,
        );
      });
}

class EditTaskView extends StatefulWidget {
  final Task task;
  const EditTaskView({super.key, required this.task});
  @override
  _EditTaskViewState createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final h = SizeConfig.screenHeight;
  final w = SizeConfig.screenWidth;

  bool loading = false;
  DateTime? startingDate;
  DateTime? endingDate;

  TextEditingController startingDateController = TextEditingController();

  TextEditingController endingDateController = TextEditingController();
  TaskDataBase taskDB = TaskDataBase();
  final tabBars = [
    const FittedBox(
        child: Tab(
      icon: Icon(
        Icons.info_outline,
      ),
      text: 'Details',
      // height: 45,
    )),
    const FittedBox(
        child: Tab(
      icon: Icon(
        Icons.people_alt_outlined,
      ),
      text: 'Assign to',
    )),
    const FittedBox(
      child: Tab(
        icon: Icon(
          Icons.insert_comment_outlined,
        ),
        text: 'Comments',
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BridellaUser?>(context);
    final userSocial = Provider.of<Social?>(context);

    List<Friend> friendsList;
    List<Friend> assignedFriends = [];
    if (userSocial != null) {
      friendsList = userSocial.friends;
    } else {
      friendsList = [];
    }

    assignedFriends = friendsList
        .where((friend) => widget.task.sharedWith.contains(friend.id))
        .toList();
    final task = widget.task;

    Task editableTask = widget.task.copyWith();
    final tabs = [
      const SizedBox(),
      PopupFriendsView(
        friendAssignment: assignedFriends,
      ),
      const SizedBox()
    ];
    return SizedBox(
      height: SizeConfig.screenHeight * 0.5,
      width: SizeConfig.screenWidth * 0.9,
      child: loading || user == null
          ? Container(
              alignment: Alignment.center,
              height: SizeConfig.screenWidth * 0.75,
              child: const CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : Form(
              key: _formKey,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    TabBar(
                        indicatorColor: kPrimaryColor,
                        labelColor: kPrimaryColor,
                        labelStyle: const TextStyle(fontSize: 12),
                        tabs: tabBars),
                    Expanded(
                        child: TabBarView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: tabs,
                    )),
                  ],
                ),
              ),

              ///
              ///
              ///
              /// comments view
              ///
              ///
              ///
              ///
            ),
    );
  }

  DropdownButton dropdownOtpions(
    List<Friend> friends,
    List<Friend> assignedFriends,
  ) {
    //  bool editPressed = false;

    return DropdownButton(
      hint: const Text('Assign to'),
      items: friends.map((Friend friend) {
        return DropdownMenuItem<String>(
          value: friend.id,
          child: Text(friend.name),
        );
      }).toList(),
      onChanged: (newvalue) {
        setState(() {
          if (assignedFriends.any((friend) => friend.id == newvalue)) {
            return;
          } else {
            Friend friend =
                friends.firstWhere((friend) => friend.id == newvalue);
            assignedFriends.add(friend);
          }
        });
      },
    );
  }
}

/* 

                      // Item ID field
                      SizedBox(
                        height: h * 0.06,
                        child: TextFormField(
                          initialValue: editableTask.title,
                          decoration: decoration(hint: 'Title'),
                          onChanged: (value) {
                            editableTask.title;
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
                        initialValue: editableTask.desc,
                        decoration: decoration(hint: 'Description'),
                        onChanged: (value) {
                          editableTask.desc;
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
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          itemCount: friendsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Friend friend = friendsList[index];
                            return CheckboxListTile(
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(friend
                                              .imageUrl.isEmpty
                                          ? 'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=40d9e936-a88d-46f8-87b6-e07db6c9b3cc'
                                          : friend.imageUrl),
                                      backgroundColor: kPrimaryLightColor,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(friend.name),
                                  ],
                                ),
                                value: assignedFriends.contains(friend),
                                onChanged: (value) {
                                  setState(() {
                                    assignedFriends.add(friend);
                                  });
                                });
                          },
                        ),
                      ),
                      SizedBox(
                        height: h * 0.05,
                        child: TextFormField(
                          enabled: task.taskOwner == user.uid,
                          initialValue: DateFormat('yyyy-MM-dd')
                              .format(editableTask.startDate!),
                          decoration: decoration(
                              label: 'Starting Date',
                              hint: 'tape to pick a date',
                              sufIcon: const Icon(Icons.calendar_month)),
                          readOnly: true,
                          onTap: () async {
                            //taskData['startDate'] = startingDateController;

                            editableTask.startDate = await showDatePicker(
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
                                        .format(editableTask.startDate!);
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
                        height: h * 0.05,
                        child: TextFormField(
                          enabled: task.taskOwner == user.uid,
                          initialValue: DateFormat('yyyy-MM-dd')
                              .format(editableTask.deadLine!),
                          decoration: decoration(
                              label: 'Deadline',
                              hint: 'tape to pick a date',
                              sufIcon: const Icon(Icons.calendar_month)),
                          readOnly: true,
                          onTap: () async {
                            editableTask.deadLine = await showDatePicker(
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
                                        .format(editableTask.deadLine!);
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
                       const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.65,
                    child: DefaultButton(
                      text: "Save",
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          // submit
                          // widget.catItemNames.add(taskData['itemId']);
                          // add the new item Id to the current category's items list
                          setState(() {
                            loading = true;
                          });
                          taskDB
                              .updateTask(
                                  widget.task.taskId, editableTask.toMap())
                              .then((value) {
                            showSnackBar(context, 'Task successfully updated');
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
                      
                      */