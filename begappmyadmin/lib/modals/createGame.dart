import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List<String> types = ["int", "String", "Double", "Float", "bool"];

  // String type = "String";
  bool electionAndDistribution = false;
  bool showRounds = false;
  bool publicConfig = false;
  bool publicData = false;
  double labelSize = 0;
  int intLength = 11;

  var txtExperimentName = new TextEditingController();
  var txtDesc = new TextEditingController();
  var txtMaxTokens = new TextEditingController();
  var txtFactor = new TextEditingController();
  var txtMaxTrys = new TextEditingController();
  var txtPlayers = new TextEditingController();
  var txtTime = new TextEditingController();
  var txtTimeDistribution = new TextEditingController();
  var txtTimeElection = new TextEditingController();
  var txtStable = new TextEditingController();
  var txtLimiteVotes = new TextEditingController();
  var txtSuspended = new TextEditingController();
  var txtContributionVariation = new TextEditingController();
  var txtDistributionVariation = new TextEditingController();
  var txtUnfairDistribution = new TextEditingController();
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
    GameVariable("String", "", TextEditingController(text: ""))
  ];
  List<Widget> grid = [];

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
                            )),
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
                    onPressed: () {
                      print('Pressed');
                    },
                  ),
                ])));
  }

  addVariable() {
    variables.add(GameVariable("String", "", TextEditingController()));
    getVariables();
  }

  getVariables() {
    print(variables.length);
    print(grid.length);
    grid = [];
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
                      return "erro";
                      //AppLocalizations.of(context)
                      //  .translate('Required field');
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
