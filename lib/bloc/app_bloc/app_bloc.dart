import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solid/bloc/app_bloc/app_state.dart';
import 'package:solid/model/comparison_result.dart';
import 'package:solid/util/comparison_helper.dart';

import 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _picker = ImagePicker();

  @override
  AppState get initialState {
    print('initialState');
    return AppState(
      image1: _loadPlaceholder(),
      image2: _loadPlaceholder(),
      result: ComparisonResult(
        _loadPlaceholder(),
        'No result',
      ),
    );
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    print(event);
    switch (event) {
      case AppEvent.setImage1:
        yield AppState(
            image1: _pickImage(), image2: state.image2, result: state.result);
        break;
      case AppEvent.setImage2:
        yield AppState(
            image1: state.image1, image2: _pickImage(), result: state.result);
        break;
      case AppEvent.compare:
        final result = await _compare();
        yield AppState(
            image1: state.image1, image2: state.image2, result: result);
        break;
      default:
        throw Exception();
    }
  }

  Future<Image> _loadPlaceholder() async {
    final byteData = await rootBundle.load('assets/placeholder.png');
    return _decodeImageInBackground(byteData.buffer.asUint8List().toList());
  }

  Future<ComparisonResult> _compare() async {
    final image1 = await state.image1;
    final image2 = await state.image2;
    return _compareInBackground(image1, image2);
  }

  Future<Image> _pickImage() async {
    print('before getImage()');
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    print('before readAsBytes()');
    final bytes = await pickedFile.readAsBytes();
    print('after readAsBytes()');
    return _decodeImageInBackground(bytes.toList());
  }
}

Future<ComparisonResult> funToPassInCommute(List<Image> images) async {
  return compare(images[0], images[1]);
}

Future<ComparisonResult> _compareInBackground(Image image1, Image image2){
  return compute(funToPassInCommute, [image1, image2]);
}

Future<Image> _decodeImageInBackground(List<int> bytes) async {
  return compute(decodeImage, bytes);
}
