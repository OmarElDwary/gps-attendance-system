// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/leave_model.dart';
//
// class LeaveService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> applyLeave(LeaveModel leave) async {
//     try {
//       await _firestore
//           .collection('users')
//           .doc(leave.userId)
//           .collection('leaves')
//           .doc(leave.id)
//           .set(leave.toMap());
//       print("Leave Applied Successfully");
//     } catch (e) {
//       print("Error applying leave: $e");
//     }
//   }
// }
