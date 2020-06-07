import 'dart:typed_data';

import 'package:image/image.dart' as rawImg;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/app_bloc/app_bloc.dart';
import 'package:solid/bloc/app_bloc/app_state.dart';
import 'package:solid/util/properties.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(APP_NAME),
        ),
        body: Center(
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state is ProcessingAppState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Comparing...'),
                  ],
                );
              } else if (state is ResultAppState) {
                final bytes = rawImg.encodeJpg(state.result.image);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.memory(
                      Uint8List.fromList(bytes),
                      width: 120,
                      height: 250,
                    ),
                    Text('Match: ${state.result.percents} %'),
                    RaisedButton(
                      child: Text('Again'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              } else if (state is ErrorAppState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(state.message),
                    RaisedButton(
                      child: Text('Back'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/placeholder.png'),
                    Text('No result present'),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
