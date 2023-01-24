import 'package:chat_app/pages/pages.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:chat_app/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];
  final pageTitle = const ['Messages', 'Notifications', 'Calls', 'Contacts'];
  void _onNavigationItemSelected(index) {
    pageIndex.value = index;
    title.value = pageTitle[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, _) {
              return Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            },
          ),
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: Icons.search,
              onTap: () {
                print('To do search');
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Avatar.small(
                url: Helpers.randomPictureUrl(),
              ),
            )
          ],
        ),
        body: ValueListenableBuilder(
          builder: (BuildContext context, int value, _) {
            return pages[value];
          },
          valueListenable: pageIndex,
        ),
        bottomNavigationBar:
            BottomNavigationBar(onItemSelected: _onNavigationItemSelected));
  }
}

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationBarItem(
              label: 'messaging',
              icon: CupertinoIcons.bubble_left_bubble_right_fill,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            _NavigationBarItem(
                label: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                index: 1,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 1)),
            _NavigationBarItem(
                label: 'Calls',
                icon: CupertinoIcons.phone_fill,
                index: 2,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 2)),
            _NavigationBarItem(
                label: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                index: 3,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 3)),
          ],
        ));
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.label,
    required this.index,
    this.isSelected = false,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final ValueChanged<int> onTap;
  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary)
                  : const TextStyle(
                      fontSize: 11,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
