class MyConverter {
  static int stringToInt(String number) => int.parse(number);
  static String stringFromInt(int number) => number.toString();

  static Duration stringToDuration(String s) {
    // if(s == null) return null;
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static String stringFromDuration(Duration d) {
    return d.toString();
  }

  static bool stringToBool(String b) => parseBool(b);
  static String stringFromBool(bool b) => b.toString();

  static bool parseBool(String b) {
    return b.toLowerCase() == '1';
  }

  static int ruleToInt(String rule) => getRule(rule);
  static String ruleFromInt(int rule) => rule.toString();

  static int getRule(String rule) {
    switch (rule) {
      case "intermittent election disabled":
        return 1;
      case "intermittent election enabled":
        return 2;
      case "recurring election disabled":
        return 3;
      case "recurring election enabled":
        return 4;
      default:
        return 0;
    }
  }
}
