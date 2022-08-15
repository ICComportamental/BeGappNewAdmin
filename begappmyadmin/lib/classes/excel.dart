// ignore_for_file: unnecessary_null_comparison, await_only_futures, unused_local_variable

import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:archive/archive_io.dart';
import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/roundResults.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'participant.dart';

class Excelfile {
  var excel = Excel.createExcel();
  late String name;
  Excelfile();

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

//excel com as info dos particpantes dos bens publicos
  createSheet(
    List<Participant> participants,
  ) async {
    excel.rename('Sheet1', "Participante");
    Sheet sheetObject = excel["Participante"];

    List<String> dataList = [
      "id",
      "Nome",
      "Email",
      "Idade",
      "Gênero",
    ];

    sheetObject.insertRowIterables(dataList, 0);

    participants.forEach((element) {
      List<dynamic> rowList = [];

      rowList.add(element.id);
      rowList.add(element.name);
      rowList.add(element.email);
      rowList.add(element.age);
      rowList.add(element.gender);

      sheetObject.insertRowIterables(
          rowList, participants.indexOf(element) + 1);
    });
    excel.setDefaultSheet("Participante");
    name = participants.first.experimentId;
    var jsonList = await Database.getRoundsResult(participants.first.id);
    List<RoundResults> rounds = [];
    for (int index = 0; index < jsonList.length; index++) {
      rounds.add(RoundResults.fromJson(jsonList[index]));
    }
    roundsSheetPg(rounds);

    // List<Excelfile> files = [];
    // files.add(this);
    // downloadZip(files, "zipName");
  }

  roundsSheetPg(List<RoundResults> roundsData) {
    excel.rename('Sheet1', roundsData.first.participantId.toString());
    Sheet sheetObject = excel[roundsData.first.participantId.toString()];
    name = roundsData.first.participantId.toString();

    List<String> dataList = ["id"];

    roundsData.first.result.entries.forEach((re) {
      dataList.add(re.key);
    });

    sheetObject.insertRowIterables(dataList, 0);

    roundsData.forEach((round) {
      List<dynamic> rowList = [];
      round.result.entries.forEach((re) {
        rowList.add(re.value);
      });
      sheetObject.insertRowIterables(rowList, roundsData.indexOf(round) + 1);
    });

    excel.setDefaultSheet(sheetObject.sheetName);
    saveExcel();
    List<Excelfile> files = [];
    files.add(this);
    downloadZip(files, "zipName");
  }

  saveExcel() async {
    // await downloadZip(name);

    final rawData = await excel.encode();

    final content = base64Encode(rawData!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-8;base64,$content")
      ..setAttribute("download", "$name.xlsx")
      ..click();
  }

  static downloadZip(List<Excelfile> files, String zipName) async {
    //objeto do futuro zip
    Archive zipArchive = new Archive();

    files.forEach((e) async {
      final rawData = e.excel.encode();

      final content = rawData;

      ArchiveFile excelFile =
          new ArchiveFile("${e.name}.xlsx", content!.length, content);
      //adiciona o arquivo excel ao zip
      zipArchive.addFile(excelFile);
    });

    List<int> zipInBytes = new ZipEncoder().encode(zipArchive)!;
    final base64 = base64Encode(zipInBytes);

    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-8;base64,$base64")
      ..setAttribute("download", "$zipName.zip")
      ..click();
  }

  downloadZipok(String name) async {
    final rawData = await excel.encode();

    final content = rawData;

    ArchiveFile excelFile =
        new ArchiveFile("$name.xlsx", content!.length, content);

    Archive zipArchive = new Archive();
    zipArchive.addFile(excelFile);
    zipArchive.addFile(excelFile);
    List<int> zipInBytes = new ZipEncoder().encode(zipArchive)!;
    final base64 = base64Encode(zipInBytes);

    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-8;base64,$base64")
      ..setAttribute("download", "$name.zip")
      ..click();
  }
}
