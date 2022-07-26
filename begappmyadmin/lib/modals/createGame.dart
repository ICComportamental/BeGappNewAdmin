import 'dart:convert';

import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../classes/resultsFormat.dart';
import '../forms/DropDownField.dart';
import '../classes/variable.dart';

class CreateGame extends StatefulWidget {
  static const routeName = '/Create_Game';

  const CreateGame({
    Key? key,
  }) : super(key: key);
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
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
    getVariables();
    super.initState();
  }

  List<GameVariable> variables = [
    GameVariable("String", TextEditingController(text: ""),
        TextEditingController(text: ""))
  ];
  List<ResultsFormat> resultsFormats = [
    ResultsFormat(
      "String",
      TextEditingController(text: ""),
    )
  ];
  List<Widget> grid = [];
  var txtGameName = TextEditingController(text: "");
  var txtGameDesc = TextEditingController(text: "");
  bool participant = false;

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
                        var results = "";
                        resultsFormats.forEach((rf) {
                          if (rf == resultsFormats.first) {
                            results += "{ ";
                          }
                          results +=
                              """ "${rf.txtName.text}" : "${rf.type}" """;
                          if (rf != resultsFormats.last)
                            results += ", ";
                          else
                            results += "} ";
                        });
                        debugPrint("txtGameName: " + txtGameName.text);
                        debugPrint("desc: " + txtGameDesc.text);
                        String txt = await Database.createGame(
                          game: Game(
                            "",
                            txtGameName.text,
                            txtGameDesc.text,
                            "",
                            participant,
                            // {"a": "String"},
                            jsonDecode(json),
                            // jsonDecode(json),
                            jsonDecode(defaultParameters),
                            jsonDecode(results),
                          ),
                        );
                        await Dialogs.okDialog(
                          txt,
                          context,
                        );
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

  addResultFormat() {
    resultsFormats.add(ResultsFormat(
      "String",
      TextEditingController(text: ""),
    ));
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
                      "Descrição",
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
      Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: participant,
                  onChanged: (bool? value) {
                    participant = !participant;
                    getVariables();
                    setState(() {});
                  },
                ),
                const Text(
                  "Pegar informações padrão de participante (nome, email, idade)",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
      const Padding(
          padding: EdgeInsets.only(bottom: 10, left: 10, top: 10),
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
                    "Valor padrão",
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
    getResultsFormats();
  }

  getResultsFormats() {
    grid.add(const Padding(
        padding: EdgeInsets.only(bottom: 10, left: 10),
        child: Text(
          "Defina o Formato dos Resultados",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )));

    resultsFormats.forEach((rf) {
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
                  value: rf.type,
                  items: types,
                  onChanged: (String? newValue) {
                    setState(() {
                      rf.type = newValue!;
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
                  controller: rf.txtName,
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

            ElevatedButton(
              child: const Text(
                '-',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () async {
                resultsFormats.remove(rf);
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
            addResultFormat();
            setState(() {});
          },
        ),
      ),
    );
  }
}
