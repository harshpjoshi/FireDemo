import 'package:firedemo/providers/AuthenticationProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Builder(
        builder: (context) {
          return Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  autofocus: false,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  autofocus: false,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    signup(emailController.value.text,
                        passController.value.text, context);
                  },
                  child: Text("Signup"),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<AuthenticationProvider>(builder: (_, notifier, __) {
                  if (notifier.isLoading()) {
                    return CircularProgressIndicator();
                  } else {
                    return notifier.fuser == null
                        ? Container()
                        : notifier.fuser.fold(
                            (failure) => failure == null
                                ? Container()
                                : Text(failure.toString()), (post) {
                            if (post == null) {
                              return Container();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "User Created",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1,
                                  textColor: Colors.black38,
                                  fontSize: 16.0);

                              return Container();
                            }
                          });
                  }
                })
              ],
            ),
          );
        },
      ),
    );
  }

  void signup(String text, String text2, BuildContext context) {
    if (emailController.text == '') {
      final snackBar = SnackBar(content: Text('Please Enter your Email'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else if (passController.text == '') {
      final snackBar = SnackBar(content: Text('Please Enter your username'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      Provider.of<AuthenticationProvider>(context).signUp(text, text2);
    }
  }
}
