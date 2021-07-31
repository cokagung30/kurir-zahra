part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signIn(String email, String password,
      {http.Client? client}) async {
    UserLocalTable userLocalTable = UserLocalTable();
    if (client == null) {
      client = http.Client();
    }

    Uri url = Uri.parse(baseURL + "login-kurir");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            <String, String>{'email_kurir': email, 'password': password}));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Login gagal, silahkan coba lagi');
    }
    var data = jsonDecode(response.body);

    User value = User.fromServer(data['data']['kurir']);

    int result = await userLocalTable.insert(User(
        id: value.id,
        namaKurir: value.namaKurir,
        emailKurir: value.emailKurir,
        noTelp: value.noTelp,
        noWa: value.noWa,
        alamat: value.alamat,
        fotoKurir: value.fotoKurir,
        token: data['data']['access_token']));

    if (result < 0) {
      return ApiReturnValue(message: 'Login gagal, silahkan coba lagi');
    }

    return ApiReturnValue(value: value);
  }

  static Future<bool> update(User user, {http.Client? client}) async {
    client ??= http.Client();

    UserLocalTable userLocalTable = UserLocalTable();

    Uri url = Uri.parse(baseURL + "kurir/${user.id}");
    var response = await client.put(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer ${user.token}"
      },
      body: jsonEncode(
        <String, dynamic>{
          'email_kurir': user.emailKurir,
          'nama_kurir': user.namaKurir,
          'no_telp': user.noTelp,
          'no_wa': user.noWa,
          'alamat': user.alamat
        },
      ),
    );
    print(response.body);
    if (response.statusCode != 200) {
      return false;
    }

    var data = jsonDecode(response.body);
    if (data['meta']['status'] == "success") {
      var value = data['data'];
      User newUser = User(
        id: user.id,
        namaKurir: value['nama_kurir'],
        emailKurir: value['email_kurir'],
        noTelp: value['no_telp'],
        noWa: value['no_wa'],
        alamat: value['alamat'],
        fotoKurir: user.fotoKurir,
        token: user.token,
      );

      int count = await userLocalTable.update(newUser);
      if (count > 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> change(
      String email, String newPassword, String oldPassword,
      {http.Client? client}) async {
    client ??= http.Client();

    UserLocalTable userLocalTable = UserLocalTable();
    User? user = await userLocalTable.getUser();

    Uri url = Uri.parse(baseURL + "kurir/change_password/${user!.id}");
    var response = await client.put(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer ${user.token}"
      },
      body: jsonEncode(
        <String, dynamic>{
          "email_kurir": email,
          "new_password": newPassword,
          "old_password": oldPassword
        },
      ),
    );

    print(response.body);

    if (response.statusCode != 200) {
      return false;
    }

    var data = jsonDecode(response.body);
    if (data['meta']['status'] == "success") {
      int count = await userLocalTable.delete();
      if (count > 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> updatePhotoProfil(File pictureFile, User user,
      {http.MultipartRequest? request}) async {
    UserLocalTable userLocalTable = UserLocalTable();
    var url = Uri.parse(baseURL + "kurir/photo/${user.id}");

    if (request == null) {
      request = http.MultipartRequest("POST", url)
        ..headers["Content-Type"] = "application/json"
        ..headers["Authorization"] = "Bearer ${user.token}";
    }

    var multipartFile =
        await http.MultipartFile.fromPath('file', pictureFile.path);
    request.files.add(multipartFile);

    var response = await request.send();
    String responBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var data = jsonDecode(responBody);

      String imagePath = data['data'][0];
      User updateUser = User(
          id: user.id,
          namaKurir: user.namaKurir,
          emailKurir: user.emailKurir,
          noTelp: user.noTelp,
          noWa: user.noWa,
          token: user.token,
          alamat: user.alamat,
          fotoKurir: imageUrl + "$imagePath");

      int result = await userLocalTable.update(updateUser);
      if (result > 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
