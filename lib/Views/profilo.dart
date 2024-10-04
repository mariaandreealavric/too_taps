import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controllers/profile_controller.dart';
import '../widgets/navigazione/navigazione.dart'; // Importa NavigationHome
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
  final ProfileController profileController = Get.put(ProfileController());
  File? _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.setMockProfile(widget.userID);
      _nameController.text = profileController.profile.value?.displayName ?? '';
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
      appBar: AppBar(
        title: const Text('Profilo'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
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
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final profileData = profileController.profile.value;
        if (profileData == null) {
          return const Center(child: Text('Profilo non trovato'));
        }
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
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
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text('Email: ${profileData.email ?? ''}'),
            const SizedBox(height: 20),
            Text('Touches: ${profileData.touches ?? 0}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ChallengePage(userID: widget.userID));
              },
              child: const Text('Visualizza Sfide'),
            ),
            const SizedBox(height: 20),
            // Aggiungi NavigationHome con il profilo
            Navigation(profile: profileData), // Passa il profilo al widget NavigationHome
          ],
        );
      }),
    );
  }
}
