import 'package:comic_cabinet/models/issue_details.dart';
import 'package:comic_cabinet/resources/api.dart';
import 'package:comic_cabinet/utils/constants.dart';
import 'package:comic_cabinet/widgets/issue_section.dart';
import 'package:comic_cabinet/widgets/loader.dart';
import 'package:flutter/material.dart';

class IssueScreen extends StatefulWidget {
  final String apiDetailUrl;
  const IssueScreen({
    super.key,
    required this.apiDetailUrl,
  });

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  late Future<IssueDetails> issueDetails;
  final Key issueKey = const Key('issue key');
  @override
  void initState() {
    issueDetails = Api().getIssueDetails(widget.apiDetailUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 30,
        ),
        physics: const ScrollPhysics(),
        children: [
          const Text(
            'ComicBook',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          FutureBuilder(
            future: issueDetails,
            key: issueKey,
            builder: (context, AsyncSnapshot<IssueDetails> snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Loader(isLoading: !snapshot.hasData),
                  ],
                );
              }
              IssueDetails issue = snapshot.data!;
              bool onlyImage = issue.characterCredits == null &&
                  issue.locationCredits == null &&
                  issue.teamCredits == null &&
                  issue.conceptCredits == null;

              List<Widget> layout() {
                return [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                            image: NetworkImage(issue.image),
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
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                            ),
                            const Text(
                              'We have no data of this comic at this moment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            IssueSection(
                              label: 'Characters',
                              data: issue.characterCredits,
                            ),
                            IssueSection(
                              label: 'Teams',
                              data: issue.teamCredits,
                            ),
                            IssueSection(
                              label: 'Locations',
                              data: issue.locationCredits,
                            ),
                            IssueSection(
                              label: 'Concepts',
                              data: issue.conceptCredits,
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
                          children: layout().reversed.toList(),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: layout(),
                        ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
