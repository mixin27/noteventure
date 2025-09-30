class PointCosts {
  // Prevent instantiation
  PointCosts._();

  // Note Actions
  static const int createNote = 10;
  static const int editNote = 10;
  static const int deleteNote = 15;
  static const int previewNote = 5;

  // Special Notes
  static const int createVaultNote = 100;
  static const int createMysteryNote = 20;
  static const int createTimeCapsuleNote = 50;
  static const int createChallengeNote = 30;

  // Chaos Control
  static const int disableChaosOneHour = 50;
  static const int disableChaosOneDay = 200;

  // Theme Unlocks
  static const int themeRetroTerminal = 100;
  static const int themeVaporwave = 150;
  static const int themeBrutalist = 75;
  static const int themeComicBook = 200;
  static const int themeHandwritten = 125;
  static const int themeNeonCyberpunk = 250;

  // Helper method to get cost by action
  static int getCostForAction(String action) {
    switch (action.toLowerCase()) {
      case 'create':
        return createNote;
      case 'edit':
        return editNote;
      case 'delete':
        return deleteNote;
      case 'preview':
        return previewNote;
      default:
        return 0;
    }
  }

  // Helper method to get cost by note type
  static int getCostForNoteType(String noteType) {
    switch (noteType.toLowerCase()) {
      case 'vault':
        return createVaultNote;
      case 'mystery':
        return createMysteryNote;
      case 'timecapsule':
        return createTimeCapsuleNote;
      case 'challenge':
        return createChallengeNote;
      case 'standard':
      default:
        return createNote;
    }
  }
}
