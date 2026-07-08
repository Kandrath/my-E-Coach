import 'package:flutter/material.dart';
import 'package:my_e_coach/screens/activity_tracking_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _calories = 0;
  int _water = 0; // en ml

  void _addWater(int amount) {
    setState(() {
      _water += amount;
    });
  }

  void _showActivityOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choisir une activité',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _activityOption('Marche', Icons.directions_walk),
                  _activityOption('Course', Icons.directions_run),
                  _activityOption('Vélo', Icons.directions_bike),
                  _activityOption('Autre', Icons.fitness_center),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _activityOption(String label, IconData icon) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            Navigator.pop(context);
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityTrackingScreen(activityType: label),
              ),
            );

            if (result != null && result is Map<String, dynamic>) {
              setState(() {
                _calories += (result['calories'] as int);
              });
              _showActivitySynthesis(result);
            }
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFA2B997), width: 2),
            ),
            child: Icon(icon, color: const Color(0xFFA2B997), size: 35),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF2C3E50)),
        ),
      ],
    );
  }

  void _showActivitySynthesis(Map<String, dynamic> sessionData) {
    final duration = sessionData['duration'] as Duration;
    final calories = sessionData['calories'] as int;
    final type = sessionData['type'] as String;

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String formattedDuration =
        "${twoDigits(duration.inMinutes.remainder(60))}m ${twoDigits(duration.inSeconds.remainder(60))}s";
    if (duration.inHours > 0) {
      formattedDuration = "${duration.inHours}h $formattedDuration";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Bravo Alexandre ! ✨',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Quelle superbe séance ! Vous progressez vers vos objectifs.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF7F8C8D)),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF9F6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _synthesisRow('Activité', type),
                  const Divider(),
                  _synthesisRow('Durée', formattedDuration),
                  const Divider(),
                  _synthesisRow('Dépense', '$calories kcal'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA2B997),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('CONTINUER'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _synthesisRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF7F8C8D))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // En-tête
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bonjour, Alexandre ✨',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Prenez soin de vous aujourd'hui.",
                    style: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
                  ),
                ],
              ),

              // Module Calories (Cercle Zen)
              Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFA2B997),
                      width: 6,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_calories',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const Text(
                        'kcal dépensées',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7F8C8D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Module Hydratation
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Hydratation : ${(_water / 1000.0).toStringAsFixed(2)}L / 2.5L',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: TextButton(
                        onPressed: () => _addWater(200),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFE3F2FD),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          '+ 200ml 💧',
                          style: TextStyle(
                            color: Color(0xFF1E88E5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bouton Action Principal (CTA)
              ElevatedButton(
                onPressed: _showActivityOptions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA2B997),
                  foregroundColor: Colors.white,
                  shadowColor: const Color(0xFFA2B997),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'DÉMARRER UNE ACTIVITÉ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
