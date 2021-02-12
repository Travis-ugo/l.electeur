import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_application/features/models/user_model.dart';

import 'authentication/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return LaVote();
    }
  }
}
