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
        FadeInImage.assetNetwork(
          placeholder: 'assets/loading.gif',
          image: image,
          fit: BoxFit.cover,
          height: 42,
          width: 42,
        ),
        const SizedBox(
          width: 5,
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

abstract class ISectionElementView {
  Widget render(
    String name,
    String image,
  );
}

class SectionElementView implements ISectionElementView {
  @override
  Widget render(
    String name,
    String image,
  ) {
    return SectionElement(
      name: name,
      image: image,
    );
  }
}
