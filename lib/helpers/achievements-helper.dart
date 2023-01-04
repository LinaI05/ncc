import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> updateAchievement(String achieveName) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    achieveName: true,
  });
}

Future<void> getUserAchievements() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref();
  final User? user = auth.currentUser;
  final uid = user?.uid;

  final snapshot = await ref.child('users/$uid').get();
  if (snapshot.exists) {
    return;
  } else {
    DatabaseReference userRef = FirebaseDatabase.instance.ref("users/$uid");
    await userRef.set({
      "3goals": false,
      "coping-plan": false,
      "journaling": false,
    });
    return;
  }
}
