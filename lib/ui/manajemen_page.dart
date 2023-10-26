import 'package:flutter/material.dart';
import 'package:responsi/bloc/manajemen_bloc.dart';
import 'package:responsi/model/manajemen.dart';
import 'package:responsi/ui/manajemen_detail.dart';
import 'package:responsi/ui/manajemen_form.dart';
import 'package:responsi/widget/success_dialog.dart';

class ManajemenPage extends StatefulWidget {
  const ManajemenPage({Key? key}) : super(key: key);

  @override
  _manajemenPageState createState() => _manajemenPageState();
}

class _manajemenPageState extends State<ManajemenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas-Tugas'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => manajemenForm()));
                },
              ))
        ],
      ),
      body: FutureBuilder<List>(
        future: ManajemenBloc.getManajemen(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? listmanajemen(
            list: snapshot.data,
          )
              : const Center(
                child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class listmanajemen extends StatelessWidget {
  final List? list;
  const listmanajemen({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemManajemen(
            Manajemen: list![i],
          );
        });
  }
}

class ItemManajemen extends StatelessWidget {
  final manajemen Manajemen;

  const ItemManajemen({Key? key, required this.Manajemen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ManajemenDetail(
                  Manajemen: Manajemen,
                )));
      },
      child: Card(
        child: ListTile(
          title: Text(Manajemen.judul!),
          subtitle: Text(Manajemen.deskripsi!),
        ),
      ),
    );
  }
}