import 'package:clone_mobile_app/screens/calendar_page.dart';
import 'package:clone_mobile_app/screens/chat_page.dart';
import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 3;

  final List<Widget> _pages = [
    const Center(child: Text('Home Page')),
    const CalendarPage(),
    const Center(child: Text("Group Page")),
    const ChatPage(),
    const Center(child: Text('Notifications Page')),
    const Center(child: Text('Profile Page')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.groups_2_outlined),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.fact_check_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: const Text(
                      '99+',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: '',
          ),
        ],
      ),
    );
  }
}
