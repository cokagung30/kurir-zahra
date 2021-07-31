part of 'shared.dart';

class PasswordVisibility with ChangeNotifier {
  bool _isHidden = true;

  bool get isHidden => _isHidden;
  set isHidden(bool value) {
    _isHidden = value;
    notifyListeners();
  }
}
