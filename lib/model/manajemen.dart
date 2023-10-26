class manajemen {
  int? id;
  String? judul;
  String? deskripsi;
  String? tenggat_waktu;
  String? catatan_tambahan;

  manajemen({this.id, this.judul, this.deskripsi, this.tenggat_waktu, this.catatan_tambahan});

  factory manajemen.fromJson(Map<String, dynamic> obj){
    return manajemen(
      id: int.parse((obj['data'] as Map)['id']),
      judul: (obj['data'] as Map)['judul'],
      deskripsi: (obj['data'] as Map)['deskripsi'],
      tenggat_waktu: (obj['data'] as Map)['tenggat_waktu'],
      catatan_tambahan: (obj['data'] as Map)['catatan_tambahan'],
    );
  }

}