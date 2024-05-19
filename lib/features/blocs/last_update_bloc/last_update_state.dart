part of 'last_update_bloc.dart';

@immutable
abstract class LastUpdateState extends Equatable {}

final class LastUpdateInitial extends LastUpdateState {
  @override
  List<Object?> get props => [];
}

final class LoadingLastUpdateDate extends LastUpdateState{
  @override
  List<Object?> get props => [];
}

final class LoadedLastUpdateDate extends LastUpdateState{
  final PharmacyStatus data;
  LoadedLastUpdateDate(this.data);
  @override
  List<Object?> get props => [data];
}

final class FailedLoadLastUpdateDate extends LastUpdateState{
  final String? error;
  FailedLoadLastUpdateDate(this.error);
  @override
  List<Object?> get props => [error];
}