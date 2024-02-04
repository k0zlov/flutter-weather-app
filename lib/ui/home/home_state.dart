class HomePageState {
  final bool isFahrenheit;

  const HomePageState({
    this.isFahrenheit = false,
  });

  HomePageState copyWith({
    bool? isFahrenheit,
  }) {
    return HomePageState(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
    );
  }
}
