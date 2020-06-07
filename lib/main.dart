import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/app_bloc/app_bloc.dart';
import 'package:solid/router.dart';
import 'package:solid/util/properties.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc(),
      child: MaterialApp(
        title: APP_NAME,
        initialRoute: '/',
        onGenerateRoute: Router.onGenerateRoute,
      ),
    );
  }
}
