import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitodo/models/checklist_model.dart';

class ChecklistService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<List<ChecklistModel>> fetchChecklistByDate(
      {required DateTime date}) async {
    // List<ChecklistModel> checklist = [];

    var qSnapShot = await users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("checklist")
        .where(Filter.and(
          Filter("date", isGreaterThanOrEqualTo: date),
          Filter("date", isLessThan: date.add(const Duration(days: 1))),
        ))
        .orderBy("date")
        .orderBy("dateTimeAdded", descending: false)
        .get();

    return qSnapShot.docs.map((doc) {
      Map<String, dynamic> response = doc.data();
      return ChecklistModel.fromJson(response);
    }).toList();

    // await users
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("checklist")
    //     .where(Filter.and(
    //       Filter("date", isGreaterThanOrEqualTo: date),
    //       Filter("date", isLessThan: date.add(const Duration(days: 1))),
    //     ))
    //     .get()
    //     .then((snapshot) {
    //   for (var element in snapshot.docs) {
    //     Map<String, dynamic> response = element.data();
    //     checklist.add(ChecklistModel.fromJson(response));
    //   }
    // });

    // return checklist;
  }

  Future<bool> markAsDone({required String id}) async {
    try {
      Map<String, dynamic> data = {
        "isDone": true,
      };

      await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("checklist")
          .doc(id)
          .update(data);

      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> addTask({required DateTime date, required String task}) async {
    try {
      String id = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('checklist')
          .doc()
          .id;

      var data = ChecklistModel(
              date: date,
              task: task,
              isDone: false,
              id: id,
              dateTimeAdded: DateTime.now())
          .toJson();

      await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('checklist')
          .doc(id)
          .set(data);

      return true;
    } catch (ex) {
      return false;
    }
  }
}
