import 'dart:typed_data';
import 'dart:ui';

typedef UiImage = Image;

Future<Codec> getCodec(
  Uint8List list, {
  int? targetWidth,
  int? targetHeight,
  bool allowUpscaling = true,
}) =>
    instantiateImageCodec(
      list,
      targetWidth: targetWidth,
      targetHeight: targetHeight,
      allowUpscaling: allowUpscaling,
    );
