import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/config/config.dart';
import 'package:clockworker/data/data.dart';
import 'package:clockworker/screen/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screen.dart';

class PrstataireSearchScreen extends StatefulWidget {
  const PrstataireSearchScreen({Key? key}) : super(key: key);

  @override
  _PrstataireSearchScreenState createState() => _PrstataireSearchScreenState();
}

class _PrstataireSearchScreenState extends State<PrstataireSearchScreen> {
  var annonces;
  var serviceApi = ServiceApi();
  @override
  void initState() {
    getAnnonce();
    super.initState();
  }

  getAnnonce() async {
    annonces = await serviceApi.getAnnonces();
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
              pList: annonces, page: SearchAnnonce(listAnnonce: annonces)),
        ),
        body: ListView(
          children: [
            if (annonces == null)
              Center(
                  child:
                      CircularProgressIndicator(color: Palette.iconBottomColor))
            else
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: AnnonceList(listAnnonces: annonces),
              ),
          ],
        ));
  }
}

class SearchAnnonce extends SearchDelegate {
  final listAnnonce;

  SearchAnnonce({this.listAnnonce});

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
    dynamic _listAnnonce;
    newList = listAnnonce;
    _listAnnonce = query.isEmpty
        ? newList
        : newList!
            .where(
                (a) => a['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: _listAnnonce == null ? 0 : _listAnnonce.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          child: AnnonceCard(
            id: 123,
            title: _listAnnonce[i]['title'],
          ),
          onTap: () => pushNewPage(
              AnnonceDetailScreen(
                clientid: _listAnnonce[i]['client_id'],
                description: _listAnnonce[i]['client_id'],
                id: _listAnnonce[i]['id'],
                title: _listAnnonce[i]['title'],
              ),
              context),
        ),
      ),
    );
  }
}
