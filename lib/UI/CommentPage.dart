import 'package:Newsroom/Model/CommentsModel.dart';
import 'package:Newsroom/Service/CommentService.dart';
import 'package:Newsroom/UI/AddCommentPage.dart';
import 'package:Newsroom/UI/CommentDetail.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import 'UpdateCommentPage.dart';

class CommentPage extends StatefulWidget {
  final int articleId;

  CommentPage({@required this.articleId});
  @override
  _CommentPageState createState() => _CommentPageState(articleId: articleId);
}

class _CommentPageState extends State<CommentPage> {
  int articleId;
  _CommentPageState({@required this.articleId});

  List<GetCommentModel> comments = List();
  List<GetCommentModel> filterComments = List();
  CommentService _commentService = CommentService();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() async {
    _commentService.getComments().then((commentFromServer) {
      setState(() {
        comments = commentFromServer;
        filterComments =
            comments.where((u) => (u.articleId) == articleId).toList();
      });
    });
  }

  void showCommentModalSheet(
      String authorId, int id, BuildContext context) async {
    String userId = await storage.read(key: "userId");
    showModalBottomSheet(
        context: context,
        builder: (context) {
          if (authorId == userId) {
            return Container(
              color: Color(0xFF737373),
              height: 130,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => UpdateComment(
                                      commentId: id,
                                    )))
                            .then((_) => _fetchComments());
                      },
                      leading: FaIcon(
                        FontAwesomeIcons.pen,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: Text('Edit Comment',
                          style: TextStyle(color: Colors.black)),
                    ),
                    ListTile(
                      onTap: () async {
                        await _commentService
                            .deleteComment(id)
                            .then((_) => _fetchComments());
                        Navigator.of(context).pop();
                      },
                      leading: FaIcon(
                        FontAwesomeIcons.trash,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: Text(
                        'Delete Comment',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.flag,
                    color: Colors.black,
                    size: 18,
                  ),
                  title: Text("Report"),
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Comments",
          style: TextStyle(
            fontFamily: 'OpenSans',
            color: Colors.black,
          ),
        ),
      ),
      body: filterComments.isEmpty
          ? Center(
              child: Text("No Comments"),
            )
          : Builder(
              builder: (BuildContext context) {
                return ListView(
                  children: filterComments
                      .map(
                        (GetCommentModel comment) => Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromRGBO(230, 230, 230, 0.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS5LGSA_ar1nJAEJYCVNxoW77y4z-HGl0Yfug&usqp=CAU"),
                                ),
                                title: Text(
                                  comment.author.userName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  comment.author.profession,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.ellipsisV,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => showCommentModalSheet(
                                      comment.uid, comment.id, context),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CommentDetail(
                                      commentId: comment.id,
                                      commentContent: comment.content,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    comment.content,
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, bottom: 20.0),
                                child: Text(
                                  "0 Answers".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade600),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.red.shade600,
        label: Text("write a comment"),
        icon: FaIcon(FontAwesomeIcons.pen, size: 18),
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => AddComment(
                  articleId: articleId,
                ),
              ),
            )
            .then((_) => _fetchComments()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
