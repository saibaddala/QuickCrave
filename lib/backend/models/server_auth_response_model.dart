class ServerAuthResponseModel {
  final bool _isSuccess;
  final String _message;
  ServerAuthResponseModel(this._isSuccess, this._message);
  bool get isSuccess => _isSuccess;
  String get message => _message;
}
