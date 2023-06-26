import 'package:comic_cabinet/models/issue.dart';
import 'package:comic_cabinet/utils/constants.dart';
import 'package:comic_cabinet/utils/display_error_dialog.dart';
import 'package:comic_cabinet/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListDisplay extends StatelessWidget {
  final Future<List<Issue>> issues;
  final void Function(BuildContext, String) redirect;
  final Key listKey = const Key('list key');
  const ListDisplay({
    super.key,
    required this.issues,
    required this.redirect,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat formater = DateFormat.yMMMMd('en_US');

    return FutureBuilder(
      future: issues,
      key: listKey,
      builder: (context, AsyncSnapshot<List<Issue>> snapshot) {
        if (snapshot.hasError) {
          String? message = snapshot.error.toString();
          if (message.contains('Failed host lookup')) {
            message = errorToMessage['internetError'];
          }

          return ShowErrorDialog().render(message!);
        }
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              LoaderDisplay().render(!snapshot.hasData),
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
                  child: InkWell(
                    onTap: () {
                      redirect(context, issue.detailUrl);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          width: MediaQuery.of(context).size.width / 2.5,
                          image: issue.image,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      redirect(context, issue.detailUrl);
                    },
                    child: Padding(
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
