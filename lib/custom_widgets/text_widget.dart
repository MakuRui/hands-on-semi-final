import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String textTitle;
  final String textDetails;
  const TextWidget({Key? key,
    required this.textTitle,
    required this.textDetails
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 120,
            child: Text(textTitle),
          ),
          const VerticalDivider(width: 50,),
          SizedBox(
            height: 50,
            width: 120,
            child: Text(textDetails),
          ),
        ],
      ),
    );
  }
}
