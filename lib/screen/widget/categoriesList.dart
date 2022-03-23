import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen.dart';
import 'widgets.dart';

class CategoriesList extends StatelessWidget {
  final List? listService;
  final listAnnonces;
  const CategoriesList({Key? key, this.listService, required this.listAnnonces})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: listService!
                  .map((e) => InkWell(
                        child: CustomCategoriesCards(e: e),
                        onTap: () => pushNewPage(
                            Scaffold(
                              backgroundColor: Colors.grey.shade200,
                              appBar: AppBar(
                                elevation: 0.0,
                                title: Text('Service ' + e['nom']),
                              ),
                              body: CupertinoScrollbar(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listAnnonces == null
                                      ? 0
                                      : listAnnonces['data'].length - 3,
                                  separatorBuilder: (_, i) =>
                                      SizedBox(height: 10.0),
                                  itemBuilder: (_, i) => InkWell(
                                    child: AnnonceCard(
                                      id: listAnnonces['data'][i + 3]['id'],
                                      title: listAnnonces['data'][i + 3]
                                          ['title'],
                                    ),
                                    onTap: () => pushNewPage(
                                        AnnonceDetailScreen(
                                          id: listAnnonces['data'][i + 3]['id'],
                                          title: listAnnonces['data'][i + 3]
                                              ['title'],
                                          clientid: listAnnonces['data'][i + 3]
                                              ['clientid'],
                                          description: listAnnonces['data']
                                              [i + 3]['description'],
                                        ),
                                        context),
                                  ),
                                ),
                              )),
                            ),
                            context),
                      ))
                  .toList()),
        ));
  }
}
