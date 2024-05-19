part of 'last_update_bloc.dart';

@immutable
abstract class LastUpdateEvent extends Equatable {}


class LoadLastUpdateDate extends LastUpdateEvent{
  @override
  List<Object?> get props => [];
}
