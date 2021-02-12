// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:voting_application/features/models/voter.dart';
// import 'package:voting_application/features/models/user_model.dart';

// class DatabaseService {
//   final String uid;
//   DatabaseService({this.uid});

//   // collection references
//   final CollectionReference registeredVoters =
//       Firestore.instance.collection('voters');

//   Future updateUserData(int level, String name) async {
//     return await registeredVoters.document(uid).setData({
//       'name': name,
//       'level': level,
//     });
//   }

//   // brew list from streams
//   List<Voter> _voteListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.documents.map((doc) {
//       return Voter(
//         name: doc.data['name'] ?? '',
//         level: doc.data['level'] ?? 0,
//       );
//     }).toList();
//   }

//   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//     return UserData(
//       uid: uid,
//       name: snapshot.data['name'],
//     );
//   }

//   // get brews stream
//   Stream<List<Voter>> get voters {
//     return registeredVoters.snapshots().map(_voteListFromSnapshot);
//   }

//   Stream<UserData> get userData {
//     return registeredVoters
//         .document(uid)
//         .snapshots()
//         .map(_userDataFromSnapshot);
//   }
// }
