import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _message = '';
  final _controller = TextEditingController();

  Future _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _message,
      'sentTime': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['img_url'],
    });
    _controller.clear();
    setState(() {
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset.fromDirection(90),
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'Type a message',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Theme.of(context).accentColor,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    _message = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Ink(
            decoration: ShapeDecoration(
              color: _message.trim().isEmpty
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset.fromDirection(90),
                ),
              ],
              shape: const CircleBorder(),
            ),
            child: IconButton(
              onPressed: _message.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(Icons.send),
              color: Colors.white,
              disabledColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
