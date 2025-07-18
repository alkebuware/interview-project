import 'package:flutter/material.dart';
import 'package:interview_project/bloc/sensor_bloc.dart';
import 'package:interview_project/model/sensor.dart';

class EditSensorDialog extends StatefulWidget {
  final SensorsBloc sensorsBloc;
  final Sensor sensor;

  const EditSensorDialog({
    super.key,
    required this.sensor,
    required this.sensorsBloc,
  });

  @override
  State<EditSensorDialog> createState() => _EditSensorDialogState();
}

class _EditSensorDialogState extends State<EditSensorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.text = widget.sensor.name;
    _description.text = widget.sensor.description;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit Sensor ${widget.sensor.id}"),
              TextFormField(
                controller: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(label: Text("Name")),
              ),
              TextFormField(
                controller: _description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(label: Text("Description")),
                maxLines: 3,
                minLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.sensorsBloc.add(
                          EditSensorsEvent(
                            id: widget.sensor.id,
                            name: _name.text,
                            description: _description.text,
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
