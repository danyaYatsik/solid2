import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/app_bloc/app_bloc.dart';
import 'package:solid/bloc/app_bloc/app_state.dart';
import 'package:solid/widget/image-container.dart';
import 'package:solid/util/properties.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: Center(
        child: BlocBuilder<AppBloc, AppState>(
          condition: (previous, current) => previous.result != current.result,
          builder: (context, state) => Column(
            children: <Widget>[
              ImageContainer(
                image: state.result.image,
                width: 120,
                height: 250,
              ),
              Text(state.result.description),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
