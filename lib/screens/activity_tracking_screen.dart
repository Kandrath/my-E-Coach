import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_e_coach/l10n.dart';

class ActivityTrackingScreen extends StatefulWidget {
  final String activityType;
  final String languageCode;

  const ActivityTrackingScreen({
    super.key,
    required this.activityType,
    required this.languageCode,
  });

  @override
  State<ActivityTrackingScreen> createState() => _ActivityTrackingScreenState();
}

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isPaused = false;

  Duration get _effectiveDuration {
    if (kDebugMode) {
      return _stopwatch.elapsed * 60;
    }
    return _stopwatch.elapsed;
  }

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
    final l10n = AppLabels.languages[widget.languageCode]!;
    _stopwatch.stop();
    setState(() {
      _isPaused = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.intensityTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.intensityQuestion),
            const SizedBox(height: 20),
            _intensityItem(l10n.intensityEasy, 0.8, Colors.green, Icons.spa),
            const SizedBox(height: 10),
            _intensityItem(l10n.intensityMedium, 1.0, Colors.amber, Icons.directions_run),
            const SizedBox(height: 10),
            _intensityItem(l10n.intensityHard, 1.3, Colors.red, Icons.whatshot),
          ],
        ),
      ),
    );
  }

  Widget _intensityItem(String label, double multiplier, Color color, IconData icon) {
    return InkWell(
      onTap: () {
        final calories = _calculateCalories(multiplier);
        Navigator.pop(context); // Close dialog
        Navigator.pop(context, {
          'calories': calories,
          'duration': _effectiveDuration,
          'type': widget.activityType,
          'intensity': label,
        }); // Return detailed map to dashboard
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 15),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  int _calculateCalories(double intensityMultiplier) {
    final l10n = AppLabels.languages[widget.languageCode]!;
    // Base kcal/min per activity type
    double baseKcalPerMin;
    if (widget.activityType == l10n.walking) {
      baseKcalPerMin = 4.0;
    } else if (widget.activityType == l10n.running) {
      baseKcalPerMin = 11.0;
    } else if (widget.activityType == l10n.cycling) {
      baseKcalPerMin = 8.0;
    } else {
      baseKcalPerMin = 6.0;
    }

    double minutes = _effectiveDuration.inSeconds / 60.0;
    return (baseKcalPerMin * intensityMultiplier * minutes).round();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLabels.languages[widget.languageCode]!;
    final duration = _effectiveDuration;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        title: Text(l10n.activityInProgress),
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
              Text(
                l10n.elapsedTime,
                style: const TextStyle(
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
                      _isPaused ? l10n.resume : l10n.pause,
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
                    child: Text(
                      l10n.stop,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
