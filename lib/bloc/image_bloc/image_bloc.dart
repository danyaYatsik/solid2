import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as rawImg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solid/bloc/image_bloc/image_event.dart';
import 'package:solid/bloc/image_bloc/image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final _picker = ImagePicker();

  @override
  ImageState get initialState => EmptyImageState();

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    switch (event.runtimeType) {
      case LoadImageEvent:
        final state = await _handleLoadImageEvent(event);
        yield state;
        break;
      case DecodeImageEvent:
        yield _handleDecodeImageEvent(event);
        break;
      case PresentImageEvent:
        final image = (event as PresentImageEvent).image;
        yield PresentImageState(image);
        break;
      case EmptyImageEvent:
        yield EmptyImageState();
        break;
      default:
        throw Exception('Unknown event');
    }
  }

  ImageState _handleDecodeImageEvent(DecodeImageEvent event) {
    compute(rawImg.encodeJpg, event.image).then((bytes) => add(PresentImageEvent(Image.memory(bytes))));
    return LoadingImageState();
  }

  Future<ImageState>_handleLoadImageEvent(LoadImageEvent event) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      compute(rawImg.decodeImage, bytes).then((image) {
        event.onLoaded(image);
        add(DecodeImageEvent(image));
      });
      return LoadingImageState();
    } else {
      return state;
    }
  }
}
