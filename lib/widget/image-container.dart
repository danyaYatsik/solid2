import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as rawImg;

class ImageContainer extends StatelessWidget {
  final Future<rawImg.Image> image;
  final VoidCallback onPressed;
  final double width;
  final double height;

  ImageContainer(
      {@required this.image, this.onPressed, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: FutureBuilder<Image>(
        future: rawImageToImageWidget(image),
        builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
          print('imageContainer $hashCode');
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      onPressed: () => onPressed(),
    );
  }

  Future<Image> rawImageToImageWidget(Future<rawImg.Image> imageSrc) async {
    print('rawImageToImageWidget');
    final image = await imageSrc;
    return Image.memory(
      Uint8List.fromList(rawImg.encodeJpg(image)),
      width: width,
      height: height,
    );
  }
}
