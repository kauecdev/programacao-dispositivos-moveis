import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:final_project_pdm/model/weather.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';
part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherInitialState()) {
    on<GetWeather>((event, emit) async {
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      emit(WeatherSuccessState(weather: weather));
    });
  }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
    return Future.delayed(
      const Duration(seconds: 1),
          () {
        return Weather(
          cityName: cityName,
          temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
        );
      },
    );
  }

}