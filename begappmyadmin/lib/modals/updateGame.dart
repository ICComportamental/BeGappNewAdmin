import 'dart:convert';

import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../forms/DropDownField.dart';
import '../classes/variable.dart';

class UpdateGame extends StatefulWidget {
  static const routeName = '/Create_Game';

  Game game;
  UpdateGame(this.game);
  @override
  _UpdateGameState createState() => _UpdateGameState();
}

class _UpdateGameState extends State<UpdateGame> {
  late Game defaultVariables;
  final _formKey = GlobalKey<FormState>();
  List<String> electionRules = [
    "intermittent election disabled",
    "intermittent election enabled",
    "recurring election disabled",
    "recurring election enabled"
  ];
  // List<String> types = ["int", "String", "Double", "Float", "bool"];
  List<String> types = [
    "String",
    "Int32",
    "UInt32",
    "Boolean",
    "Double",
    "Decimal"
  ];

  // String type = "String";
  bool electionAndDistribution = false;
  bool showRounds = false;
  bool publicConfig = false;
  bool publicData = false;
  double labelSize = 0;
  int intLength = 11;

  // var maskFormatter =
  //     MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

  setDecoration(String label) {
    return InputDecoration(
        counterText: "",
        labelText: label,
        labelStyle: TextStyle(fontSize: labelSize),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ));
  }

  // PopUpMessagePublicGoods? popUpMessage;
  // setPopUpMessage(PopUpMessagePublicGoods message) {
  //   popUpMessage = message;
  // }

  List<int>? _selectedFile;

  getSelectedFile(List<int> file) {
    _selectedFile = file;
  }

  @override
  void initState() {
    txtGameName.text = widget.game.name;
    txtGameDesc.text = widget.game.description;
    widget.game.parameters.forEach((key, value) {
      print("value:" + key);
      int i = widget.game.parameters.keys.toList().indexOf(key);
      String defaulfPar = "";
      widget.game.defaultParameters.entries.forEach((element) {
        print("ELEMENT:" + element.value);
        if (element.key == key) defaulfPar = element.value;
      });
      variables.add(GameVariable(value, TextEditingController(text: key),
          TextEditingController(text: defaulfPar)));
    });

    getVariables();
    super.initState();
  }

  List<GameVariable> variables = [];
  List<Widget> grid = [];
  var txtGameName = TextEditingController(text: "");
  var txtGameDesc = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    labelSize = MediaQuery.of(context).size.width * 0.015;
    // if (rule == "") rule = rules[defaultVariables.electionRule - 1];

    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      // child: GridView.count(
                      //     padding: const EdgeInsets.all(20),
                      //     shrinkWrap: true,
                      //     crossAxisSpacing: 30,
                      //     mainAxisSpacing: 3.0,
                      //     crossAxisCount: 3,
                      //     childAspectRatio: 7,
                      //     children:
                      child: ListView(children: [...grid]
                          /*[
                                DropDownField(
                                  labelText: "Tipo",
                                  // AppLocalizations.of(context)
                                  //  .translate('electionRule'),
                                  value: type,
                                  items: types,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      type = newValue!;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller: txtExperimentName,
                                  decoration: setDecoration(
                                    "Nome",
                                    // AppLocalizations.of(context)
                                    //     .translate('experimentName')
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 100,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "erro";
                                      //AppLocalizations.of(context)
                                      //  .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                              ]*/
                          ),
                    ),
                    // ),
                  ),
                  ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        debugPrint('Pressed');
                        var json = "";
                        variables.forEach((element) {
                          if (element == variables.first) {
                            json += "{ ";
                          }
                          json +=
                              """ "${element.txtName.text}" : "${element.type}" """;
                          if (element != variables.last)
                            json += ", ";
                          else
                            json += "} ";
                        });
                        var defaultParameters = "";
                        variables.forEach((element) {
                          if (element == variables.first) {
                            defaultParameters += "{ ";
                          }
                          defaultParameters +=
                              """ "${element.txtName.text}" : "${element.txtDefault.text}" """;
                          if (element != variables.last)
                            defaultParameters += ", ";
                          else
                            defaultParameters += "} ";
                        });
                        debugPrint("txtGameName: " + txtGameName.text);
                        debugPrint("desc: " + txtGameDesc.text);
                        String txt = await Database.updateGame(
                          game: Game(
                            widget.game.id,
                            txtGameName.text,
                            txtGameDesc.text,
                            widget.game.creator,
                            jsonDecode(json),
                            jsonDecode(defaultParameters),
                          ),
                        );
                        await Dialogs.okDialog(txt, context, onPop: () {
                          Navigator.pushNamed(context, "/GamesPage");
                        });
                      }
                    },
                  ),
                ])));
  }

  addVariable() {
    variables.add(GameVariable(
        "String", TextEditingController(text: ""), TextEditingController()));
    getVariables();
  }

  getVariables() {
    print(variables.length);
    print(grid.length);
    grid = [
      Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: txtGameName,
                    decoration: setDecoration(
                      "Nome do Jogo",
                      // AppLocalizations.of(context)
                      //     .translate('experimentName')
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 100,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('Required field');
                      }
                      return null;
                    },
                  ))),
        ],
      ),
      Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: txtGameDesc,
                    decoration: setDecoration(
                      "Descri????o",
                      // AppLocalizations.of(context)
                      //     .translate('experimentName')
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 100,
                    maxLines: 2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('Required field');
                      }
                      return null;
                    },
                  ))),
        ],
      ),
      const Padding(
          padding: EdgeInsets.only(bottom: 10, left: 10),
          child: Text(
            "Variaveis",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ))
    ];
    variables.forEach((element) {
      grid.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: DropDownField(
                  labelText: "Tipo",
                  // AppLocalizations.of(context)
                  //  .translate('electionRule'),
                  value: element.type,
                  items: types,
                  onChanged: (String? newValue) {
                    setState(() {
                      element.type = newValue!;
                    });
                  },
                ),
              ),
            ),

            // );
            // grid.add(
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: element.txtName,
                  decoration: setDecoration(
                    "Nome",
                    // AppLocalizations.of(context)
                    //     .translate('experimentName')
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 100,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('Required field');
                    }
                    return null;
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: element.txtDefault,
                  decoration: setDecoration(
                    "Valor padr??o",
                    // AppLocalizations.of(context)
                    //     .translate('experimentName')
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 100,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('Required field');
                    }
                    return null;
                  },
                ),
              ),
            ),
            ElevatedButton(
              child: const Text(
                '-',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () async {
                variables.remove(element);
                getVariables();
                setState(() {});
              },
            ),
          ],
        ),
      ));
    });
    grid.add(
      Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.only(right: 20),
        child: ElevatedButton(
          child: const Text(
            '+',
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () async {
            addVariable();
            setState(() {});
          },
        ),
      ),
    );
  }
}
