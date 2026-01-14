import 'app_exceptions.dart';
import 'failure.dart';

class ExceptionHandler {
  static Failure handle(Exception e) {
    try {
      if (e is InternetException) {
        return Failure('No internet connection');
      } else if (e is RequestTimeOut) {
        return Failure('Request timed out');
      } else if (e is ServerException) {
        return Failure('Server error');
      } else if (e is InvalidUrlException) {
        return Failure('Invalid URL');
      } else if (e is FetchDataException) {
        return Failure('Error fetching data');
      } else if (e is ApiErrorException) {
        return Failure(e.message);
      } else if (e is ApiException) {
        return Failure(e.message);
      } else if (e is UnAuthorizedException) {
        return Failure('Unauthorized request');
      } else if (e is InvalidInputException) {
        return Failure('Invalid input');
      } else if (e is NotFoundException) {
        return Failure(e.message);
      } else {
        return Failure('Unexpected error occurred');
      }
    } catch (_) {
      return Failure('Unknown error occurred');
    }
  }
}
