// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

/// A login page that takes a username and password.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _unfocusedColor = Colors.grey[600];

  /// Initializes listeners so that [setState] is called whenever
  /// [_usernameFocus] or [_passwordFocus] changes.
  ///
  /// This is required so that the [TextField] widgets are
  /// repainted using the [_unfocusedColor] if they lose focus.
  @override
  void initState() {
    super.initState();
    _usernameFocus.addListener(() {
      setState() {}
    });
    _passwordFocus.addListener(() {
      setState() {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text(
                  'SHRINE',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 120.0),
            // [name]
            TextField(
              controller: _usernameController,
              focusNode: _usernameFocus,
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(
                  color: _usernameFocus.hasFocus
                      ? Theme.of(context).colorScheme.secondary
                      : _unfocusedColor,
                ),
              ),
            ),
            // spacer
            SizedBox(height: 12.0),
            // [password]
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: _passwordFocus.hasFocus
                      ? Theme.of(context).colorScheme.secondary
                      : _unfocusedColor,
                ),
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: Text("CANCEL"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary,
                    ),
                    shape: MaterialStateProperty.all(
                      BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _passwordController.clear();
                    _usernameController.clear();
                  },
                ),
                ElevatedButton(
                  child: Text("NEXT"),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    shape: MaterialStateProperty.all(
                      BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),
                  ),
                  // pops the login page off the stack, which shows
                  // the home page.
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
