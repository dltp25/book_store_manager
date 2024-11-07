import 'package:book_store_manager/repositories/services/user/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import 'services/user/abstract_user_service.dart';

class UserRepository {
  late AbstractUserService _userService;

  UserRepository() {
    _userService = UserService();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userTransactionStream(
      String uid) {
    return _userService.userTransactionStream(uid);
  }

  Future<List<UserModel>> getAllUsers() async {
    return _userService.getAllUsers();
  }

  Future<Map<String, dynamic>> getUserOrderStatistic(String userId) async {
    return _userService.getUserOrderStatistic(userId);
  }

  Future<int> getUserTotalOrder(String userId) async {
    return _userService.getUserTotalOrder(userId);
  }

  Future<int> getUserCompleteOrder(String userId) async {
    return _userService.getUserCompleteOrder(userId);
  }

  Future<int> getUserCancelOrder(String userId) async {
    return _userService.getUserCancelOrder(userId);
  }

  Future<UserLiteModel> getUserLiteModel(String userId) async {
    return _userService.getUserLiteModel(userId);
  }
}
