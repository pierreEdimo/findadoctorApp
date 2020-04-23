import 'package:findadoctor/Model/DoctorModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetails extends StatelessWidget {
  final Doctor doctor;

  DoctorDetails({Key key, @required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          color: Colors.black,
          iconSize: 18,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Dr. med ${doctor.name}",
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            child: ClipRRect(
              child: Image.network(
                "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            child: Container(
              color: Color.fromRGBO(246, 246, 246, 0.9),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          doctor.specialisation,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "${doctor.location},",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "${doctor.poBox}, ${doctor.city}, ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          doctor.country,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text("Tel: ${doctor.number}",
                            style: TextStyle(fontSize: 20.0)),
                        Text("Email: ${doctor.email}",
                            style: TextStyle(fontSize: 20.0)),
                        Text("Von: ${doctor.opening}",
                            style: TextStyle(fontSize: 20.0)),
                        Text("bis: ${doctor.closing}",
                            style: TextStyle(fontSize: 20.0))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            child: Container(
              color: Color.fromRGBO(246, 246, 246, 0.9),
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Bio: ${doctor.description}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Hello World"),
        child: FaIcon(FontAwesomeIcons.commentAlt),
        backgroundColor: Colors.black,
      ),
    );
  }
}
