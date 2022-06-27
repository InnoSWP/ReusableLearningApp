abstract class ITokenStorage {
  Future<String?> getRefreshToken();
  Future<String?> getAccessToken();
  Future setRefreshToken(String? refresh);
  Future setAccessToken(String? access);
}