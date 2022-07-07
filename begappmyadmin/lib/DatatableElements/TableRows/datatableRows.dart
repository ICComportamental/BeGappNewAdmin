import 'package:begappmyadmin/DatatableElements/TableRows/games.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:flutter/material.dart';

//Classe para organizar os elementos das tabelas, editar, baixar...
class DatatableRows {
  static Alignment rowsAlign = Alignment.center;
  DatatableRows();

  List<DataCell> getData(data, index, contextDialog, setstate) {
    // if (data is Game)
    return getGames(data, index, contextDialog, setstate);

    // else
    //   return getPopUpMessageDilemma(data, index, contextDialog, setstate);
  }

  static getApproveCell({required bool condition, required Function approve}) {
    return DataCell(
        Center(
            child: Icon(
          Icons.check_circle,
          color: condition ? Colors.green : Colors.red,
        )),
        onTap: condition ? () => approve() : null);
  }

  static getEditCell({required bool condition, required Function edit}) {
    return DataCell(
        Center(
            child: Icon(
          Icons.edit,
          color: condition ? Colors.green : Colors.red,
        )),
        onTap: condition ? () => edit() : null);
  }

  static getDeleteCell({required Function delete}) {
    return DataCell(
        const Center(
            child: Icon(
          Icons.delete,
          color: Colors.blueGrey,
        )),
        onTap: () => delete());
  }

  static getSeeCell({required bool condition, required Function seeData}) {
    return DataCell(
        Center(
            //so deixa ver os resultados se o experimento for do admin ou forem publicos
            child: Icon(
          Icons.gradient,
          color: condition ? Colors.green : Colors.red,
        )),
        onTap: condition ? () => seeData() : null);
  }

  static getDownloadCell(Function download) {
    return DataCell(Center(child: Icon(Icons.file_download)),
        onTap: () => download());
  }

  static getCell(String data, {bool selectable: true}) {
    if (data.length < 15) {
      return DataCell(
        Container(
            alignment: rowsAlign,
            child: selectable
                ? SelectableText(
                    data,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  )
                : Text(data, textAlign: TextAlign.center)),
      );
    } else {
      return DataCell(
        Container(
          width: kMinInteractiveDimension * 2,
          height: kMinInteractiveDimension,
          child: Text(
            data,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      );
    }
  }

  // static getDeactivate(bool active, String key, admin, onTap, contextDialog) {
  //   Color color;
  //   String message = "";
  //   if (localStorage.get('username') == admin) {
  //     if (active) {
  //       color = Colors.red;
  //       message = AppLocalizations.of(contextDialog).translate('unarchive');
  //     } else {
  //       color = Colors.green;
  //       message = AppLocalizations.of(contextDialog).translate('tofiled');
  //     }
  //   } else {
  //     color = Colors.grey;
  //     message = AppLocalizations.of(contextDialog).translate('unauthorized');
  //   }
  //   return DataCell(
  //       Center(
  //           //so deixa arquivar ou não se o experimento for do admin
  //           child: Tooltip(
  //         message: message,
  //         child: Icon(
  //           Icons.download_for_offline_rounded,
  //           color: color,
  //         ),
  //       )),
  //       onTap: localStorage.get('username') == admin ? onTap() : null);
  // }
}
