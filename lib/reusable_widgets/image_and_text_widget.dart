import 'package:flutter/material.dart';

class ImageAndTextWidget extends StatelessWidget {
  final String textToDisplay;
  final String imagePath;
  const ImageAndTextWidget(
      {Key? key, required this.textToDisplay, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(imagePath,
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.22),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          textToDisplay,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0175,
              color: Theme.of(context).disabledColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
