import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/app_bloc/app_state.dart';
import 'package:solid/model/comparison_result.dart';
import 'package:solid/util/comparison_util.dart';

import 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    switch (event.runtimeType) {
      case SetImage1AppEvent:
        yield _handleSetImage1AppEvent(event);
        break;
      case SetImage2AppEvent:
        yield _handleSetImage2AppEvent(event);
        break;
      case CompareAppEvent:
        yield _handleCompareAppEvent(event);
        break;
      case ErrorAppEvent:
        final mEvent = event as ErrorAppEvent;
        yield ErrorAppState(message: mEvent.message);
        break;
      case PresentResultAppEvent:
        final mState = state as ProcessingAppState;
        final result = (event as PresentResultAppEvent).result;
        yield ResultAppState(mState.image1, mState.image2, result);
        break;
      default:
        yield ErrorAppState(
            message: 'Unknown event, try to restart application');
    }
  }

  AppState _handleSetImage1AppEvent(SetImage1AppEvent event) {
    switch (state.runtimeType) {
      case InitialAppState:
        return PreparationAppState(event.image);
      case PreparationAppState:
        final image2 = (state as PreparationAppState).image;
        return ReadyAppState(event.image, image2);
      case ReadyAppState:
        final image2 = (state as ReadyAppState).image2;
        return ReadyAppState(event.image, image2);
      case ResultAppState:
        final image2 = (state as ResultAppState).image2;
        return ReadyAppState(event.image, image2);
      case ErrorAppState:
        return PreparationAppState(event.image);
      default:
        return state;
    }
  }

  AppState _handleSetImage2AppEvent(SetImage2AppEvent event) {
    switch (state.runtimeType) {
      case InitialAppState:
        return PreparationAppState(event.image);
      case PreparationAppState:
        final image1 = (state as PreparationAppState).image;
        return ReadyAppState(image1, event.image);
      case ReadyAppState:
        final image1 = (state as ReadyAppState).image1;
        return ReadyAppState(image1, event.image);
      case ResultAppState:
        final image1 = (state as ResultAppState).image1;
        return ReadyAppState(image1, event.image);
      case ErrorAppState:
        return PreparationAppState(event.image);
      default:
        return state;
    }
  }

  AppState _handleCompareAppEvent(CompareAppEvent event) {
    switch (state.runtimeType) {
      case ReadyAppState:
        final mState = state as ReadyAppState;
        final result = compute(_compareInBackground, [mState.image1, mState.image2]);
        result.then((result) {
          add(PresentResultAppEvent(result));
        }).catchError((error) {
          add(ErrorAppEvent(message: error.toString()));
        });
        return ProcessingAppState(mState.image1, mState.image2);
      default:
        return ErrorAppState(message: 'Unknown state, try again');
    }
  }

}

Future<ComparisonResult> _compareInBackground(List<Image> images) async {
  return compare(images[0], images[1]);
}
