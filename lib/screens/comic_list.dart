import 'package:comic_cabinet/models/issue.dart';
import 'package:comic_cabinet/resources/api.dart';
import 'package:comic_cabinet/utils/constants.dart';
import 'package:comic_cabinet/widgets/grid_display.dart';
import 'package:comic_cabinet/widgets/list_display.dart';
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
    Widget tabIcon(
      String label,
      bool isActive,
      IconData iconData,
      VoidCallback callback,
    ) {
      return InkWell(
        onTap: callback,
        child: Row(
          children: [
            Icon(
              iconData,
              color: isActive ? Colors.black : green,
            ),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.black : green,
              ),
            ),
          ],
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
                  tabIcon(
                    'List',
                    viewIndex == 0,
                    Icons.table_rows,
                    () {
                      setState(() {
                        viewIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  tabIcon(
                    'Grid',
                    viewIndex == 1,
                    Icons.apps,
                    () {
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
              ? GridDisplay(issues: issues)
              : ListDisplay(issues: issues),
        ],
      ),
    );
  }
}
