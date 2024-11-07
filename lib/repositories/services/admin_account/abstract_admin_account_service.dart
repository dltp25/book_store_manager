abstract class AbtractAdminAccountService {
  Future<bool> checkIsAdminUsingId(String uid);
  Future<bool> checkIsAdminUsingEmail(String email);
}
