import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String? typeService;
  final String? statut;
  final String? nomPrenom;
  final int? note;
  final String? payement;
  const CustomCard(
      {Key? key,
      this.typeService,
      this.statut,
      this.nomPrenom,
      this.note,
      this.payement})
      : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  var serviceApi = ServiceApi();
  List? _getPresInf;
  @override
  void initState() {
    getPresInf();
    super.initState();
  }

  getPresInf() async {
    _getPresInf = await serviceApi.getPresInfo(widget.nomPrenom!);
    setState(() {});
    print(_getPresInf);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 147.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.typeService!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.statut!,
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: _getPresInf != null
                        ? Text(
                            (_getPresInf![0]['name'] +
                                ' ' +
                                _getPresInf![0]['surname']),
                            style: TextStyle(fontWeight: FontWeight.bold))
                        : CupertinoActivityIndicator(),
                    subtitle: Row(
                      children: List.generate(
                          widget.note!,
                          (index) => Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 13.0,
                              )),
                    ),
                    trailing: Text(widget.payement!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text("Monnaie : Fcfa"),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                          3,
                          (index) => Container(
                              margin: const EdgeInsets.all(2.0),
                              height: 8.0,
                              width: 8.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(25.0))))
                    ],
                  ),
                  ActionChip(
                      backgroundColor: Palette.chip,
                      label: Text("   "),
                      onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
