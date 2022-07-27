// import 'package:begappmyadmin/DatatableElements/TableRows/datatableRows.dart';
// import 'package:begappmyadmin/app_localizations.dart';
// import 'package:begappmyadmin/widgets/customDatatable.dart';
// import 'package:flutter/material.dart';

// class EditableDatatable extends StatefulWidget {
//   final List elements;
//   final List allElements;
//   final List<String> headerTitles;
// //id editable, if logged

//   const EditableDatatable({
//     Key? key,
//     required this.elements,
//     required this.allElements,
//     required this.headerTitles,
//   }) : super(key: key);

//   @override
//   _EditableDatatableState createState() => _EditableDatatableState();
// }

// class _EditableDatatableState extends State<EditableDatatable> {
//   final Alignment headerAlign = Alignment.center;
//   List<DataRow> rows = [];
//   setRows() {}
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextStyle _headerTextStyle =
//         const TextStyle(color: Colors.white, fontSize: 20);
//     DatatableRows datatableRows = DatatableRows();

//     return (widget.elements.isEmpty)
//         ? Center(
//             child: Text(AppLocalizations.of(context).translate('noResults'),
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: MediaQuery.of(context).size.width * 0.06)))
//         : Container(
//             alignment: Alignment.center,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: CustomDataTable(
//                 dataTable: DataTable(
//                     headingRowHeight: 56,
//                     dataRowHeight: kMinInteractiveDimension,
//                     horizontalMargin: 24,
//                     columnSpacing: 24,
//                     columns: widget.headerTitles
//                         .map(
//                           (title) => DataColumn(
//                               label: Expanded(
//                                   child: Container(
//                                       alignment: headerAlign,
//                                       child: Text(
//                                         title,
//                                         style: _headerTextStyle,
//                                         textAlign: TextAlign.center,
//                                       )))),
//                         )
//                         .toList(),
//                     rows: widget.elements.map(
//                       (element) {
//                         // print(element.runtimeType);
//                         return DataRow(
//                             cells: datatableRows.getData(
//                                 element,
//                                 widget.allElements.indexOf(element) + 1,
//                                 context, () {
//                           setState(() {});
//                         }));
//                       },
//                     ).toList()),
//               ),
//             ) //headerColor: Colors.purple,
//             );
//   }
// }
