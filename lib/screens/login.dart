import 'package:flutter/material.dart';
import 'package:couple_app/theme/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login", style: headingStyle),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 16),
                SizedBox(
                  width: 130,
                  height: 40,
                  child: Text(
                    "名字",
                    style: bodyStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 230,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 16),
                SizedBox(
                  width: 130,
                  height: 40,
                  child: Text(
                    "電子信箱",
                    style: bodyStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 230,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {},
              child: Text("送出", style: bodyStyle),
            ),
          ],
        ),
      ),
    );
  }
}
