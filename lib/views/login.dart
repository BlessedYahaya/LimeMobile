import 'package:flutter/material.dart';
import 'package:lime/components/busy.dart';
import 'package:lime/models/store.dart';
import 'package:lime/utils.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> loginMap = new Map();
  @override
  Widget build(BuildContext context) {
    StoreModel store = Provider.of<StoreModel>(context);
    return BusyWidget(
      busy: store.isProcessing,
      msg: "Please wait...",
      child: Scaffold(
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 36.0),
                        child: Text('WELCOME BACK',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Username",
                            hintText: 'Abc',
                            fillColor: Colors.grey[200]),
                        validator: (value) {
                          return validateRequired(value, 'Username');
                        },
                        onSaved: (value) {
                          loginMap['username'] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: '******',
                            fillColor: Colors.grey[200]),
                        validator: validatePassword,
                        onSaved: (value) {
                          loginMap['password'] = value;
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                store.login(context, loginMap);
                              }
                            },
                            child: Text('LOGIN',
                                style: TextStyle(color: Colors.white))))
                  ]),
            ),
          ),
        )),
      ),
    );
  }
}
