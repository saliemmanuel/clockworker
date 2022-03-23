import 'package:flutter/material.dart';

import '../prestataire_detail_screen.dart';
import 'widgets.dart';

class PrestaireList extends StatelessWidget {
  final List? listPrestation;
  const PrestaireList({Key? key, required this.listPrestation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listPrestation == null
          ? []
          : [
              ListView.separated(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: listPrestation == null ? 0 : listPrestation!.length,
                separatorBuilder: (_, i) => SizedBox(height: 10.0),
                itemBuilder: (_, i) => InkWell(
                  child: CustomCard(
                    nomPrenom: listPrestation![i]['prestataire_id'].toString(),
                    note: 0,
                    payement: '3500',
                    statut: 'freelance',
                    typeService: listPrestation![i]['title'],
                  ),
                  onTap: () => pushNewPage(
                      PrestataireDetailScreen(
                        clientid: listPrestation![i]['prestataire_id'],
                        title: listPrestation![i]['title'],
                        description: listPrestation![i]['description'],
                      ),
                      context),
                ),
              ),
            ],
    );
  }
}
