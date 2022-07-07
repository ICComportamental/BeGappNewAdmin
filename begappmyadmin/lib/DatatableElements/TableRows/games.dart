import 'package:begappmyadmin/DatatableElements/TableRows/datatableRows.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:flutter/material.dart';

List<DataCell> getGames(Game game, index, contextDialog, setstate) {
  List<DataCell> row = [];
  List<String> datas = [
    (index).toString(),
    game.name,
    game.description,
    // "",
    // "",
    // "",
  ];
  datas.forEach((e) => row.add(DatatableRows.getCell(e)));
  row.forEach((e) => print(e.child));

  row.add(DatatableRows.getEditCell(
      condition: true, //game.adminId == localStorage.get('username'),
      edit: () async {
        //await Dialogs.showEditPublicGoodsExperiment(contextDialog, game);
        setstate();
      }));

  // row.add(DatatableRows.getSeeCell(
  //     condition: (game.adminId == localStorage.get('username') ||
  //         game.publicData ||
  //         localStorage.get('userType') == "master"),
  //     seeData: () {
  //       Navigator.pushNamed(contextDialog, PGParticipants.routeName,
  //           arguments: game.key);
  //     }));

  // row.add(DatatableRows.getDownloadCell(() async {
  //   Excelfile _excelfile = new Excelfile();

  //   List list = await Database.getPgParticipants(game.key);
  //   List<PgParticipant> listParticipants = [];

  //   for (int i = 0; i < list.length; i++) {
  //     listParticipants.add(PgParticipant.fromJson(list[i]));
  //   }
  //   _excelfile.createSheet(listParticipants, game.key);
  //   // _excelfile.saveExcel();
  //   List<Excelfile> files = [];
  //   files = await _excelfile.getPgParticipantsFiles(game.key);
  //   files.add(_excelfile);
  //   Excelfile.downloadZip(files, game.key);
  // }));

  // row.add(DatatableRows.getDeactivate(
  //     game.active, game.key, game.adminId, () {
  //   game.active = !game.active;
  //   Database.changeStatusPG(game.active, game.key);
  //   // Navigator.pushReplacementNamed(
  //   //     contextDialog, PublicGoodsExperimentsPage.routeName);
  //   // Navigator.pop(contextDialog);
  //   // Navigator.pushNamed(contextDialog, PublicGoodsExperimentsPage.routeName);
  // }, contextDialog));

  return row;
}
