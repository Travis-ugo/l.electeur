import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/screens/home/home.dart';
import 'features/screens/wrapper.dart';
import 'features/services/auth/auth.dart';
import 'features/models/user_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'La vote',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: LaVote(),
      ),
    );
  }
}
