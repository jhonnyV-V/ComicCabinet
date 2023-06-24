import 'package:comic_cabinet/models/issue.dart';
import 'package:comic_cabinet/resources/api.dart';
import 'package:comic_cabinet/widgets/grid_display.dart';
import 'package:flutter/material.dart';

class ComicList extends StatefulWidget {
  const ComicList({super.key});

  @override
  State<ComicList> createState() => _ComicListState();
}

class _ComicListState extends State<ComicList> {
  late Future<List<Issue>> issues;

  @override
  void initState() {
    issues = Api().getIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest Issues',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          GridDisplay(issues: issues),
        ],
      ),
    );
  }
}
