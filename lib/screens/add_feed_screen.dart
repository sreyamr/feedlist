import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddFeedScreen extends StatefulWidget {
  @override
  _AddFeedScreenState createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? _video;
  TextEditingController _descriptionController = TextEditingController();


  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }
  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = pickedFile;
      });
    }
  }

  void _saveFeed() {
    String description = _descriptionController.text;
    print('Description: $description');
    print('Image Path: ${_image?.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Feed'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildChooseVideo(),
              const SizedBox(height: 20,),
              buildChooseImage(),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFeed,
                child: const Text('Save Feed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildChooseImage(){
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: _image == null
            ? const Center(child: Text("Add a Thumbnail"))
            : Image.file(
          File(_image!.path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget buildChooseVideo(){
    return GestureDetector(
      onTap: _pickVideo,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: _video == null
            ? const Center(child: Text('Select a video from Gallery'))
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'Video Selected',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

