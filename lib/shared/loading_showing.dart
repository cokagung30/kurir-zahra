part of 'shared.dart';

class LoadingShowing with ChangeNotifier {
  bool _isShowing = false;

  bool get isShowing => _isShowing;
  set isShowing(bool value) {
    _isShowing = value;
    notifyListeners();
  }
}
