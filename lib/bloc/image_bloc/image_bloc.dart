import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/image_bloc/image_event.dart';
import 'package:solid/bloc/image_bloc/image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  @override
  ImageState get initialState => EmptyImageState();

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    switch (event.runtimeType) {
      case UploadImageEvent:
        break;
      default:
        throw Exception('Unknown state');
    }
  }
}
