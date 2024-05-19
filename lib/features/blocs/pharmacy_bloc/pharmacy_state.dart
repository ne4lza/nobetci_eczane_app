part of 'pharmacy_bloc.dart';


@immutable
abstract class PharmacyState extends Equatable {}

final class PharmacyInitial extends PharmacyState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class NotLoaded extends PharmacyState{
  @override
  List<Object?> get props => [];
}

final class LoadingPharmacies extends PharmacyState{
  @override
  List<Object?> get props => [];
}

final class LoadedPharmacies extends PharmacyState {
  final List<PharmacyModel> pharmacyList;
  LoadedPharmacies(this.pharmacyList);  
  @override
  List<Object?> get props => [pharmacyList];
}

final class FailedLoadPharmacies extends PharmacyState{
  final String? error;
  FailedLoadPharmacies(this.error);
  @override
  List<Object?> get props => [error];
}