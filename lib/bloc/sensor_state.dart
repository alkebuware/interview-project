part of 'sensor_bloc.dart';

abstract class SensorsState extends Equatable {
  const SensorsState();
}

class SensorsInitial extends SensorsState {
  @override
  List<Object> get props => [];
}

class SensorsReady extends SensorsState {
  final List<Sensor> sensors;

  const SensorsReady({required this.sensors});

  @override
  List<Object?> get props => [sensors];

}
