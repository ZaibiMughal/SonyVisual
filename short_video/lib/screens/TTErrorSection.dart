import 'package:flutter/material.dart';

import '../models/screen_error.dart';


// ignore: must_be_immutable
class ErrorSection extends StatefulWidget {
  late ScreenError screenError;

  ErrorSection({super.key, required this.screenError});

  @override
  State<ErrorSection> createState() => _ErrorSectionState();
}

class _ErrorSectionState extends State<ErrorSection> {
  Widget bodyData() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.screenError.icon,
            const SizedBox(
              height: 10.0,
            ),
            Text(widget.screenError.message, style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white
            ),)
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: bodyData(),
    );
  }
}
