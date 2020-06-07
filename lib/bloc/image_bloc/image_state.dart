import 'package:flutter/material.dart';

abstract class ImageState {}

class EmptyImageState extends ImageState{}

class LoadingImageState extends ImageState {}

class PresentImageState extends ImageState {
  final Image image;

  PresentImageState(this.image);
}
