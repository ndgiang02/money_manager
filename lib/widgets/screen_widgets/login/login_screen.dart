import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/common_widgets/noti_bar.dart';

import '../../../common/load_status.dart';
import '../../../models/login.dart';
import '../../../repositories/api.dart';
import '../list_item/list_item_screen.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "LoginScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<Api>()),
      child: Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String _username = "";
  String _password = "";
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.Error) {
            ScaffoldMessenger.of(context).showSnackBar(notiBar("Login Error", true));
          } else if (state.loadStatus == LoadStatus.Done) {
            Navigator.of(context).pushNamed(ListItemScreen.route);
          }
        },
        builder: (context, state) {
          return state.loadStatus == LoadStatus.Loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.all(32),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.cyanAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                        onChanged: (value) => _username = value,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        autofocus: true,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.cyanAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                        onChanged: (value) => _password = value,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().checkLogin(
                              Login(username: _username, password: _password));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 50,
                          backgroundColor: Colors.blue,
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
