import 'package:flutter/cupertino.dart';

class GameVariable {
  String type;
  TextEditingController txtName;
  TextEditingController txtDefault;
  GameVariable(this.type, this.txtName, this.txtDefault);
}
