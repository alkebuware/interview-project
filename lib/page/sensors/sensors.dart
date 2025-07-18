import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/bloc/sensor_bloc.dart';
import 'package:interview_project/model/sensor.dart';
import 'package:interview_project/page/sensors/edit_sensor_dialog.dart';
import 'package:interview_project/repository/sensor_repository.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  var _query = "";
  Order? _order;

  List<Sensor> _sortAndFilter(List<Sensor> sensors) {
    if (_query.isEmpty && _order == null) {
      return sensors;
    } else {
      return sensors
          .where((sensor) {
            return sensor.name.contains(_query) ||
                sensor.description.contains(_query);
          })
          .sorted((x, y) {
            if(_order == null){
              return 0;
            } else if (_order == Order.ascending) {
              return x.id.compareTo(y.id);
            } else {
              return y.id.compareTo(x.id);
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SensorRepository(),
      child: BlocProvider(
        create: (context) =>
            SensorsBloc(repository: context.read())
              ..add(InitializeSensorsEvent()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Sensors"),
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_order == Order.ascending) {
                          _order = Order.descending;
                        } else {
                          _order = Order.ascending;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.sort,
                      color: _order == null
                          ? Colors.black.withAlpha(64)
                          : Colors.black,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: TextField(
                      decoration: InputDecoration(label: Text("Search")),
                      onChanged: (value) => setState(() {
                        _query = value;
                      }),
                    ),
                  ),
                ),
              ),
              body: BlocBuilder<SensorsBloc, SensorsState>(
                builder: (context, state) {
                  if (state is SensorsReady) {
                    final sensors = _sortAndFilter(state.sensors);
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: sensors.length,
                      itemBuilder: (context, index) {
                        return _Sensor(
                          sensor: sensors[index],
                          sensorsBloc: context.read(),
                        );
                      },
                      separatorBuilder: (_, __) => Divider(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

enum Order { ascending, descending }

class _Sensor extends StatelessWidget {
  final Sensor sensor;
  final SensorsBloc sensorsBloc;

  const _Sensor({required this.sensor, required this.sensorsBloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return EditSensorDialog(sensor: sensor, sensorsBloc: sensorsBloc);
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ID: ${sensor.id}"),
          Text("NAME: ${sensor.name}"),
          Text("DESCRIPTION: ${sensor.description}"),
          Text("VALUE: ${sensor.value}"),
        ],
      ),
    );
  }
}
