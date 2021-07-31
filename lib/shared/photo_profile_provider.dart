part of 'shared.dart';

class PhotoProfileProvider with ChangeNotifier {
  String _photoProfile = '';

  String get photoProfile => _photoProfile;
  set photoProfile(String value) {
    _photoProfile = value;
    notifyListeners();
  }
}
