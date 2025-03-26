import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/device_info_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  final _deviceInfoService = DeviceInfoService();
  Map<String, dynamic> _deviceInfo = {};

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _profilePictureUrl = '';
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchDeviceInfo();
  }

  void _loadUserData() {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _emailController.text = user.email ?? '';
        _nameController.text = user.displayName ?? '';
        _profilePictureUrl = user.photoURL ?? '';
      });
    }
  }

  Future<void> _fetchDeviceInfo() async {
    final deviceInfo = await _deviceInfoService.getDeviceInfo();
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _updateProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updateDisplayName(_nameController.text);
        if (_emailController.text.isNotEmpty &&
            _emailController.text != user.email) {
          await user.verifyBeforeUpdateEmail(_emailController.text.trim());
        }
        if (_profilePictureUrl.isNotEmpty) {
          await user.updatePhotoURL(_profilePictureUrl);
        }
        await user.reload();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile Updated Successfully')),
        );
        setState(() {});
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profilePictureUrl = image.path);
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue.shade100,
              backgroundImage: _profilePictureUrl.isNotEmpty
                  ? _profilePictureUrl.contains('cache')
                      ? FileImage(File(_profilePictureUrl))
                      : NetworkImage(_profilePictureUrl)
                  : null,
              child: _profilePictureUrl.isEmpty
                  ? Icon(Icons.person, size: 80, color: Colors.blue)
                  : null,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Change Profile Picture'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
            SizedBox(height: 20),
            Text(
              'Device Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ..._deviceInfo.entries.map((entry) =>
                ListTile(
                  title: Text(entry.key),
                  subtitle: Text(entry.value.toString()),
                )
            ).toList(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
