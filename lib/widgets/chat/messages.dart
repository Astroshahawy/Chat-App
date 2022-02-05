import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('sentTime', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemBuilder: (context, index) => MessageBubble(
            message: docs[index]['text'].toString(),
            isMe:
                docs[index]['userId'] == FirebaseAuth.instance.currentUser!.uid,
            userName: docs[index]['username'].toString(),
            imgUrl: docs[index]['userImage'].toString(),
            msgTime: (docs[index]['sentTime'] as Timestamp).toDate(),
          ),
          itemCount: docs.length,
          reverse: true,
        );
      },
    );
  }
}
