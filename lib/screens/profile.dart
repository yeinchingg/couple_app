import "package:flutter/material.dart";
import 'package:couple_app/theme/text_styles.dart';
import 'package:couple_app/theme/color_styles.dart';
import 'package:couple_app/chat/chat_page.dart';
import 'package:couple_app/ widgets/navigate.dart';
import 'package:couple_app/screens/calendar.dart';
import 'package:couple_app/screens/photo.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  int _count = 0;

    void _onItemTapped(int index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => CalendarMemoPage()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) =>ProfilePage() ),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => PhotoWallPage()),
          );
          break;
      }
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        appBar: AppBar(
          title: Center(
            child: Text(
              'couple app ',
              textAlign: TextAlign.center,
              style: bodyStyle,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.chat_bubble_outline, color: AppColors.Dgreen),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text("XXX Day ", style: headingStyle),
            SizedBox(height: 40),

            Row(
              children: [
                InkWell(
                  onTap: () => setState(() => _count++),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'lib/assets/flower.gif', // 確保這張圖在 pubspec.yaml 有註冊
                      width: 300,
                      height: 550,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ),
                SizedBox(width: 8),
                Text(" +$_count !", style: bodyStyle),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      );
    }
  }
