abstract class AbstractRepository {
  Future<String> signUp(String login, String password);
  Future<String> signIn(String login, String password);
  Future<void> downloadData();
  Future<void> uploadData();
}