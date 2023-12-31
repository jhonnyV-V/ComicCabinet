import 'package:comic_cabinet/models/issue_details.dart';
import 'package:comic_cabinet/resources/api.dart';
import 'package:comic_cabinet/utils/constants.dart';
import 'package:comic_cabinet/utils/display_error_dialog.dart';
import 'package:comic_cabinet/widgets/issue_display.dart';
import 'package:comic_cabinet/widgets/loader.dart';
import 'package:dio/dio.dart';
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
  late Future<IssueDetails> _issueDetails;

  @override
  void initState() {
    super.initState();
    _issueDetails = Api(Dio()).getIssueDetails(widget.apiDetailUrl);
    _issueDetails.catchError((error) {
      return IssueDetails(image: '');
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _issueDetails,
        builder: (context, AsyncSnapshot<IssueDetails> snapshot) {
          if (snapshot.hasError) {
            String message = snapshot.error.toString();
            if (message.contains('Failed host lookup')) {
              message = errorToMessage['internetError'];
            }

            return ShowErrorDialog().render(message);
          }
          if (!snapshot.hasData) {
            return Center(
              child: LoaderDisplay().render(!snapshot.hasData),
            );
          }

          double width = MediaQuery.of(context).size.width;
          bool isTablet = width > 600;

          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.only(
                  left: isTablet ? 20 : 10,
                  bottom: 30,
                  right: isTablet ? 0 : 10,
                ),
                child: IssueDisplayView().render(
                  snapshot.data!,
                  constraints.maxWidth,
                  isTablet,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
