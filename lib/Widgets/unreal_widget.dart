import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnrealWidget extends StatelessWidget {
  const UnrealWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 'unreal_texture_view',
      layoutDirection: TextDirection.ltr,
    );
  }
}
