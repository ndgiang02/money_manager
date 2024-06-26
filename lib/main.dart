import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/main_cubit.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/repositories/api_impl.dart';
import 'package:money_manager/repositories/log.dart';
import 'package:money_manager/repositories/log_impl.dart';
import 'package:money_manager/routes.dart';
import 'package:money_manager/widgets/screen_widgets/login/login_screen.dart';

void main() {
  Log log = LogImpl();
  runApp(RepositoryProvider<Log>.value(
    value: log,
    child: Repository(),
  ));
}

class Repository extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Api>(
      create: (context) => ApiImpl(context.read<Log>()),
      child: Provider(),
    );
  }
}

class Provider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: mainRoute,
        initialRoute: LoginScreen.route,
        ),
    );
  }
}
