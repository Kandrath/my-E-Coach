import 'package:flutter/material.dart';
import 'package:my_e_coach/screens/dashboard_screen.dart';
import 'package:my_e_coach/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  // Global State
  String _name = 'Alexandre';
  int _age = 28;
  String _gender = 'Homme';
  double _height = 180.0;
  double _weight = 75.0;
  
  int _calories = 0;
  int _water = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _updateProfile(String name, int age, String gender, double height, double weight) {
    setState(() {
      _name = name;
      _age = age;
      _gender = gender;
      _height = height;
      _weight = weight;
    });
  }

  void _updateCalories(int amount) {
    setState(() {
      _calories += amount;
    });
  }

  void _updateWater(int amount) {
    setState(() {
      _water += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          DashboardScreen(
            userName: _name,
            calories: _calories,
            water: _water,
            onAddWater: _updateWater,
            onAddCalories: _updateCalories,
          ),
          ProfileScreen(
            name: _name,
            age: _age,
            gender: _gender,
            height: _height,
            weight: _weight,
            onSave: _updateProfile,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Tableau de bord',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFA2B997),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
