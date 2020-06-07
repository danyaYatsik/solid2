import 'package:image/image.dart';
import 'package:solid/model/comparison_result.dart';

abstract class AppEvent {}

class SetImage1AppEvent extends AppEvent {
  final Image image;

  SetImage1AppEvent(this.image);
}

class SetImage2AppEvent extends AppEvent {
  final Image image;

  SetImage2AppEvent(this.image);
}

class CompareAppEvent extends AppEvent {}

class ErrorAppEvent extends AppEvent {
  final String message;

  ErrorAppEvent({this.message});
}

class PresentResultAppEvent extends AppEvent {
  final ComparisonResult result;

  PresentResultAppEvent(this.result);
}

class CloseComparisonAppStateEvent extends AppEvent {}
