import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:interview_project/model/sensor.dart';
import 'package:interview_project/repository/sensor_repository.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorsBloc extends Bloc<SensorsEvent, SensorsState> {
  final SensorRepository repository;

  SensorsBloc({required this.repository}) : super(SensorsInitial()) {
    on<InitializeSensorsEvent>(_initialize);
    on<UpdateSensorsEvent>(_update);
    on<EditSensorsEvent>(_edit);
  }

  StreamSubscription? _subscription;

  FutureOr<void> _initialize(
    InitializeSensorsEvent event,
    Emitter<SensorsState> emit,
  ) {
    _subscription?.cancel();

    _subscription = repository.sensorsStream.listen(
      (sensors) => add(UpdateSensorsEvent(sensors: sensors)),
    );

    repository.initializeSensors();
  }

  FutureOr<void> _update(UpdateSensorsEvent event, Emitter<SensorsState> emit) {
    emit(SensorsReady(sensors: event.sensors));
  }

  FutureOr<void> _edit(EditSensorsEvent event, Emitter<SensorsState> emit) {
    final state = this.state;
    if (state is SensorsReady) {
      final sensor = state.sensors.firstWhereOrNull(
        (sensor) => sensor.id == event.id,
      );
      if (sensor != null) {
        repository.updateSensor(
          sensor.copyWith(name: event.name, description: event.description),
        );
      }
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
