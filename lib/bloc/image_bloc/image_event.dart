import 'package:flutter/material.dart';
import 'package:image/image.dart' as rawImg;

abstract class ImageEvent {}

class EmptyImageEvent extends ImageEvent {}

class LoadImageEvent extends ImageEvent {
  final void Function(rawImg.Image) onLoaded;

  LoadImageEvent(this.onLoaded);
}

class DecodeImageEvent extends ImageEvent {
  final rawImg.Image image;

  DecodeImageEvent(this.image);
}

class PresentImageEvent extends ImageEvent {
  final Image image;

  PresentImageEvent(this.image);
}

