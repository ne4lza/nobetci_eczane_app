part of 'city_bloc.dart';

@immutable
abstract class CityEvent extends Equatable {}

class LoadCtites extends CityEvent{
  @override
  List<Object?> get props => [];
}
