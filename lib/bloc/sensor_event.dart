part of 'sensor_bloc.dart';

abstract class SensorsEvent extends Equatable {
  const SensorsEvent();
}

class InitializeSensorsEvent extends SensorsEvent {
  @override
  List<Object?> get props => [];
}

class UpdateSensorsEvent extends SensorsEvent {
  final List<Sensor> sensors;

  const UpdateSensorsEvent({required this.sensors});

  @override
  List<Object?> get props => [sensors];
}

class EditSensorsEvent extends SensorsEvent {
  final int id;
  final String name;
  final String description;

  const EditSensorsEvent({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}
