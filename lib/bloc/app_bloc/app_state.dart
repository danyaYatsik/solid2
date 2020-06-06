import 'package:image/image.dart';
import 'package:solid/model/comparison_result.dart';

class AppState {
  final Future<Image> image1;
  final Future<Image> image2;
  final ComparisonResult result;

  AppState({this.image1, this.image2, this.result});
}
