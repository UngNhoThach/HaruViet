import 'package:equatable/equatable.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object?> get props => [];
}

class StartTimerEvent extends PhoneAuthEvent {}

class TimerTickEvent extends PhoneAuthEvent {
  final int timerValue;

  const TimerTickEvent({required this.timerValue});

  @override
  List<Object?> get props => [timerValue];
}

class TimerEndedEvent extends PhoneAuthEvent {}
