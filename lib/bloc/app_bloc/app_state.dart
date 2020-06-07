import 'package:image/image.dart';
import 'package:solid/model/comparison_result.dart';

abstract class AppState {}

class InitialAppState extends AppState {}

class PreparationAppState extends AppState {
  final Image image;

  PreparationAppState(this.image);
}

class ReadyAppState extends AppState {
  final Image image1;
  final Image image2;

  ReadyAppState(this.image1, this.image2);
}

class ProcessingAppState extends AppState {
  final Image image1;
  final Image image2;

  ProcessingAppState(this.image1, this.image2);
}

class ResultAppState extends AppState {
  final Image image1;
  final Image image2;
  final ComparisonResult result;

  ResultAppState(this.image1, this.image2, this.result);
}

class ErrorAppState extends AppState {
  final String message;

  ErrorAppState({this.message});
}
