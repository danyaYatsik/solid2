import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/app_bloc/app_bloc.dart';
import 'package:solid/bloc/app_bloc/app_event.dart';
import 'package:solid/bloc/app_bloc/app_state.dart';
import 'package:solid/bloc/image_bloc/image_bloc.dart';
import 'package:solid/bloc/image_bloc/image_event.dart';
import 'package:solid/widget/image-container.dart';
import 'package:solid/util/properties.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AppBloc appBloc = context.bloc<AppBloc>();

    _createImageBloc(_) {
      final bloc = ImageBloc();
      appBloc.listen((state) {
        if (state is ErrorAppState || state is InitialAppState)
          bloc.add(EmptyImageEvent());
      });
      return bloc;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(APP_NAME),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocProvider<ImageBloc>(
                  create: _createImageBloc,
                  child: ImageContainer(
                    width: 120,
                    height: 250,
                    onImagePresent: (image) =>
                        appBloc.add(SetImage1AppEvent(image)),
                  ),
                ),
                BlocProvider<ImageBloc>(
                  create: _createImageBloc,
                  child: ImageContainer(
                    width: 120,
                    height: 250,
                    onImagePresent: (image) =>
                        appBloc.add(SetImage2AppEvent(image)),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text('See result'),
              onPressed: () {
                Navigator.pushNamed(context, "/result");
                if (appBloc.state is ReadyAppState) {
                  appBloc.add(CompareAppEvent());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
