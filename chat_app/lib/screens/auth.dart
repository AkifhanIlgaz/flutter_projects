import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _isAuthenticating = false;
  late String _enteredEmail;
  late String _enteredPassword;
  late String _enteredUsername;
  File? _pickedImage;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    // Show error messages
    if (!isValid || (!_isLogin && _pickedImage == null)) return;

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
          
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child("user_images")
            .child("${userCredentials.user!.uid}.jpg");

        await storageRef.putFile(
            _pickedImage!, SettableMetadata(contentType: "image/jpg"));

        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set(
          {
            "username": _enteredUsername,
            "email": _enteredEmail,
            "image_url": imageUrl,
          },
        );
      }
    } on FirebaseAuthException catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? "Authentication failed."),
        ),
      );

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void _onImagePicked(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset("assets/images/chat.png"),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onImagePicked: _onImagePicked,
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Email Address",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains("@")) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (email) {
                              _enteredEmail = email!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Username",
                              ),
                              keyboardType: TextInputType.text,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 4) {
                                  return "Please enter a valid username (at least 4 characters)";
                                }
                                return null;
                              },
                              onSaved: (username) {
                                _enteredUsername = username!;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password must be at least 6 characters long.";
                              }
                              return null;
                            },
                            onSaved: (password) {
                              _enteredPassword = password!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? "Sign In" : "Sign Up"),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? "Don't have an account ?"
                                  : "Already have an account ?"),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
