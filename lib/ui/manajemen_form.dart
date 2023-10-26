import 'package:flutter/material.dart';
import 'package:responsi/bloc/manajemen_bloc.dart';
import 'package:responsi/model/manajemen.dart';
import 'package:responsi/ui/manajemen_page.dart';
import 'package:responsi/widget/warning_dialog.dart';

class manajemenForm extends StatefulWidget {
  manajemen? Manajemen;
  manajemenForm({Key? key, this.Manajemen}) : super(key: key);

  @override
  _manajemenFormState createState() => _manajemenFormState();
}

class _manajemenFormState extends State<manajemenForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah tugas-tugas";
  String tombolSubmit = "Simpan Tugas";

  final _judulmanajemenTextboxController = TextEditingController();
  final _deskripsimanajemenTextboxController = TextEditingController();
  final _tenggatwaktumanajemenTextboxController = TextEditingController();
  final _catatanmanajemenTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.Manajemen != null) {
      setState(() {
        judul = "Ubah Tugas";
        tombolSubmit = "UBAH";
        _judulmanajemenTextboxController.text = widget.Manajemen!.judul!;
        _deskripsimanajemenTextboxController.text = widget.Manajemen!.deskripsi!;
        _tenggatwaktumanajemenTextboxController.text = widget.Manajemen!.tenggat_waktu!;
        _catatanmanajemenTextboxController.text = widget.Manajemen!.catatan_tambahan!;
      });
    } else {
      judul = "Tambah Tugas";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _judulManajemenTextField(),
                _deskripsiManajemenTextField(),
                _tenggatwaktuManajemenTextField(),
                _catatanManajemenTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Kode Produk
  Widget _judulManajemenTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul Tugas"),
      keyboardType: TextInputType.text,
      controller: _judulmanajemenTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Judul Tugas harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Nama Produk
  Widget _deskripsiManajemenTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deskripsi"),
      keyboardType: TextInputType.text,
      controller: _deskripsimanajemenTextboxController,
    );
  }

//Membuat Textbox Harga Produk
  Widget _tenggatwaktuManajemenTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Waktu Pengerjaan Tugas"),
      keyboardType: TextInputType.text,
      controller: _tenggatwaktumanajemenTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Waktu pengerjaan";
        }
        return null;
      },
    );
  }

  Widget _catatanManajemenTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Catatan Tugas"),
      keyboardType: TextInputType.text,
      controller: _catatanmanajemenTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Catatan ";
        }
        return null;
      },
    );
  }

//Membuat Tombol Simpan/Ubah
//Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.Manajemen != null) {
                //kondisi update produk
                ubah();
              } else {
//kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    manajemen createmanajemen = manajemen(id: null);
    createmanajemen.judul = _judulmanajemenTextboxController.text;
    createmanajemen.deskripsi = _deskripsimanajemenTextboxController.text;
    createmanajemen.tenggat_waktu = _tenggatwaktumanajemenTextboxController.text;
    createmanajemen.catatan_tambahan = _catatanmanajemenTextboxController.text;

    ManajemenBloc.addManajemen(manajemen: createmanajemen).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ManajemenPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    manajemen updatemanajemen = manajemen(id: null);
    updatemanajemen.id = widget.Manajemen!.id;
    updatemanajemen.judul = _judulmanajemenTextboxController.text;
    updatemanajemen.deskripsi = _deskripsimanajemenTextboxController.text;
    updatemanajemen.tenggat_waktu = _tenggatwaktumanajemenTextboxController.text;
    updatemanajemen.catatan_tambahan = _catatanmanajemenTextboxController.text;
    ManajemenBloc.updatemenajemen(manajemen: updatemanajemen).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ManajemenPage()));
    }, onError: (error){
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}