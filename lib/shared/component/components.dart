import 'package:flutter/material.dart';
import 'package:news/modules/web_view.dart';

Widget builtNewsItem(Map articles, context) => InkWell(
      onTap: () {
        navigateTo(context, Webview(articles['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${articles['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              //انت column خدت الباقي من ال row

              child: Container(
                height: 120,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      //  انت خدت الباقي من ال column في نفس الوقت ال column واخد اللي باقي من ال row اذا انت لما تخلص السطر مينفعش تخرج برا ال column وانزل سطر كمان

                      child: Text(
                        '${articles['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${articles['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
