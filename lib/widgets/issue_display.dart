import 'package:comic_cabinet/models/issue_details.dart';
import 'package:comic_cabinet/widgets/issue_section.dart';
import 'package:flutter/material.dart';

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

class IssueDisplay extends StatelessWidget {
  final IssueDetails issue;
  final double width;
  final bool isTablet;
  const IssueDisplay({
    super.key,
    required this.issue,
    required this.width,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    bool onlyImage =
        (issue.characterCredits == null || issue.characterCredits!.isEmpty) &&
            (issue.locationCredits == null || issue.locationCredits!.isEmpty) &&
            (issue.teamCredits == null || issue.teamCredits!.isEmpty) &&
            (issue.conceptCredits == null || issue.conceptCredits!.isEmpty);

    List<Widget> layout() {
      return [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  width: width > 600 && width < 880 ? width / 2.3 : null,
                  image: issue.image,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: isTablet ? 0 : 10,
          width: isTablet ? 5 : 0,
        ),
        onlyImage
            ? isTablet
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        const Center(
                          child: Text(
                            'We have no data of this comic at this moment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      const Center(
                        child: Text(
                          'We have no data of this comic at this moment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )
            : isTablet
                ? Expanded(
                    child: Column(
                      children: [
                        IssueSectionView().render(
                          'Characters',
                          issue.characterCredits,
                        ),
                        IssueSectionView().render(
                          'Teams',
                          issue.teamCredits,
                        ),
                        IssueSectionView().render(
                          'Locations',
                          issue.locationCredits,
                        ),
                        IssueSectionView().render(
                          'Concepts',
                          issue.conceptCredits,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      IssueSectionView().render(
                        'Characters',
                        issue.characterCredits,
                      ),
                      IssueSectionView().render(
                        'Teams',
                        issue.teamCredits,
                      ),
                      IssueSectionView().render(
                        'Locations',
                        issue.locationCredits,
                      ),
                      IssueSectionView().render(
                        'Concepts',
                        issue.conceptCredits,
                      ),
                    ],
                  ),
      ];
    }

    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        isTablet
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: layout().reversed.toList())
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: layout(),
              ),
      ],
    );
  }
}
