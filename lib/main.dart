import 'package:firedemo/pages/login_page.dart';
import 'package:firedemo/providers/AuthenticationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationProvider>(
      create: (context) => AuthenticationProvider(),
      child: MaterialApp(
        home: SignupPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
