import 'package:comic_cabinet/models/issue_details.dart';
import 'package:comic_cabinet/resources/api.dart';
import 'package:comic_cabinet/utils/constants.dart';
import 'package:comic_cabinet/widgets/issue_section.dart';
import 'package:comic_cabinet/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
    issueDetails = Api(Dio()).getIssueDetails(widget.apiDetailUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isTablet = width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const Text(
          'ComicBook',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: isTablet ? 20 : 10,
          bottom: 30,
          right: isTablet ? 0 : 10,
        ),
        physics: const ScrollPhysics(),
        children: [
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
                      height: MediaQuery.of(context).size.height / 2.8,
                    ),
                    Loader(isLoading: !snapshot.hasData),
                  ],
                );
              }
              IssueDetails issue = snapshot.data!;
              bool onlyImage = (issue.characterCredits == null ||
                      issue.characterCredits!.isEmpty) &&
                  (issue.locationCredits == null ||
                      issue.locationCredits!.isEmpty) &&
                  (issue.teamCredits == null || issue.teamCredits!.isEmpty) &&
                  (issue.conceptCredits == null ||
                      issue.conceptCredits!.isEmpty);

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
                            width:
                                width > 600 && width < 880 ? width / 2.3 : null,
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
                      : isTablet
                          ? Expanded(
                              child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: layout().reversed.toList())
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
