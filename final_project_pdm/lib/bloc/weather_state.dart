part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {
  final Weather? weather;

  const WeatherState({
    required this.weather
  });

}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState() : super(weather: null);

  @override
  List<Object?> get props => [weather];
}

class WeatherSuccessState extends WeatherState {
  const WeatherSuccessState({required Weather weather}) : super(weather: weather);

  @override
  List<Object?> get props => [weather];
}