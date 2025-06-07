import 'package:Barter/presentation/screens/tabs/cart_tab_screen.dart';
import 'package:Barter/presentation/screens/tabs/chat_tab_screen.dart';
import 'package:Barter/presentation/screens/tabs/home_tab_screen.dart';
import 'package:Barter/presentation/screens/tabs/search_screen.dart';
import 'package:Barter/presentation/screens/tabs/profile_tab_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const HomeTabScreen(),
    const SearchScreen(),
    const ChatTabScreen(),
    const CartTabScreen(),
    const ProfileTabScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _selectedIndex == 1 ? null : _buildAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF1E1E1E), const Color(0xFF2A2A2A)],
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                _buildNavItem(Icons.home_rounded, 'Home', 0),
                _buildNavItem(Icons.location_on_rounded, 'Поездки', 1),
                _buildNavItem(Icons.chat_bubble_rounded, 'Чаты', 2),
                _buildNavItem(Icons.payments_rounded, 'Кошелёк', 3),
                _buildNavItem(Icons.person_rounded, 'Профиль', 4),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF00D4AA),
              unselectedItemColor: Colors.grey[400],
              onTap: _onItemTapped,
              selectedFontSize: 12,
              unselectedFontSize: 10,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              _selectedIndex == index
                  ? const Color(0xFF00D4AA).withOpacity(0.1)
                  : Colors.transparent,
        ),
        child: Icon(icon, size: 24),
      ),
      label: label,
    );
  }

  AppBar? _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF0A0A0A),
      title: ShaderMask(
        shaderCallback:
            (bounds) => const LinearGradient(
              colors: [Color(0xFF00D4AA), Color(0xFF00A693)],
            ).createShader(bounds),
        child: const Text(
          '1Jol',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_rounded,
              color: Color(0xFF00D4AA),
              size: 24,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
