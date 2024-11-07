import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user_model.dart';

abstract class AbstractUserService {
  Stream<QuerySnapshot<Map<String, dynamic>>> userTransactionStream(String uid);

  Future<List<UserModel>> getAllUsers();

  Future<Map<String, dynamic>> getUserOrderStatistic(String userId);

  Future<int> getUserTotalOrder(String userId);

  Future<int> getUserCompleteOrder(String userId);

  Future<int> getUserCancelOrder(String userId);

  Future<UserLiteModel> getUserLiteModel(String userId);
}
