import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/config/config.dart';
import 'package:clockworker/data/data.dart';
import 'package:clockworker/screen/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screen.dart';

class ClientSearchScreen extends StatefulWidget {
  const ClientSearchScreen({Key? key}) : super(key: key);

  @override
  _ClientSearchScreenState createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  var publication;
  var serviceApi = ServiceApi();
  @override
  void initState() {
    getAnnonce();
    super.initState();
  }

  getAnnonce() async {
    publication = await serviceApi.getPublication();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: CustomSearchButton(
            pList: publication, page: SearchPrestataire(publication)),
      ),
      body: CupertinoScrollbar(
        child: ListView(
          children: publication == null
              ? []
              : [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: publication == null ? 0 : publication.length,
                      separatorBuilder: (_, i) => SizedBox(height: 10.0),
                      itemBuilder: (_, i) => InkWell(
                        child: CustomCard(
                          nomPrenom:
                              publication![i]['prestataire_id'].toString(),
                          note: 0,
                          payement: '3500',
                          statut: 'freelance',
                          typeService: publication![i]['title'],
                        ),
                        onTap: () => pushNewPage(
                            PrestataireDetailScreen(
                              clientid: publication![i]['prestataire_id'],
                              title: publication![i]['title'],
                              description: publication![i]['description'],
                            ),
                            context),
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}

class SearchPrestataire extends SearchDelegate {
  final listPublication;

  SearchPrestataire(this.listPublication);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close, color: Colors.black))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    dynamic _listPublication;
    newList = listPublication;
    _listPublication = query.isEmpty
        ? newList
        : newList!
            .where(
                (a) => a['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: _listPublication == null ? 0 : _listPublication.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          child: CustomCard(
            nomPrenom: _listPublication![i]['prestataire_id'].toString(),
            note: 0,
            payement: '3500',
            statut: 'freelance',
            typeService: _listPublication![i]['title'],
          ),
          onTap: () => pushNewPage(
              PrestataireDetailScreen(
                clientid: _listPublication![i]['prestataire_id'],
                title: _listPublication![i]['title'],
                description: _listPublication![i]['description'],
              ),
              context),
        ),
      ),
    );
  }
}
