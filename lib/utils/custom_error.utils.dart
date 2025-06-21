class CustomErrorUtilsException implements Exception {

  final String message;
  const CustomErrorUtilsException([this.message = '']);

  @override
  String toString() => message;
}