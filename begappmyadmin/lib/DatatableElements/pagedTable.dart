// ignore_for_file: unnecessary_null_comparison

import 'package:begappmyadmin/DatatableElements/btnPagedTable.dart';
import 'package:begappmyadmin/DatatableElements/classes/search.dart';
import 'package:begappmyadmin/DatatableElements/searchField.dart';
import 'package:begappmyadmin/app_localizations.dart';
import 'package:flutter/material.dart';

import '../classes/MyCustomScrollBehavior.dart';

class PagedTable extends StatefulWidget {
  final Search? search;
  final Widget table;
  final Function previous;
  final Function next;
  final bool? appbar;
  final bool confirmBtn;

  const PagedTable(
      {Key? key,
      this.search,
      required this.table,
      required this.previous,
      required this.next,
      this.appbar: true,
      this.confirmBtn: false})
      : super(key: key);

  @override
  _PagedTableState createState() => _PagedTableState();
}

class _PagedTableState extends State<PagedTable> {
  @override
  Widget build(BuildContext context) {
    space() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      );
    }

    return Scrollbar(
        isAlwaysShown: true,
        child: ListView(children: [
          // if (widget.appbar!) AppBar(),
          space(),
          if (widget.search != null)
            SearchField(
              search: widget.search!,
            ),
          if (widget.search != null) space(),
          if (widget.table != null)
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: widget.table,
                  )),
            ),
          space(),
          PagedTableButtons(
            next: widget.next,
            previous: widget.previous,
          ),
          space(),
          if (widget.confirmBtn)
            Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.08,
                margin: EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context).translate('ok'),
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.015,
                          color: Colors.white,
                        ))))
        ]));
  }
}
