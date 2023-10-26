import 'dart:convert';

import 'package:responsi/helpers/api.dart';
import 'package:responsi/helpers/api_url.dart';
import 'package:responsi/model/manajemen.dart';

class ManajemenBloc {
  static Future<List<manajemen>> getManajemen() async {
    String apiUrl = ApiUrl.listmanajemen;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listmanajemen = (jsonObj as Map<String, dynamic>)['data'];
    List<manajemen> produks = [];
    for (int i = 0; i < listmanajemen.length; i++) {
      produks.add(manajemen.fromJson(listmanajemen[i]));
    }
    return produks;
  }

  static Future addManajemen({manajemen? manajemen}) async {
    String apiUrl = ApiUrl.createmanajemen;
    var body = {
      "judul": manajemen!.judul,
      "deskripsi": manajemen.deskripsi,
      "tenggat_waktu": manajemen.tenggat_waktu,
      "catatan_tambahan": manajemen.catatan_tambahan
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updatemenajemen({required manajemen manajemen}) async {
    String apiUrl = ApiUrl.updatemanajemen(manajemen.id!);
    var body = {
      "judul": manajemen!.judul,
      "deskripsi": manajemen.deskripsi,
      "tenggat_waktu": manajemen.tenggat_waktu,
      "catatan_tambahan": manajemen.catatan_tambahan
    };
    var response = await Api().put(apiUrl, body);
    var jsonObj = json.decode(response.body);
    print("JsonObj : ${jsonObj['data']}");
    return jsonObj['status'];
  }

  static Future<bool> deletemanajemen({int? id}) async {
    String apiUrl = ApiUrl.deletemanajemen(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}