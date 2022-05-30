import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  Fab({Key? key, required this.onPressed}) : super(key: key);

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
      ),
      elevation: 5,
    );
  }
}
