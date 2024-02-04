abstract class TemperatureConverter {
  static int celsiusToFahrenheit(int celsius) {
    return ((celsius * 9/5) + 32).toInt();
  }
}