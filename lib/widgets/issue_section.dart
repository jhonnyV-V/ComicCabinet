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
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: width > 1040 ? (width * 5) / 100 : 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: width > 1040 ? (width * 5) / 100 : 0,
          ),
          child: const Divider(),
        ),
        for (var i = 0; i < data!.length; i += 2)
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 20,
                  left: i + 1 < data!.length && width > 350
                      ? 0
                      : (0.1667 * constraints.maxWidth) - 52.29,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: i + 1 < data!.length
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.start,
                  children: [
                    SectionElementView().render(
                      data?[i]['name'],
                      data?[i]['image'],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    i + 1 < data!.length
                        ? SectionElementView().render(
                            data?[i + 1]['name'],
                            data?[i + 1]['image'],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          )
      ],
    );
  }
}

abstract class IIssueSectionView {
  Widget render(
    String label,
    List<Map<String, dynamic>>? data,
  );
}

class IssueSectionView implements IIssueSectionView {
  @override
  Widget render(
    String label,
    List<Map<String, dynamic>>? data,
  ) {
    return IssueSection(
      label: label,
      data: data,
    );
  }
}
