import 'package:flutter/material.dart';

import '../../Repositories/userRepo.dart';


class Review {
  final String user;
  final double rating;
  final String review;

  Review(this.user, this.rating, this.review);
}

class RatingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings & Reviews'),
      ),
      body: StreamBuilder(
        stream: fireStore.collection('reviews').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final reviews = snapshot.data!.docs;
          List<Review> reviewList = [];

          for (var review in reviews) {
            final String user = review['user_id'];
            final double rating = review['rating'];
            final String reviewText = review['review'];

            reviewList.add(Review(user, rating, reviewText));
          }

          return ListView.builder(
            itemCount: reviewList.length,
            itemBuilder: (context, index) {
              final review = reviewList[index];
              return Column(
                children:[
                  ListTile(
                    title: Text('Rating: ${review.rating}',style: TextStyle(fontSize: 20),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Review: ${review.review}',style: TextStyle(fontSize: 20),),
                        FutureBuilder<String>(
                          future: _getUserEmail(review.user),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text('Loading...');
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            return Text('User Email: ${snapshot.data}',style: TextStyle(fontSize: 18),);
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2,)
                ]
              );
            },
          );
        },
      ),
    );
  }

  Future<String> _getUserEmail(String userId) async {
    final userDoc = await fireStore.collection('users').doc(userId).get();
    return userDoc['email'];
  }
}

