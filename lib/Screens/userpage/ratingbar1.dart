import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hertzrentacar/Repositories/userRepo.dart';
import 'package:hertzrentacar/Utils/Widgets/appbar.dart';
import 'package:hertzrentacar/Utils/Widgets/widgetsandvariables.dart';

import 'homepage1.dart';

class RatingScreen1 extends StatefulWidget {
  @override
  _RatingScreen1State createState() => _RatingScreen1State();
}

class _RatingScreen1State extends State<RatingScreen1> {
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();
  Future<void> _onSubmit() async {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        final String uid = user.uid;
        // Save the rating and review along with the user ID in Firestore
        await fireStore.collection('reviews').add({
          'user_id': uid,
          'rating': _rating,
          'review': _reviewController.text,
          'timestamp': DateTime.now(),
        });
      }
      _rating = 0.0;
      _reviewController.text = '';
    } catch (e) {
      print('Error submitting review: $e');
    }
  }

  final sizedbox = SizedBox(
    height: 16,
  );
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            x== 0?  Text("Thanks for your Order !!", style: Variables.bluetextstyle):Text(""),
            sizedbox,
            x == 1
                ? Text(
                    "Rate/Review the Company",
                    style: Variables.blacktextstyle,
                  )
                : Text(
                    "Rate/Review the Vehicle",
                    style: Variables.blacktextstyle,
                  ),
            sizedbox,
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Write your review',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _onSubmit();
                x==1?Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage1()), (route) => false):null;

                setState(() {
                  x = 1;
                });
                // Send the _rating and _reviewController.text to your backend or store it locally
              },
              child: Text('Submit', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
