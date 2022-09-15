// ignore_for_file: file_names

abstract class BaseAPIConfig {
  Future<Map?> getAPI({
    String authorization,
    String url,
  });
}
