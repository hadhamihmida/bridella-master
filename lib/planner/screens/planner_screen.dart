import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/planner/services/task_db.dart';
import 'package:bridella/planner/widgets/add_task_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../app_core/services/animation.dart';
import '../../app_core/services/size_config.dart';
import '../models/task.dart';
import '../widgets/build_stacked_avatars.dart';
import '../widgets/edit_task_view.dart';
import '../widgets/planner_banner.dart';
import '../widgets/wedding_counter_widget.dart';

// the bridge help us with the (context) to listen to the list of TASKS
class PlannerBridge extends StatelessWidget {
  const PlannerBridge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>?>(context);
    print('task : $tasks');
    return PLannerPage(tasks: tasks ?? []);
  }
}

class PLannerPage extends StatefulWidget {
  static String routeName = "/planner_page";
  final List<Task> tasks;
  const PLannerPage({super.key, required this.tasks});

  @override
  State<PLannerPage> createState() => _PLannerPageState();
}

class _PLannerPageState extends State<PLannerPage> {
  bool calendarvis = false;
  // editing start here
  late final ValueNotifier<List<Task>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Task> _getEventsForDay(DateTime day) {
    // Implementation example

    return widget.tasks.where((element) => element.deadLine == day).toList();
  }

  List<Task> listofTasks = [
    /*  Task('Event 1', {}, 'pay x', {}, 'active', DateTime.utc(2022, 12, 12)),
    Task('Event 2', {}, 'buy y', {}, 'active', DateTime.utc(2022, 12, 14)),
    Task('Event 3', {}, 'do z', {}, 'closed', DateTime.utc(2022, 12, 15)),*/
  ];
  List<Task> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  } //

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final we = SizeConfig.screenWidth;
    final he = SizeConfig.screenHeight;
    const animationTime = 0.8;
    TaskDataBase taskDB = TaskDataBase();

    return Scaffold(
      appBar: AppBar( shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(180.0),
                  bottomRight: Radius.circular(180.0)))),
                

      backgroundColor: Color.fromARGB(255, 238, 236, 236),
     
      body: 
     

      SafeArea(
        
      
        child: ListView(

          
          // physics: const NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          children: [
            
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const WeddingCounterChnunk(),
                /* InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    setState(() {
                      calendarvis = !calendarvis;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    */

                IconButton(
                  onPressed: () {
                    setState(() {
                      calendarvis = !calendarvis;
                    });
                  },

                  icon: !calendarvis
                      ? const Icon(
                          Icons.edit_calendar_rounded,
                          color: kSecondaryColor,
                        )
                      : const Icon(
                          Icons.visibility_off_rounded,
                          color: kSecondaryColor,
                        ),
                  // change the icon on state
                ),
              ],
            ),
            SizedBox(
              height: we * 0.1,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: FadeAnimation(
                delay: animationTime,
                transFactor: -30.0,
                child: Text(
                  "My tasks",
                  style: TextStyle(letterSpacing: 1, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.01,
            ),
            // from here
            /*   const  FadeAnimation(delay: animationTime, child: PlannerBanner()),
               const  Expanded(child: TableEventsExample()),*/
            // to here.

            calendarvis
                ? const SizedBox()
                : const FadeAnimation(
                    delay: animationTime,
                    transFactor: -30.0,
                    child: PlannerBanner()),
            calendarvis
                ? TableCalendar<Task>(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 197, 197, 197),
                          shape: BoxShape.circle),

                      selectedDecoration: BoxDecoration(
                          gradient: kPrimaryGradientColor,
                          shape: BoxShape.circle),
                      markerDecoration: BoxDecoration(
                          color: kPrimaryColor, shape: BoxShape.circle),
                      // Use `CalendarStyle` to customize the UI
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: _onDaySelected,
                    onRangeSelected: _onRangeSelected,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  )
                : const SizedBox(),

// here the tasks START

            const SizedBox(height: 8.0),
            Visibility(
              visible: calendarvis,
              child: FadeAnimation(
                
                  delay: animationTime,
                  transFactor: -30.0,
                  child: Expanded(
                    child: ValueListenableBuilder<List<Task>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              Task task = widget.tasks[index];

                              return TaskCard(
                                  onEdit: (context) {
// show popup for with task details (comments,editable fields)
                                    
                                    showTaskAddingDialog(context, null);
                                  },
                                  onDelete: (context) {
                                    taskDB.deleteTask(task.taskId);
                                  },
                                  onComplete: () {
                                    setState(() {
                                      task.completed = !task.completed;
                                    });
                                    // print(task.taskId);
                                    taskDB.updateTask(
                                        task.taskId, task.toMap());
                                  },
                                  task: task);
                            });
                      },
                    ),
                  )),
            ),
// here the tasks END

            ///
            ///
            /// ALL TASKS VIEW
            ///
            ///
            Visibility(
              visible: !calendarvis,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.tasks.length,
                  itemBuilder: (context, index) {
                    Task task = widget.tasks[index];

                    return TaskCard(
                        onEdit: (context) {
// show popup for with task details (comments,editable fields)
                          showTaskEdditingDialog(context, task);
                        },
                        onDelete: (context) {
                          taskDB.deleteTask(task.taskId);
                        },
                        onComplete: () {
                          setState(() {
                            task.completed = !task.completed;
                          });
                          // print(task.taskId);
                          taskDB.updateTask(task.taskId, task.toMap());
                        },
                        task: task);
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FadeAnimation(
        transFactor: -30.0,
        delay: animationTime,
        child: FloatingActionButton(
          onPressed: () {
           showTaskAddingDialog(context, null);
          },
          backgroundColor: testColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  final Task task;

  final Function(BuildContext)? onDelete;
  final Function(BuildContext) onEdit;
  final Function() onComplete;

  const TaskCard(
      {this.onDelete,
      required this.onEdit,
      required this.onComplete,
      required this.task,
      Key? key})
      : super(key: key);

  @override
  State<TaskCard> createState() => TaskCardState();
}

class TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: widget.onEdit,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: bridellaBGColor,
            foregroundColor: const Color.fromARGB(255, 150, 150, 150),
            label: "Details",
            icon: Icons.info_outline,
          ),
          SlidableAction(
            onPressed: widget.onDelete,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: bridellaBGColor,
            foregroundColor: kPrimaryColor,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(top: 2, bottom: 6, left: 8, right: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bridellaBGColor,
          border: Border.all(
              width: 0.6,
              color: widget.task.completed ? kPrimaryColor : Color.fromARGB(255, 239, 40, 200)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: InkWell(
              onTap: widget.onComplete,
           child: widget.task.completed
                   ? Icon(Icons.check_circle_outlined, color: testColor)
                  : const Icon(
                      Icons.circle_outlined,
                      color: Colors.white,
                    )), 
          title: Text(widget.task.title),
          subtitle: Text(widget.task.desc),
          trailing: const StackedAvatars(), 
        ), 
      ),
    );
  }
}
