import 'package:comic_cabinet/models/issue.dart';
import 'package:comic_cabinet/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GridDisplay extends StatelessWidget {
  final Future<List<Issue>> issues;
  const GridDisplay({
    super.key,
    required this.issues,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat formater = DateFormat.yMMMMd('en_US');
    const Key gridKey = Key('grid key');
    return FutureBuilder(
      future: issues,
      key: gridKey,
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

        // return GridView.count(
        //   crossAxisCount: 2,
        //   shrinkWrap: true,
        //   crossAxisSpacing: 20,
        //   mainAxisSpacing: 200,
        //   physics: const ScrollPhysics(),
        //   children: List.generate(snapshot.data!.length, (index) {
        //     Issue issue = snapshot.data![index];
        //     String date = formater.format(
        //       DateTime.parse(
        //         issue.dateAdded,
        //       ),
        //     );
        //     return Column(
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Image.network(
        //           issue.image,
        //           fit: BoxFit.cover,
        //         ),
        //         Text(issue.name),
        //         Text(date),
        //       ],
        //     );
        //   }),
        // );

        return GridView.builder(
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 256,
          ),
          itemBuilder: (context, int index) {
            Issue issue = snapshot.data![index];
            String date = formater.format(
              DateTime.parse(
                issue.dateAdded,
              ),
            );
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Image(
                    image: NetworkImage(issue.image),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(issue.name),
                Text(date),
              ],
            );
          },
        );
      },
    );
  }
}
