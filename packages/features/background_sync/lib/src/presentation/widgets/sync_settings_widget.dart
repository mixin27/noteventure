import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/background_sync_bloc.dart';
import '../bloc/background_sync_event.dart';
import '../bloc/background_sync_state.dart';

class SyncSettingsWidget extends StatefulWidget {
  const SyncSettingsWidget({super.key});

  @override
  State<SyncSettingsWidget> createState() => _SyncSettingsWidgetState();
}

class _SyncSettingsWidgetState extends State<SyncSettingsWidget> {
  int _syncFrequencyMinutes = 15;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BackgroundSyncBloc, BackgroundSyncState>(
      listener: (context, state) {
        if (state is BackgroundSyncEnabled) {
          _syncFrequencyMinutes = state.syncFrequency.inMinutes;
        }
        if (state is BackgroundSyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isEnabled = state is BackgroundSyncEnabled;

        return Column(
          children: [
            if (isEnabled) ...[
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Sync Frequency'),
                subtitle: Text('Every $_syncFrequencyMinutes minutes'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Slider(
                      value: _syncFrequencyMinutes.toDouble(),
                      min: 15,
                      max: 120,
                      divisions: 7,
                      label: '$_syncFrequencyMinutes min',
                      onChanged: (value) {
                        setState(() => _syncFrequencyMinutes = value.toInt());
                      },
                      onChangeEnd: (value) {
                        context.read<BackgroundSyncBloc>().add(
                          UpdateSyncFrequencyEvent(
                            Duration(minutes: _syncFrequencyMinutes),
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '15 min',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '120 min',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
