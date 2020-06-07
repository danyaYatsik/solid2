import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as rawImg;
import 'package:solid/bloc/image_bloc/image_bloc.dart';
import 'package:solid/bloc/image_bloc/image_event.dart';
import 'package:solid/bloc/image_bloc/image_state.dart';

class ImageContainer extends StatelessWidget {
  final void Function(rawImg.Image image) onImagePresent;
  final double width;
  final double height;

  ImageContainer({key, this.onImagePresent, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final imageBloc = context.bloc<ImageBloc>();
    return Container(
      height: height,
      width: width,
      child: FlatButton(
        child: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is EmptyImageState) {
              return Image.asset('assets/placeholder.png');
            } else if (state is LoadingImageState) {
              return CircularProgressIndicator();
            } else if (state is PresentImageState) {
              return state.image;
            } else {
              return Text('Unknown state, try to reload application');
            }
          },
        ),
        onPressed: () {
          imageBloc.add(LoadImageEvent(onImagePresent));
        },
      ),
    );
  }
}
