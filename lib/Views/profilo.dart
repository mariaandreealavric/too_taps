import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controllers/profile_controller.dart';
import '../widgets/navigazione/navigazione.dart'; // Importa NavigationHome
import '../controllers/theme_controller.dart';
import 'challenge.dart';

class ProfilePage extends StatefulWidget {
  final String userID;

  const ProfilePage({super.key, required this.userID});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  final ProfileController profileController = Get.put(ProfileController());
  final ThemeController themeController = Get.find<ThemeController>();
  File? _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.setMockProfile(widget.userID);
      _nameController.text = profileController.profile.value?.displayName ?? '';
      _emailController.text = profileController.profile.value?.email ?? '';

    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Profilo', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit, color: Colors.white),
            onPressed: () async {
              if (_isEditing) {
                final profileData = profileController.profile.value;
                if (profileData != null) {
                  profileController.updateProfile(profileData.copyWith(displayName: _nameController.text));
                }
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: themeController.boxDecoration,
          ),
          Positioned.fill(
            child: Obx(() {
              if (profileController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final profileData = profileController.profile.value;
              if (profileData == null) {
                return const Center(child: Text('Profilo non trovato', style: TextStyle(color: Colors.white)));
              }
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  SizedBox(height: 100),
                  GestureDetector(
                    onTap: _isEditing ? _pickImage : null,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : NetworkImage(profileData.photoUrl ?? '') as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    enabled: _isEditing,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    enabled: _isEditing,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Touches: ${profileData.touches ?? 0}', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ChallengePage(userID: widget.userID));
                    },
                    child: const Text('Visualizza Sfide'),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              final profileData = profileController.profile.value;
              if (profileData != null) {
                return Navigation(profile: profileData);
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }
}
