import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  
  const AdaptiveTextButton(this.text, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: callback,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: callback,
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
