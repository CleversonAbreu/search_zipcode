abstract class Failure {}

class ServerFailure implements Failure {
  final String? message;

  ServerFailure({this.message});
}

class ZipcodeFailure implements Failure {
  final String? message;

  ZipcodeFailure({this.message});
}

class NetworkFailure implements Failure {}
