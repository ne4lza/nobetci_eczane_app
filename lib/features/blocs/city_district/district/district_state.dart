part of 'district_bloc.dart';

@immutable
abstract class DistrictState extends Equatable {
}

final class DistrictInitial extends DistrictState {
  @override
  List<Object?> get props =>[];
}

final class LoadingDistricts extends DistrictState{
  @override
  List<Object?> get props => [];
}

final class LoadedDistricts extends DistrictState {
  final List<DistrictModel> districts;
  LoadedDistricts(this.districts);  
  @override
  List<Object?> get props => [districts];
}

final class FailedLoadDistricts extends DistrictState{
  final String? error;
  FailedLoadDistricts(this.error);
  @override
  List<Object?> get props => [error];
}
