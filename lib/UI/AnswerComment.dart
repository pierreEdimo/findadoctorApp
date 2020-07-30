import 'package:Newsroom/Model/Answer.dart';

import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/Service/CommentService.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class AnsWerComment extends StatefulWidget {
  final commentId;

  AnsWerComment({@required this.commentId});

  @override
  _AnsWerCommentState createState() => _AnsWerCommentState();
}

class _AnsWerCommentState extends State<AnsWerComment> {
  final TextEditingController _contentController = TextEditingController();

  CommentService _commentService = CommentService();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: _authService.fethSingleUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return _buildTextField();
          }
          return Text("");
        },
      ),
      floatingActionButton: new FloatingActionButton.extended(
          backgroundColor: Colors.red.shade600,
          label: Text("post"),
          onPressed: () async {
            var uid = await storage.read(key: "userId");
            AnsWer ansWer = AnsWer(
                commentId: widget.commentId,
                uid: uid,
                content: _contentController.text);

            var res = await _commentService.ansWerComment(ansWer);
            if (res == 201) {
              Navigator.of(context).pop();
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTextField() {
    final maxLines = 26;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: maxLines * 24.0,
        child: TextField(
          controller: _contentController,
          maxLines: maxLines,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Reply",
              fillColor: Colors.white,
              filled: true),
        ),
      ),
    );
  }
}