import 'package:begappmyadmin/DatatableElements/classes/search.dart';
import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/forms/DropDownField.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Search search;

  SearchField({
    Key? key,
    required this.search,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController txtSearch = new TextEditingController();
  late String value;
  int index = 0;
  bool showArchive = false;
  @override
  void initState() {
    value = widget.search.filters[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (showArchive)
                      widget.search.search(widget.search.dbColumns[index],
                          txtSearch.text, showArchive);
                    else
                      widget.search.search(
                          widget.search.dbColumns[index], txtSearch.text);
                  },
                  controller: txtSearch,
                  decoration: InputDecoration(
                      // labelText://AppLocalizations.of(context).translate('experimentName'),
                      // filled: true,
                      // fillColor: Colors.white,
                      labelStyle: TextStyle(
                          // fontSize: labelSize
                          ),
                      suffixIcon: TextButton(
                          child: Icon(Icons.search),
                          onPressed: () {
                            if (showArchive)
                              widget.search.search(
                                  widget.search.dbColumns[index],
                                  txtSearch.text,
                                  showArchive);
                            else
                              widget.search.search(
                                  widget.search.dbColumns[index],
                                  txtSearch.text);
                          }),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('Required field');
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Flexible(
                flex: 1,
                child: DropDownField(
                  labelText: AppLocalizations.of(context).translate('filter'),
                  items: widget.search.filters,
                  value: value,
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue!;
                      index = widget.search.filters.indexOf(value);
                    });
                  },
                ),
              ),
            ],
          ),
          if (widget.search.suportArchive)
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: showArchive,
                        onChanged: (value) {
                          setState(() {
                            showArchive = value!;
                            widget.search.search(widget.search.dbColumns[index],
                                txtSearch.text, showArchive);
                          });
                        },
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('showArchiveExperiments'),
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.015),
                      )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
