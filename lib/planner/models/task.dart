// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

import 'package:bridella/wishes/models/wish.dart';

class Task {
  final String taskId;
  String title;
  List<String> sharedWith;
  String desc;
  final String taskOwner;
  String status;
  DateTime? startDate;
  DateTime? deadLine;
  List<Comment> comments;
  bool completed;

  Task(
      {required this.taskId,
      required this.title,
      required this.sharedWith,
      required this.desc,
      required this.taskOwner,
      required this.status,
      required this.startDate,
      required this.deadLine,
      required this.comments,
      required this.completed});

  @override
  String toString() => title;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'sharedWith': sharedWith.isNotEmpty
          ? {
              for (var element in sharedWith)
                element.indexOf(element).toString(): element
            }
          : {},
      'desc': desc,
      'status': status,
      'comments': comments.isNotEmpty
          ? {
              for (var comment in comments)
                comments.indexOf(comment).toString(): comment.toMap()
            }
          : {},
      'completed': completed,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate!),
      'deadLine': DateFormat('yyyy-MM-dd').format(deadLine!),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> sharedWithMap =
        map['sharedWith'] as Map<String, dynamic>;
    Map<String, String> stringMap = sharedWithMap.cast();
    Map<String, dynamic> commentsMap = map['comments'] as Map<String, dynamic>;
    return Task(
        taskId: map['taskId'],
        title: map['title'] as String,
        sharedWith: stringMap.isNotEmpty ? stringMap.values.toList() : [],
        desc: map['desc'] as String,
        taskOwner: map['taskOwner'] as String,
        status: map['status'] as String,
        startDate: DateFormat('yyyy-MM-dd').parseUtc(map['startDate']),
        deadLine: DateFormat('yyyy-MM-dd').parseUtc(map['deadLine']),
        comments: commentsMap.isNotEmpty
            ? commentsMap.values
                .map((comment) => Comment.fromMap(comment))
                .toList()
            : [],
        completed: map['completed'] as bool);
  }

  Task copyWith({
    String? taskId,
    String? title,
    List<String>? sharedWith,
    String? desc,
    String? taskOwner,
    String? status,
    DateTime? startDate,
    DateTime? deadLine,
    List<Comment>? comments,
    bool? completed,
  }) {
    return Task(
        taskId: this.taskId,
        title: this.title,
        sharedWith: this.sharedWith,
        desc: this.desc,
        taskOwner: this.taskOwner,
        status: this.status,
        startDate: this.startDate,
        deadLine: this.deadLine,
        comments: this.comments,
        completed: this.completed);
  }
}

/*
/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Task>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kTaskSource);

final _kTaskSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1,
        (index) => Task(
            title: 'Event $item | ${index + 1}',
            sharedWith: {},
            desc: '',
            taskOwner: '',
            status: '',
            time: DateTime.utc(2022, 12, 13)))
}..addAll({
    kToday: [
      /* const Task('Today\'s Event 1'),
      const Task('Today\'s Event 2'),*/
    ],
  });
*/
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime.utc(2022, 10, 16);
final kLastDay = DateTime.utc(2099, 10, 16);
