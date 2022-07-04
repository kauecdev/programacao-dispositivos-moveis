import 'package:final_project_pdm/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<WeatherBloc>(
        create: (BuildContext context) => WeatherBloc(),
        child: const WeatherPage(),
      ),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherPageState();

}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = WeatherBloc();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fake Weather App"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            bloc: bloc,
            builder: (context, state) {
              print(state.weather);
              if (state is WeatherInitialState) {
                return const CityInputField();
              } else if (state is WeatherSuccessState) {
                return buildColumnWithData(state.weather!);
              }

              return const CircularProgressIndicator();
            },
          ),
      )
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "${weather.temperature.toStringAsFixed(1)} °C",
          style: const TextStyle(fontSize: 80),
        ),
        const CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatefulWidget {
  const CityInputField({
    Key? key,
  }) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  late final WeatherBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = WeatherBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(String cityName) {
    bloc.add(GetWeather(cityName: cityName));
  }
}