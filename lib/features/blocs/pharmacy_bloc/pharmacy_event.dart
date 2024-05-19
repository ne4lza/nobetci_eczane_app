part of 'pharmacy_bloc.dart';

@immutable
abstract class PharmacyEvent extends Equatable {}


class LoadPharmacies extends PharmacyEvent{
  final String city;
  final String? district;
  LoadPharmacies(this.city,this.district);
  @override
  List<Object?> get props => [city,district];
}