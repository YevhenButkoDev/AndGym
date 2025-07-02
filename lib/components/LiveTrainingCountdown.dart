import 'dart:async';
import 'package:flutter/material.dart';

import 'TrainingTimerPanel.dart';


class LiveTrainingCountdown extends StatefulWidget {
  final Duration initialDuration;

  const LiveTrainingCountdown({
    super.key,
    this.initialDuration = const Duration(minutes: 30),
  });

  @override
  State<LiveTrainingCountdown> createState() => _LiveTrainingCountdownState();
}

class _LiveTrainingCountdownState extends State<LiveTrainingCountdown> {
  late Duration _timeLeft;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.initialDuration;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        if (_timeLeft.inSeconds > 0) {
          _timeLeft -= const Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '${h}h ${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return TrainingTimerPanel(
      countdownText: _format(_timeLeft),
      onOpenPressed: () {
        // navigate or trigger logic
      },
      onExtraTimePressed: () {
        // show booking popup
      },
      onEditPressed: () {
        // open time edit
      },
      onViewAllBookingsPressed: () {
        // navigate to full bookings
      },
    );
  }
}