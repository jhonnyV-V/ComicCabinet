import 'package:comic_cabinet/widgets/section_element.dart';
import 'package:flutter/material.dart';

class IssueSection extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>>? data;
  const IssueSection({
    super.key,
    required this.label,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Divider(),
        for (var i = 0; i < data!.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SectionElement(
                  name: data?[i]['name'],
                  image: data?[i]['image'],
                ),
                const SizedBox(
                  width: 20,
                ),
                i + 1 < data!.length
                    ? SectionElement(
                        name: data?[i + 1]['name'],
                        image: data?[i + 1]['image'],
                      )
                    : const SizedBox(
                        width: 60,
                      ),
              ],
            ),
          )
      ],
    );
  }
}
