import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveElevatedButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback callback;
  
  const AdaptiveElevatedButton({required this.text, required this.callback, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            onPressed: callback,
            child: Text(
              text,
              style: style,
            ),
          )
        : ElevatedButton(
            onPressed: callback,
            child: Text(
              text,
              style: style,
            ),
          );
  }
}
