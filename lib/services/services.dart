import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kurir_zahra/helper/helper.dart';
import 'package:kurir_zahra/models/models.dart';

part 'user_services.dart';
part 'pesanan_services.dart';

String baseURL = 'https://zahra-os.baliwork.my.id/api/';
String imageUrl = 'https://zahra-os.baliwork.my.id/storage/';
