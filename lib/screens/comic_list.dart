import 'package:comic_cabinet/models/issue.dart';
import 'package:comic_cabinet/resources/api.dart';
import 'package:comic_cabinet/screens/issue_screen.dart';
import 'package:comic_cabinet/widgets/grid_display.dart';
import 'package:comic_cabinet/widgets/list_display.dart';
import 'package:comic_cabinet/widgets/tab_icon.dart';
import 'package:flutter/material.dart';

class ComicList extends StatefulWidget {
  const ComicList({super.key});

  @override
  State<ComicList> createState() => _ComicListState();
}

class _ComicListState extends State<ComicList> {
  late Future<List<Issue>> issues;
  int viewIndex = 1;

  @override
  void initState() {
    issues = Api().getIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void redirectToIssue(BuildContext context, String detailsUrl) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IssueScreen(apiDetailUrl: detailsUrl),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        shrinkWrap: true,
        children: [
          const Text(
            'ComicBook',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Latest Issues',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  TabIcon(
                    label: 'List',
                    isActive: viewIndex == 0,
                    iconData: Icons.table_rows,
                    callback: () {
                      setState(() {
                        viewIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TabIcon(
                    label: 'Grid',
                    isActive: viewIndex == 1,
                    iconData: Icons.apps,
                    callback: () {
                      setState(() {
                        viewIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          viewIndex == 1
              ? GridDisplay(
                  issues: issues,
                  redirect: redirectToIssue,
                )
              : ListDisplay(
                  issues: issues,
                  redirect: redirectToIssue,
                ),
        ],
      ),
    );
  }
}
