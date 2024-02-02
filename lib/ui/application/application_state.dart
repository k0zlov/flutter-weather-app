class ApplicationState {
  final bool isDarkTheme;

  const ApplicationState({
    this.isDarkTheme = false,
  });

  ApplicationState copyWith({
    bool? isDarkTheme,
  }) {
    return ApplicationState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}