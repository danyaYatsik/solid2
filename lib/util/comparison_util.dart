import 'package:image/image.dart';
import 'package:solid/exception/comparison_exception.dart';
import 'package:solid/model/comparison_result.dart';

num _diffBetweenPixels(int firstPixel, int secondPixel) {
  var fRed = getRed(firstPixel);
  var fGreen = getGreen(firstPixel);
  var fBlue = getBlue(firstPixel);
  var fAlpha = getAlpha(firstPixel);
  var sRed = getRed(secondPixel);
  var sGreen = getGreen(secondPixel);
  var sBlue = getBlue(secondPixel);
  var sAlpha = getAlpha(secondPixel);

  num diff = (fRed - sRed).abs() +
      (fGreen - sGreen).abs() +
      (fBlue - sBlue).abs() +
      (fAlpha - sAlpha).abs();

  diff = (diff / 255) / 4;

  return diff;
}

Future<ComparisonResult> compare(
    Image firstImg, Image secondImg, {num fluff = 0.1}) async {

  if (!_haveSameSize(firstImg, secondImg)) {
    throw ComparisonException('Currently we need images of same width and height');
  }

  int width = firstImg.width;
  int height = firstImg.height;

  //Create an image to show the differences
  final diffImg = Image(width, height);
  int matchedPixels = 0;

  for (var i = 0; i < width; i++) {
    var diffAtPixel, firstPixel, secondPixel;
    for (var j = 0; j < height; j++) {
      firstPixel = firstImg.getPixel(i, j);
      secondPixel = secondImg.getPixel(i, j);

      diffAtPixel = _diffBetweenPixels(firstPixel, secondPixel);
      if (diffAtPixel < fluff) matchedPixels++;

      //Shows in red the different pixels and in semitransparent the same ones
      diffImg.setPixel(
          i, j, _selectColor(firstPixel, secondPixel, diffAtPixel, fluff));
    }
  }

  matchedPixels = (matchedPixels * 100 / height / width).floor();

  return ComparisonResult(diffImg, matchedPixels);
}

bool _haveSameSize(firstImg, secondImg) =>
    firstImg.width == secondImg.width && firstImg.height == secondImg.height;

int _selectColor(int firstPixel, int secondPixel, num diffAtPixel, num fluff) {
  var fRed = getRed(firstPixel);
  var fGreen = getGreen(firstPixel);
  var fBlue = getBlue(firstPixel);
  var sRed = getRed(secondPixel);
  var sGreen = getGreen(secondPixel);
  var sBlue = getBlue(secondPixel);

  if (diffAtPixel < fluff) return Color.fromRgba(fRed, fGreen, fBlue, 50);
  if (fRed == 0 && fGreen == 0 && fBlue == 0)
    return Color.fromRgba(sRed, sGreen, sBlue, 50);
  if (sRed == 0 && sGreen == 0 && sBlue == 0)
    return Color.fromRgba(fRed, fGreen, fBlue, 50);

  int alpha, red, green, blue;

  alpha = 255;
  red = 255;
  green = 0;
  blue = 0;

  return Color.fromRgba(red, green, blue, alpha);
}

