import 'package:comic_cabinet/models/issue.dart';
import 'package:comic_cabinet/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListDisplay extends StatelessWidget {
  final Future<List<Issue>> issues;
  const ListDisplay({
    super.key,
    required this.issues,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat formater = DateFormat.yMMMMd('en_US');
    const Key listKey = Key('list key');

    return FutureBuilder(
      future: issues,
      key: listKey,
      builder: (context, AsyncSnapshot<List<Issue>> snapshot) {
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

        return ListView.separated(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          physics: const ScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const Column(
              children: [
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
              ],
            );
          },
          itemBuilder: (context, int index) {
            Issue issue = snapshot.data![index];
            String date = formater.format(
              DateTime.parse(
                issue.dateAdded,
              ),
            );
            return Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: NetworkImage(issue.image),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          issue.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
