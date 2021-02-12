import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_application/features/models/voter.dart';
import 'package:voting_application/features/services/auth/auth.dart';
import 'package:voting_application/features/services/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

// class Home extends StatelessWidget {
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     _showSettingsPannel() {
//       showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//             padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
//             child: Text('Show moddal'),
//           );
//         },
//       );
//     }

//     return StreamProvider<List<Voter>>.value(
//       value: DatabaseService().voters,
//       child: Scaffold(
//         backgroundColor: Colors.brown[50],
//         appBar: AppBar(
//           title: Text(''),
//           backgroundColor: Colors.brown[400],
//           elevation: 0.0,
//           actions: [
//             FlatButton.icon(
//               icon: Icon(Icons.person),
//               label: Text('logout'),
//               onPressed: () async {
//                 await _auth.signOut();
//               },
//             ),
//             FlatButton.icon(
//               icon: Icon(Icons.settings),
//               label: Text('settings'),
//               onPressed: () => _showSettingsPannel(),
//             ),
//           ],
//         ),
//         body: Container(
//           decoration: BoxDecoration(color: Colors.grey),
//           child: Text('Love Galour'),
//         ),
//       ),
//     );
//   }
// }

class LaVote extends StatelessWidget {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    bool vot = true;
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(document['names'] ?? 'failed'),
              Container(
                color: Colors.pink,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  document['votes'].toString(),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        vot ? vote(document) : reset(document);
        // vote(document);
        // reset();
        // document.reference.update({'vote': document['vote'] + 1});
        // print('you taped on ${document['name']}');
      },
    );
  }

  reset(DocumentSnapshot document) {
    Firestore.instance.runTransaction(
      (transaction) async {
        DocumentSnapshot freshSnap = await transaction.get(document.reference);
        await transaction.update(
          freshSnap.reference,
          {'votes': freshSnap['votes'] - 1},
        );
      },
    );
  }

  vote(DocumentSnapshot document) async {
    try {
      Firestore.instance.runTransaction(
        (transaction) async {
          DocumentSnapshot freshSnap =
              await transaction.get(document.reference);
          await transaction.update(
            freshSnap.reference,
            {'votes': freshSnap['votes'] + 1},
          );
        },
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La vot'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('bandnames').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'loading',
                style: GoogleFonts.varelaRound(
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
            itemExtent: 80,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]),
          );
        },
      ),
    );
  }
}
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(App());
// }

// class App extends StatelessWidget {
//   // Create the initialization Future outside of `build`:
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return SomethingWentWrong();
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MyAwesomeApp();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Loading();
//       },
//     );
//   }
// }
