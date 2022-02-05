import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.isMe,
    required this.userName,
    required this.imgUrl,
    required this.msgTime,
  });

  final bool isMe;
  final String message;
  final String userName;
  final String imgUrl;
  final DateTime msgTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe) _userImage(context),
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65),
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColor : Colors.grey[400],
            borderRadius: BorderRadius.only(
              bottomLeft:
                  isMe ? const Radius.circular(20) : const Radius.circular(0),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(20),
              topRight: const Radius.circular(20),
              topLeft: const Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 0.5,
                offset: Offset.fromDirection(90),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 60),
                      child: Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  Padding(
                    padding: !isMe
                        ? const EdgeInsets.only(bottom: 10, left: 10, right: 60)
                        : const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 60),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 5,
                right: 10,
                child: Text(
                  DateFormat('hh:mm a').format(msgTime),
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isMe) _userImage(context),
      ],
    );
  }

  Padding _userImage(BuildContext context) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(right: 5)
          : const EdgeInsets.only(left: 5),
      child: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
        backgroundColor:
            isMe ? Theme.of(context).primaryColor : Colors.grey[400],
        radius: MediaQuery.of(context).size.width * 0.04,
      ),
    );
  }
}
