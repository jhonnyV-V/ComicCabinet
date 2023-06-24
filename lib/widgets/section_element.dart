import 'package:comic_cabinet/utils/constants.dart';
import 'package:flutter/material.dart';

class SectionElement extends StatelessWidget {
  final String name;
  final String image;
  const SectionElement({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(
          image,
          height: 42,
          width: 42,
        ),
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: const TextStyle(
              color: green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
