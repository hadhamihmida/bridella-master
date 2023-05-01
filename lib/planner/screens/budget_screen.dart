import 'package:bridella/app_core/services/bridella_settings.dart';
import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/app_core/services/show_snackbar.dart';
import 'package:bridella/planner/models/budget.dart';
import 'package:bridella/planner/services/budget_db.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/animation.dart';
import '../../app_core/services/size_config.dart';
import '../widgets/add_budget_item.dart';
import '../widgets/add_task_view.dart';

class BudgetPage extends StatefulWidget {
  static String routeName = "/budget_screen";

  const BudgetPage({Key? key}) : super(key: key);

  @override
  BudgetPageState createState() => BudgetPageState();
}

enum BudgetView { all, uncompleted, completed, flaged }

class BudgetPageState extends State<BudgetPage>
    with SingleTickerProviderStateMixin {
  // This variable holds the list's items
  /*List<BudgetItem> budgetItems = [
    BudgetItem(
        id: '0',
        title: 'Product X',
        flaged: false,
        price: 0,
        estimatedPrice: 0,
        completed: false),
    BudgetItem(
        id: '1',
        title: 'Product Y',
        flaged: false,
        price: 0,
        estimatedPrice: 0,
        completed: false),
    BudgetItem(
        id: '2',
        title: 'Product Z',
        flaged: false,
        price: 0,
        estimatedPrice: 200,
        completed: false),
    BudgetItem(
        id: '3',
        title: 'Product W',
        flaged: false,
        price: 0,
        estimatedPrice: 0,
        completed: false),
    BudgetItem(
        id: '4',
        title: 'Product XY',
        flaged: false,
        price: 0,
        estimatedPrice: 0,
        completed: false),
    BudgetItem(
        id: '5',
        title: 'Product WZ',
        flaged: false,
        price: 0,
        estimatedPrice: 0,
        completed: false),
    BudgetItem(
        id: '6',
        title: 'Product WY',
        flaged: false,
        price: 0,
        estimatedPrice: 0,
        completed: false),
  ];*/
  final Map<String, dynamic> _editeditemsData = {};
  BudgetDB budgetDb = BudgetDB();
  bool edited = false;
  bool updatingPrice = false;
  late Budget budget;
  late TabController _tabController;

  @override
  void initState() {
    // budget = Budget(budgetItems);
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _formKeyAll = GlobalKey<FormState>();
  final _formKeyCompleted = GlobalKey<FormState>();

  final _formKeyUncompleted = GlobalKey<FormState>();

  final _formKeyFlaged = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BridellaUser>(context);
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: FadeAnimation(
            transFactor: -30.0,
            delay: 0.5,
            child: FloatingActionButton(
              onPressed: () {
                addBudgetItem(context);
              },
              backgroundColor: testColor,
              child: const Icon(Icons.add),
            ),
          ),
          appBar: AppBar(
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                    visible: edited,
                    child: ElevatedButton(
                        onPressed: () {
                          GlobalKey<FormState> formKey;
                          switch (_tabController.index) {
                            case 0:
                              {
                                formKey = _formKeyAll;
                              }
                              break;

                            case 1:
                              {
                                formKey = _formKeyUncompleted;
                              }
                              break;
                            case 2:
                              {
                                formKey = _formKeyCompleted;
                              }
                              break;

                            default:
                              {
                                formKey = _formKeyFlaged;
                              }
                              break;
                          }
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              edited = !edited;
                              updatingPrice = true;
                            });

                            budgetDb
                                .editItem(user.uid, _editeditemsData)
                                .then((value) => setState(() {
                                      updatingPrice = false;
                                    }));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(40, 40),
                          backgroundColor: kPrimaryColor,
                          shape: const CircleBorder(
                              side:
                                  BorderSide(width: 2.0, color: Colors.white)),
                        ),
                        child: const Icon(Icons.save))),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                    icon: Text(
                  'All',
                  style: ts(),
                )),
                FittedBox(child: Tab(icon: Text('Uncompleted', style: ts()))),
                Tab(icon: Text('Completed', style: ts())),
                Tab(icon: Text('Flaged', style: ts())),
              ],
            ),
            title: const Text(
              'My Budget',
              style: TextStyle(color: kSecondaryColor),
            ),
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Back ICon.svg",
                color: kSecondaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              /// all items
              body(BudgetView.all, _formKeyAll),

              /// completed items
              body(BudgetView.uncompleted, _formKeyUncompleted),

              /// uncompleted items
              body(BudgetView.completed, _formKeyCompleted),

              /// flaged items
              body(BudgetView.flaged, _formKeyFlaged),
            ],
          ),
        ));
  }

  Widget body(BudgetView budgetView, Key formKey) {
    BudgetDB budgetDB = BudgetDB();
    final settings = Provider.of<BridellaSettings>(context);
    final user = Provider.of<BridellaUser>(context);
    final budgetList = Provider.of<Budget?>(context);

    return budgetList == null
        ? const Center(
            child: CircularProgressIndicator(
            color: kPrimaryColor,
          ))
        : Form(
            key: formKey,
            // add empty text 'nothing to show here'
            child: budgetList.items.isEmpty
                ? const Center(child: Text('Nothing to show here'))
                : ReorderableListView(

                    ///
                    ///
                    ///
                    ///Header
                    ///
                    ///
                    ///
                    ///
                    header: budgetView == BudgetView.all
                        ? Card(
                            elevation: 0.5,
                            child: Container(
                              height: getProportionateScreenHeight(75),
                              alignment: Alignment.bottomCenter,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/testImages/budget_banner2.png'),
                                      fit: BoxFit.cover)),
                            ),
                          )
                        : null,

                    ///
                    ///
                    ///
                    ///
                    ///
                    /// Footer
                    ///
                    ///
                    ///
                    ///
                    ///
                    ///
                    footer: budgetView == BudgetView.all
                        ? Container(
                            padding: const EdgeInsets.only(
                                top: 8, right: 8, bottom: 100),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Total : ${budgetList.getAllTotal} dt',
                              style: const TextStyle(color: kSecondaryColor),
                            ), //label text
                          )
                        : null,
                    children: budgetList.items
                        .map((item) {
                          return BudgetElement(
                            key: ValueKey(item.id),
                            title: item.title,
                            estimatedPrice: item.estimatedPrice,
                            flaged: settings.flagedItems
                                .getValue()
                                .contains(item.id),
                            completed: settings.completedItems
                                .getValue()
                                .contains(item.id),
                            certifiedBridella: item.certifiedBridella,

                            ///
                            ///
                            ///
                            ///
                            ///
                            /// completing
                            ///
                            ///
                            ///
                            ///
                            ///
                            onComplete: (bool? newValue) {
                              // read the flaged items list
                              List<String> completedItems =
                                  settings.completedItems.getValue();
                              if (completedItems.contains(item.id)) {
                                // remove the flaged item from the list
                                completedItems.remove(item.id);
                                // update the record
                                settings.completedItems
                                    .setValue(completedItems);
                                setState(() {});
                              } else {
                                message('Congrats 😊');
                                completedItems.add(item.id);

                                settings.completedItems
                                    .setValue(completedItems);
                                //price = estimated price ;
                                setState(() {});
                              }
                            },

                            ///
                            ///
                            ///
                            ///
                            ///
                            /// edditing
                            ///
                            ///
                            ///
                            ///
                            ///
                            onEdit: (value) {
                              Map<String, dynamic> itemData = {item.id: {}};
                              _editeditemsData.addEntries(itemData.entries);
                              _editeditemsData[item.id]['estimatedPrice'] =
                                  double.tryParse(value) ?? 0;
                              edited = true;
                              //   item.estimatedPrice = double.tryParse(value) ?? 0;
                              setState(() {});
                              print(_editeditemsData);
                            },

                            ///
                            ///
                            ///
                            ///
                            /// flaging
                            ///
                            ///
                            ///
                            ///
                            ///
                            onFlag: (c) {
                              // read the flaged items list
                              List<String> flagedItems =
                                  settings.flagedItems.getValue();
                              if (flagedItems.contains(item.id)) {
                                // remove the flaged item fom the list
                                flagedItems.remove(item.id);
                                // update the record
                                settings.flagedItems.setValue(flagedItems);
                                setState(() {});
                              } else {
                                // add the new flaged item to the list
                                flagedItems.add(item.id);
                                // update the record
                                settings.flagedItems.setValue(flagedItems);
                                setState(() {});
                              }
                            },

                            ///
                            ///
                            ///
                            ///planning
                            ///
                            ///
                            ///
                            onPlan: (c) => showTaskAddingDialog(c, item.title),
                           

                            ///
                            ///
                            ///
                            /// deleting
                            ///
                            ///
                            onDelete: (c) =>
                                budgetDB.deleteBudgetItem(user.uid, item.id),

                            ///
                            ///
                            ///
                            ///
                            ///
                            ///
                          );
                        })
                        .where((item) => budgetView == BudgetView.completed
                            ? item.completed
                            : budgetView == BudgetView.flaged
                                ? item.flaged
                                : budgetView == BudgetView.uncompleted
                                    ? !item.completed
                                    : true)
                        .toList()
                      ..sort((a, b) => a.completed
                          .toString()
                          .compareTo(b.completed.toString())),
                    //Map<int, Model> modelMap = models.map((model) => MapEntry(model.id, model)).toMap();
                    // The reorder function
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final element = budget.items.removeAt(oldIndex);
                        budget.items.insert(newIndex, element);
                        setState(() {});
                      });
                    }));
  }

  TextStyle ts() => const TextStyle(color: Colors.black, fontSize: 12);
}

///
///
///
///
///
///
///
///
///
///
/// Budget Element
///
///
///
///
///
///
///
///
///
///
///
///
///
class BudgetElement extends StatefulWidget {
  final String title;
  final String? desc;
  final bool flaged;
  final bool completed;
  final double estimatedPrice;
  final bool? certifiedBridella;
  final Function(BuildContext)? onDelete;
  final Function(BuildContext)? onFlag;
  final Function(String) onEdit;
  final Function(BuildContext)? onPlan;
  final Function(bool?)? onComplete;

  const BudgetElement(
      {required this.title,
      required this.flaged,
      this.onDelete,
      required this.completed,
      this.certifiedBridella,
      this.onComplete,
      this.onPlan,
      required this.onEdit,
      this.onFlag,
      this.desc,
      required this.estimatedPrice,
      Key? key})
      : super(key: key);

  @override
  State<BudgetElement> createState() => BudgetElementState();
}

class BudgetElementState extends State<BudgetElement> {
  bool _edit = false;
  String? _fieldValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        //height: 100,
        // const Color.fromARGB(255, 255, 243, 247)
        child: Card(
            color: widget.completed
                ? const Color.fromARGB(255, 237, 255, 241)
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 1,
            //color: ,

            margin: const EdgeInsets.only(bottom: 4),
            child: Slidable(
              /* startActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                // sa : SlidableAction
                sa(Colors.blue, 'Completed', widget.onEdit),
              ],
            ),*/
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children:

                    // if the product is certified bridella we can't plan it (plan action not available)
                    !widget.certifiedBridella!
                        ? [
                            // sa : SlidableAction
                            sa(Colors.blue, 'Plan', widget.onPlan),
                            sa(kPrimaryColor, widget.flaged ? 'Unflag' : 'Flag',
                                widget.onFlag),
                            sa(const Color.fromARGB(255, 206, 206, 206),
                                'Delete', widget.onDelete)
                          ]
                        : [
                            // sa : SlidableAction

                            sa(kPrimaryColor, widget.flaged ? 'Unflag' : 'Flag',
                                widget.onFlag),
                            sa(const Color.fromARGB(255, 206, 206, 206),
                                'Delete', widget.onDelete)
                          ],
              ),
              child: ListTile(
                //   contentPadding: const EdgeInsets.all(25),
                leading: widget.certifiedBridella!
                    ? Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          'assets/launch_icon.png',
                          height: 20,
                          width: 20,
                        ),
                      )
                    : Checkbox(
                        shape: const CircleBorder(),
                        activeColor: Colors.green,
                        value: widget.completed,
                        onChanged: widget.onComplete),
                title: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.w200),
                ),

                trailing: SizedBox(
                  width: size.width * .25,
                  child: Row(
                    children: [
                      priceView(),
                      widget.flaged
                          ? const Flexible(
                              child: Icon(
                                Icons.flag,
                                color: kPrimaryColor,
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget priceView() {
    Size size = MediaQuery.of(context).size;

    return !_edit
        ? TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 80, 80, 80),
            ),
            onPressed: widget.certifiedBridella!
                ? null
                : () {
                    setState(() {
                      _edit = !_edit;
                    });
                  },
            child: FittedBox(
              child: Text(
                '${_fieldValue ?? widget.estimatedPrice.toString()} dt',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        // price editing view
        : SizedBox(
            width: size.width * .15,
            height: size.width * .1,
            child: TextFormField(
              textAlign: TextAlign.center,
              initialValue: widget.estimatedPrice.toString(),
              autofocus: true,

              decoration: decoration(),

              onEditingComplete: () {
                setState(() {
                  _edit = !_edit;
                });
                // clear the the fieldvalue in case it have an String value
                // to prevent it from displaying in the textbutton widget (when not null)
                if (_fieldValue != null &&
                    _fieldValue!.contains(RegExp(r'^[a-zA-Z\-]'))) {
                  setState(() {
                    _fieldValue = null;
                  });
                }
              },
              onChanged: (value) {
                setState(() {
                  _fieldValue = value;
                });
                if (_fieldValue != null &&
                    _fieldValue != widget.estimatedPrice.toString()) {
                  widget.onEdit(_fieldValue!);
                }
              },
              validator: ((value) {
                if (value == null ||
                    value.contains(RegExp(r'^[a-zA-Z\-]')) ||
                    value.isEmpty) {
                  return 'invalid';
                }
              }),

              keyboardType: TextInputType.number,
              //_inputType,
              enabled: _edit,
            ),
          );
  }

  InputDecoration decoration() {
    return const InputDecoration(
      filled: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }
}
