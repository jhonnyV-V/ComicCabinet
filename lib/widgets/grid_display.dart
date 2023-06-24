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
    final bool isTablet = MediaQuery.of(context).size.width > 600;
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

        return GridView.builder(
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 4 : 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 60,
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
                const SizedBox(
                  height: 10,
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
            );
          },
        );
      },
    );
  }
}
