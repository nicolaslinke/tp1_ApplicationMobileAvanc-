class Singleton {

  static final Singleton _instance = Singleton._internal();

  Singleton._internal();

  static Singleton get instance => _instance;

  String username = "";
}