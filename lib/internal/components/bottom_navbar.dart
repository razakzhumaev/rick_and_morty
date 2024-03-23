import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty_app/features/episodes/presentation/screens/episode_screen.dart';
import 'package:rick_morty_app/features/locations/presentation/screens/location_screen.dart';
import 'package:rick_morty_app/features/persons/presentation/screens/person_screen.dart';
import 'package:rick_morty_app/features/settings/settings_screen.dart';
import 'package:rick_morty_app/generated/l10n.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    PersonScreen(),
    LocationScreen(),
    EpisodeSreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                const Icon(Icons.person_2),
                Text(S.of(context).characters),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                const Icon(Icons.public_sharp),
                Text(S.of(context).locations),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                const Icon(Icons.live_tv_rounded),
                Text(S.of(context).episodes),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Column(
              children: [
                const Icon(Icons.settings),
                Text(S.of(context).settings),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 16.w,
          left: 16.w,
          top: 54.h,
        ),
        child: screens[currentIndex],
      ),
    );
  }
}
