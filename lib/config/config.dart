abstract class Config {
  /// Maximum number of seconds a player can spend in a game. Can be made
  /// bigger by watching videos.
  static const int maxTime = 120;

  /// Amount of seconds given when rewarded video has been watched.
  static const int videoExtendsTime = Config.maxTime;
}
