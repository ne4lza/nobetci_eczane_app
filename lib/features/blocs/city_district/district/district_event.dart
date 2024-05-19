part of 'district_bloc.dart';

@immutable
abstract class DistrictEvent extends Equatable {}

class LoadDistricts extends DistrictEvent {
  final String cityName;

  LoadDistricts(this.cityName);
  @override
  List<Object?> get props => [cityName];
}
