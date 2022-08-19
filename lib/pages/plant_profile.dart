// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planture_app/constants/constants.dart';
import 'package:planture_app/provider/fav_status.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final DocumentSnapshot post;
  Profile({this.post});
  @override
  _ProfileState createState() => _ProfileState();
}

Color color = Color(0XFF82DE3A);

class _ProfileState extends State<Profile> {
  int index;
  @override
  void initState() {
    super.initState();
    Fav provideVal = Provider.of<Fav>(context, listen: false);
    index = provideVal.documentIds.indexOf(widget.post.documentID);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      showOfflineBanner: false,
      builder: (context, isOnline) => Scaffold(
        body: isOnline
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Consumer<Fav>(builder: (context, snapshot, _) {
                  return SafeArea(
                    child: new ListView(children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Carousel(
                              dotBgColor: Colors.transparent,
                              dotColor: Colors.greenAccent,
                              boxFit: BoxFit.cover,
                              images: [
                                NetworkImage(widget.post.data['album'][0]),
                                NetworkImage(widget.post.data['album'][1]),
                                NetworkImage(widget.post.data['album'][2]),
                                NetworkImage(widget.post.data['album'][3]),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 15.0,
                            child: IconButton(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.black),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Positioned(
                            top: 15,
                            right: 15.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: IconButton(
                                  icon: Icon(
                                      snapshot.isFav[index]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.greenAccent,
                                      size: 28),
                                  onPressed: () {
                                    // Navigator.pop(context);
                                    if (snapshot.isFav[index]) {
                                      Provider.of<Fav>(context, listen: false)
                                          .deleteFavStatus(
                                              widget.post.documentID);
                                    } else {
                                      Provider.of<Fav>(context, listen: false)
                                          .getUserandPost(
                                              widget.post.documentID);
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.local_florist,
                                    color: color,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.post.data['plant'],
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.bookmark,
                                    color: color,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.post.data['family'],
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: color,
                                      child: Icon(
                                        Icons.bookmark_border,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Botanical',
                                      style: ktitleProfile,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.post.data['botanical'],
                                    //  textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: color,
                                      child: Icon(
                                        Icons.description,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Description',
                                      style: ktitleProfile,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.post.data['description'],
                                    // textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: color,
                                      child: Icon(
                                        Icons.water_damage_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Soil',
                                      style: ktitleProfile,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.post.data['soil'],
                                    //textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: color,
                                      child: Icon(
                                        Icons.water_damage,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Watering',
                                      style: ktitleProfile,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.post.data['watering'],
                                    //textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  );
                }),
              )
            : Center(
                child: Flexible(
                  child: Image(
                    image: AssetImage('assets/images/offline-icon-6.png'),
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
      ),
    );
  }
}
