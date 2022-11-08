import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
User? currentFirebaseUser;
// UsersModel? currentUserInfo;

var data =
    fireStore.collection("available_drivers").doc(currentFirebaseUser!.uid);

// final geo = Geoflutterfire();

StreamSubscription<Position>? homeTabPageStreamSubscription;

Stream<List<DocumentSnapshot>>? stream;

// List<NearByAvailDrivers> listNearDrivers = [];

List<String> tokenList = [];
