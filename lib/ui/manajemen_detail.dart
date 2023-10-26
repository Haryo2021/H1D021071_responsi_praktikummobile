import 'package:flutter/material.dart';
import 'package:responsi/model/manajemen.dart';
import 'package:responsi/ui/manajemen_form.dart';
import 'package:responsi/ui/manajemen_page.dart';

import '../bloc/manajemen_bloc.dart';

class ManajemenDetail extends StatefulWidget {
  manajemen? Manajemen;
  ManajemenDetail({Key? key, this.Manajemen}) : super(key: key);
  @override
  _ManajemenDetailState createState() => _ManajemenDetailState();
}

class _ManajemenDetailState extends State<ManajemenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas-Tugas'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama Tugas : ${widget.Manajemen!.judul}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Deskripsi : ${widget.Manajemen!.deskripsi}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Deadline : ${widget.Manajemen!.tenggat_waktu}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Catatan : ${widget.Manajemen!.catatan_tambahan}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
//Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => manajemenForm(
                        Manajemen: widget.Manajemen!,
                      )));
            }),
//Tombol Hapus
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
//tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            ManajemenBloc.deletemanajemen(id: widget.Manajemen?.id).then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManajemenPage()));
            });
          },
        ),
//tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}