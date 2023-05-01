import 'package:bridella/planner/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_core/services/show_snackbar.dart';

class TaskDataBase {
  // firestore references
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('planner');

  Stream<List<Task>>? tasksFromFirestore(String uid) {
    try {
      return _tasks
          .where('taskOwner', isEqualTo: uid)
          .snapshots()
          .map((tasks) => tasks.docs.map((doc) {
                Map<String, dynamic> task = doc.data() as Map<String, dynamic>;

                return Task.fromMap(task);
              }).toList());
    } on FirebaseException catch (e) {
      print(e.message);
      return null;
    }
  }

  // Create a Task that have the same creator ID
  Future createTask(Map<String, dynamic> taskData) async {
    final String docId = _tasks.doc().id;
    taskData['taskId'] = docId;

    await _tasks.doc(taskData['taskId']).set(taskData);
  }

  Future updateTask(String taskId, Map<String, dynamic> taskData) async {
    try {
      _tasks.doc(taskId).set(taskData, SetOptions(merge: true));
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future deleteTask(String taskId) async {
    await _tasks
        .doc(taskId)
        .delete()
        .then((value) => message('task deleted'))
        .catchError(
            (error) => message('Somthing went wrong! Please try later'));
  }
}
