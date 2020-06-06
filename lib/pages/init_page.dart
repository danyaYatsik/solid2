import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/app_bloc/app_bloc.dart';
import 'package:solid/bloc/app_bloc/app_event.dart';
import 'package:solid/bloc/app_bloc/app_state.dart';
import 'package:solid/widget/image-container.dart';
import 'package:solid/util/properties.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AppBloc appBloc = context.bloc<AppBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<AppBloc, AppState>(
                    condition: (previous, current) =>
                        previous.image1 != current.image1,
                    builder: (context, state) {
                      return ImageContainer(
                        image: state.image1,
                        width: 120,
                        height: 250,
                        onPressed: () => appBloc.add(AppEvent.setImage1),
                      );
                    }),
                BlocBuilder<AppBloc, AppState>(
                    condition: (previous, current) =>
                        previous.image2 != current.image2,
                    builder: (context, state) {
                      return ImageContainer(
                        image: state.image2,
                        width: 120,
                        height: 250,
                        onPressed: () => appBloc.add(AppEvent.setImage2),
                      );
                    }),
              ],
            ),
            CircularProgressIndicator(),
            RaisedButton(
                child: Text('Compare'),
                onPressed: () {
                  Navigator.pushNamed(context, "/result");
                  appBloc.add(AppEvent.compare);
                }),
          ],
        ),
      ),
    );
  }
}
