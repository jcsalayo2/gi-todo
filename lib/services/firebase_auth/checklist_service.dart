import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitodo/models/checklist_model.dart';

class ChecklistService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<List<ChecklistModel>> fetchChecklistByDate(
      {required DateTime date}) async {
    List<ChecklistModel> checklist = [];

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("checklist")
        .where(Filter.and(
          Filter("date", isGreaterThanOrEqualTo: date),
          Filter("date", isLessThan: date.add(const Duration(days: 1))),
        ))
        .get()
        .then((snapshot) {
      for (var element in snapshot.docs) {
        Map<String, dynamic> response = element.data();
        checklist.add(ChecklistModel.fromJson(response));
      }
    });

    return checklist;
  }
}
