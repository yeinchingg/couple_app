import 'dart:io';
import 'package:couple_app/theme/text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:couple_app/screens/profile.dart';
import 'package:couple_app/screens/calendar.dart';
import 'package:couple_app/widgets/navigate.dart';

class PhotoWallPage extends StatefulWidget {
    const PhotoWallPage({super.key});

    @override
    State<PhotoWallPage> createState() => _PhotoWallPageState();
}

class _PhotoWallPageState extends State<PhotoWallPage> {
    final List<File> _photos = [];
    int _selectedIndex = 0;
    Future<void> _pickImage() async {
        final picker = ImagePicker();
        final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

        if (pickedImage != null) {
            setState(() {
                _photos.add(File(pickedImage.path));
            });
        }
    }

    void _onItemTapped(int index) {
        switch (index) {
            case 0:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CalendarMemoPage()),
                );
                break;
            case 1:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
                break;
            case 2:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const PhotoWallPage()),
                );
                break;
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Photo Wall', style: headingStyle),
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const ProfilePage()),
                        );
                    },
                ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: _photos.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                                _photos[index],
                                fit: BoxFit.cover,
                            ),
                        );
                    },
                ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: _pickImage,
                child: const Icon(Icons.add),
            ),
            bottomNavigationBar: CustomNavigationBar(
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
            ),
        );
    }
}
