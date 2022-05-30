import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<DocumentSnapshot> getData() {
  return FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .snapshots();
}

Stream<QuerySnapshot> getPlans(
    {String collection1, String doc1, String collection2}) {
  return FirebaseFirestore.instance
      .collection(collection1)
      .doc(doc1)
      .collection(collection2)
      .snapshots();
}

Stream<QuerySnapshot> getPlanSections(
    {String collection1, String doc1, String collection2, String id}) {
  var getData = FirebaseFirestore.instance
      .collection(collection1)
      .doc(doc1)
      .collection(collection2)
      .doc(id)
      .collection("section")
      .snapshots();
  return getData;
}

Stream<QuerySnapshot> getPrograms() {
  return FirebaseFirestore.instance.collection("programs").snapshots();
}

Stream<QuerySnapshot> getProgramBeginner(String id) {
  return FirebaseFirestore.instance
      .collection("programs")
      .doc(id)
      .collection("beginner")
      .snapshots();
}

Stream<QuerySnapshot> getProgramSkills(String id) {
  return FirebaseFirestore.instance
      .collection("programs")
      .doc(id)
      .collection("skills")
      .snapshots();
}

Stream<QuerySnapshot> getProgramMaster(String id) {
  return FirebaseFirestore.instance
      .collection("programs")
      .doc(id)
      .collection("master")
      .snapshots();
}

Stream<QuerySnapshot> getMyDiet({String collection1}) {
  return FirebaseFirestore.instance.collection(collection1).snapshots();
}
