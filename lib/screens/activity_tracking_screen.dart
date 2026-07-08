import 'dart:async';
import 'package:flutter/material.dart';

class ActivityTrackingScreen extends StatefulWidget {
  final String activityType;

  const ActivityTrackingScreen({super.key, required this.activityType});

  @override
  State<ActivityTrackingScreen> createState() => _ActivityTrackingScreenState();
}

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _togglePause() {
    setState(() {
      if (_isPaused) {
        _stopwatch.start();
      } else {
        _stopwatch.stop();
      }
      _isPaused = !_isPaused;
    });
  }

  void _stopActivity() {
    _stopwatch.stop();
    setState(() {
      _isPaused = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Intensité de l\'effort'),
        content: const Text('Comment qualifieriez-vous votre séance ?'),
        actions: [
          _intensityButton('Tranquille', 0.8),
          _intensityButton('Sportif', 1.0),
          _intensityButton('Intense', 1.3),
        ],
      ),
    );
  }

  Widget _intensityButton(String label, double multiplier) {
    return TextButton(
      onPressed: () {
        final calories = _calculateCalories(multiplier);
        Navigator.pop(context); // Close dialog
        Navigator.pop(context, {
          'calories': calories,
          'duration': _stopwatch.elapsed,
          'type': widget.activityType,
        }); // Return detailed map to dashboard
      },
      child: Text(label),
    );
  }

  int _calculateCalories(double intensityMultiplier) {
    // Base kcal/min per activity type
    double baseKcalPerMin;
    switch (widget.activityType) {
      case 'Marche':
        baseKcalPerMin = 4.0;
        break;
      case 'Course':
        baseKcalPerMin = 11.0;
        break;
      case 'Vélo':
        baseKcalPerMin = 8.0;
        break;
      case 'Autre':
      default:
        baseKcalPerMin = 6.0;
        break;
    }

    double minutes = _stopwatch.elapsed.inSeconds / 60.0;
    return (baseKcalPerMin * intensityMultiplier * minutes).round();
  }

  @override
  Widget build(BuildContext context) {
    final duration = _stopwatch.elapsed;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        title: const Text('Activité en cours'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF2C3E50),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.activityType,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Temps écoulé',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7F8C8D),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _formatDuration(duration),
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Color(0xFF2C3E50),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _togglePause,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isPaused ? const Color(0xFFA2B997) : Colors.orangeAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _isPaused ? 'REPRENDRE' : 'PAUSE',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _stopActivity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'STOP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
