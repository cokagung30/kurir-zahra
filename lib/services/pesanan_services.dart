part of 'services.dart';

class PesananServices {
  static Future<ApiReturnValue<List<Pesanan>>> getPesanan(
      {http.Client? client}) async {
    UserLocalTable userLocalTable = UserLocalTable();
    PesananLocalTable pesananLocalTable = PesananLocalTable();
    DetailPesananLocalTable detailPesananLocalTable = DetailPesananLocalTable();

    client ??= http.Client();

    User? user = await userLocalTable.getUser();

    if (user != null) {
      Uri url = Uri.parse(baseURL + 'pesanan/kurir/${user.id}');
      var response = await client.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${user.token}',
        HttpHeaders.contentTypeHeader: 'application/json'
      });

      var data = jsonDecode(response.body);
      List<dynamic> list = (data['data'] as Iterable).toList();
      if (data != null) {
        pesananLocalTable.delete();
        detailPesananLocalTable.delete();
        list.forEach((item) {
          List<dynamic> details = item['details'];
          Pesanan pesanan = Pesanan(
              id: item['id'],
              noPesanan: item['no_pesanan'],
              pelangganId: item['pelanggan_id'],
              namaPelanggan: item['pelanggan']['nama_pelanggan'],
              noTelpPelanggan: item['pelanggan']['no_telp'],
              fotoPelanggan: item['pelanggan']['foto_profile'],
              tglPemesanan: item['tgl_pemesanan'],
              tglPengiriman: item['tgl_pengiriman'],
              alamatPengiriman: item['alamat_pengiriman'],
              status: item['status'],
              qty: int.parse(item['qty']),
              totalBayar: item['total_bayar'],
              biayaAntar: item['biaya_antar']);

          details.forEach((item) {
            DetailPesanan detail = DetailPesanan(
                id: item['id'],
                pesananId: item['pesanan_id'],
                produkId: item['produk_id'],
                quantity: item['quantity'],
                namaProduk: item['produk']['nama_produk'],
                fotoProduk: item['produk']['foto_produk'],
                deskripsi: item['produk']['deskripsi'],
                hargaJual: item['produk']['harga_jual']);
            detailPesananLocalTable.insert(detail);
          });

          pesananLocalTable.insert(pesanan);
        });

        List<Pesanan> dataPesanan = await pesananLocalTable.select();
        return ApiReturnValue(value: dataPesanan);
      } else {
        return ApiReturnValue(message: 'Data pengiriman tidak ditemukan !!!');
      }
    } else {
      return ApiReturnValue(message: 'Data user kosong');
    }
  }

  static Future<bool> finishTransaction(File file, int pesananId,
      {http.MultipartRequest? request}) async {
    UserLocalTable userLocalTable = UserLocalTable();
    User? user = await userLocalTable.getUser();
    var url = Uri.parse(baseURL + 'pesanan/finish/$pesananId');
    if (request == null) {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
      String formattedDate = formatter.format(now);

      request = http.MultipartRequest("POST", url)
        ..headers["Content-Type"] = "appliation/json"
        ..headers["Authorization"] = "Bearer ${user!.token}";
      request.fields['tgl_pengiriman'] = formattedDate;
    }

    var multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);

    var response = await request.send();
    await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
