import 'package:easy_localization/easy_localization.dart';

import '../../../config/themes/text_manager.dart';
import '../error_handler_service.dart';
import '../failures.dart';
import 'api_response_codes.dart';

class ConnectionTimeOutErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      statusCode: APIResponseCodes.connectTimeout,
      message: TextManager.connectTimeout.tr(),
    );
  }
}

class SendTimeOutErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return  ServerFailure(
      statusCode: APIResponseCodes.sendTimeout,
      message: TextManager.sendTimeout.tr(),
    );
  }
}

class ReceiveTimeOutErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return  ServerFailure(
      statusCode: APIResponseCodes.receiveTimeout,
      message: TextManager.receiveTimeout.tr(),
    );
  }
}

class CancelErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return  ServerFailure(
      statusCode: APIResponseCodes.cancel,
      message: TextManager.cancelMessage..tr(),
    );
  }
}

class BadCertificateErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return  ServerFailure(
      statusCode: APIResponseCodes.badRequest,
      message: TextManager.badRequest.tr(),
    );
  }
}

class UnknownErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return  ServerFailure(
      statusCode: APIResponseCodes.unknown,
      message: TextManager.unknown.tr(),
    );
  }
}
