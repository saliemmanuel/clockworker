import 'package:flutter/material.dart';

import '../screen.dart';
import 'widgets.dart';

class AnnonceList extends StatelessWidget {
  final listAnnonces;
  const AnnonceList({Key? key, required this.listAnnonces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: listAnnonces == null ? 0 : listAnnonces.length,
          separatorBuilder: (_, i) => SizedBox(height: 10.0),
          itemBuilder: (_, i) => InkWell(
            child: AnnonceCard(
              id: listAnnonces[i]['id'],
              title: listAnnonces[i]['title'],
            ),
            onTap: () => pushNewPage(
                AnnonceDetailScreen(
                  id: listAnnonces[i]['id'],
                  title: listAnnonces[i]['title'],
                  clientid: listAnnonces[i]['client_id'],
                  description: listAnnonces[i]['description'],
                ),
                context),
          ),
        )
      ],
    );
  }
}
