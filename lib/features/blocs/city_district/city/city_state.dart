part of 'city_bloc.dart';

@immutable
abstract class CityState extends Equatable {}

final class CityInitial extends CityState {
  @override
  List<Object?> get props => [];
}

final class LoadingCities extends CityState{
  @override
  List<Object?> get props => [];
}

final class LoadedCities extends CityState {
  final List<CityModel> cities;
  LoadedCities(this.cities);  
  @override
  List<Object?> get props => [cities];
}

final class FailedLoadCities extends CityState{
  final String? error;
  FailedLoadCities(this.error);
  @override
  List<Object?> get props => [error];
}