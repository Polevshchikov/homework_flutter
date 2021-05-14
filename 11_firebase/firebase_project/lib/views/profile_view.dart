import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  static const routName = '/profile';
  ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File _imageFile;
  final _picker = ImagePicker();
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
  User user;
  bool confirm = false;

  @override
  void initState() {
    super.initState();
    inputData();
  }

  void inputData() async {
    user = auth.currentUser;
    User updatedUser = FirebaseAuth.instance.currentUser;

    setState(() {
      user = updatedUser;
    });
  }

  Future<void> _pickImageFromGallery() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        this._imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    saveImage();
  }

  Future<void> _pickImageFromCamera() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        this._imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    saveImage();
  }

  saveImage() async {
    user = FirebaseAuth.instance.currentUser;
    final Reference storageReference = FirebaseStorage.instanceFor()
        .ref()
        .child('users/${user.uid}/avatar.jpg');
    UploadTask upLoadTask = storageReference.putFile(_imageFile);
    String downloadUrl = await (await upLoadTask).ref.getDownloadURL();
    User updateUser = await _authService.updateUser(photoURL: downloadUrl);
  }

  Widget _todoContainer() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              bottomLeft: Radius.circular(50.0),
              topLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
            color: Colors.cyan[300]),
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Мой список заметок - ToDo app',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: 40,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/todo');
      },
    );
  }

  Widget _isVerification() {
    return Column(
      children: [
        if (confirm == true)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Пожалуйста перейдите на указанную почту и подтвердите email, после нажмите кнопку ОК',
              textAlign: TextAlign.center,
            ),
          ),
        confirm == false
            ? ElevatedButton(
                child: Text('Подтвердить email'),
                onPressed: () async {
                  await user.reload();
                  inputData();
                  if (user.emailVerified == false) {
                    user.sendEmailVerification();
                  }
                  setState(() {
                    confirm = true;
                  });
                },
              )
            : ElevatedButton(
                child: Text('ОК'),
                onPressed: () async {
                  await user.reload();
                  inputData();
                  setState(() {
                    confirm = false;
                  });
                },
              )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'My Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _authService.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_camera),
                  onPressed: () async => _pickImageFromCamera(),
                  tooltip: 'Shoot picture',
                ),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () async => _pickImageFromGallery(),
                  tooltip: 'Pick from gallery',
                ),
              ],
            ),
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.black,
              child: ClipOval(
                child: SizedBox(
                  height: 190,
                  width: 190,
                  child: _imageFile == null
                      ? user.photoURL != null
                          ? Image.network(
                              user.photoURL,
                              fit: BoxFit.fill,
                            )
                          : Center(
                              child: Text('No image selected'),
                            )
                      : Image.file(
                          _imageFile,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextButton(
                child: Text(
                  user.displayName == null ? 'UserName' : user.displayName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onPressed: () {
                  //funcrion edit user.displayName
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(user.email),
            ),
            user.emailVerified == true ? _todoContainer() : _isVerification(),
          ],
        ),
      ),
    );
  }
}
