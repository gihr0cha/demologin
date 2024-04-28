import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter your text here',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                Navigator.of(context).pop(); // Close current dialog
                showDialog( // Open new dialog
                  context: context,
                  builder: (BuildContext context) {
                    return SecondDialog();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Enter more data here',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}