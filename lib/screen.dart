// Man hinh
import 'package:flutter/material.dart';
import 'models.dart';
import 'widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quản lý nhân viên",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButtonMenu(
                label: "Thêm nhân viên",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NhapThongTinNhanVienScreen(),
                  ),
                ),
              ),
              buildButtonMenu(
                label: "Danh sách nhân viên",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DanhSachNhanVienScreen()),
                ),
              ),
              buildButtonMenu(
                label: "Xóa dữ liệu nhân viên",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => XoaNhanVienScreen()),
                ),
              ),
              buildButtonMenu(
                label: "Chỉnh sửa thông tin nhân viên",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TimNhanVienScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NhapThongTinNhanVienScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NhapThongTinNhanVienScreenState();
}

class NhapThongTinNhanVienScreenState
    extends State<NhapThongTinNhanVienScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sbdCtrl = TextEditingController();
  final TextEditingController _hoTenCtrl = TextEditingController();
  final TextEditingController _tuoiCtrl = TextEditingController();
  final TextEditingController _loaiCtrl = TextEditingController();
  final TextEditingController _luongCB = TextEditingController();

  @override
  void dispose() {
    _sbdCtrl.dispose();
    _hoTenCtrl.dispose();
    _tuoiCtrl.dispose();
    _loaiCtrl.dispose();
    _luongCB.dispose();
    super.dispose();
  }

  void _themNhanVien() {
    if (_formKey.currentState!.validate()) {
      final nv = NhanVien(
        sbd: _sbdCtrl.text.trim(),
        hoTen: _hoTenCtrl.text.trim(),
        tuoi: int.tryParse(_tuoiCtrl.text.trim()) ?? 0,
        loai: _loaiCtrl.text.trim(),
        luongCB: double.tryParse(_luongCB.text.trim()) ?? 0,
      );
      setState(() {
        dsNhanVien.add(nv);
        dsNhanVien.sort((a, b) => a.sbd.compareTo(b.sbd));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đã thêm nhân viên SBD: ${nv.sbd}")),
      );
    }
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nhập dữ liêu",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 15),
              buildTextField(
                label: "SBD",
                controller: _sbdCtrl,
                extraValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return "SBD không được bỏ trống";
                  }
                  if (dsNhanVien.any((nv) => nv.sbd == value.trim())) {
                    return "SBD đã tồn tại";
                  }
                },
                inputType: InputType.textAndNumber,
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Họ và tên",
                controller: _hoTenCtrl,
                inputType: InputType.text,
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Tuổi",
                controller: _tuoiCtrl,
                inputType: InputType.number,
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Loai",
                controller: _loaiCtrl,
                inputType: InputType.text,
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Lương cơ bản",
                controller: _luongCB,
                inputType: InputType.number,
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: _themNhanVien,
                child: Text(
                  "Lưu dữ liệu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DanhSachNhanVienScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách nhân viên",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: dsNhanVien.isEmpty
            ? Center(
          child: Text(
            "Danh sách trống",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
            : Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: dsNhanVien.length,
            itemBuilder: (_, index) {
              final nv = dsNhanVien[index];
              return Card(
                margin: EdgeInsets.all(10),
                color: Colors.yellow.shade100,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      nv.sbd,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(nv.hoTen),
                  subtitle: Text(
                    "Tuổi: ${nv.tuoi} | Loại: ${nv.loai} | Lương cơ bản: ${nv.luongCB} |",
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class XoaNhanVienScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => XoaNhanVienScreenState();
}

class XoaNhanVienScreenState extends State<XoaNhanVienScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sbdCtrl = TextEditingController();

  void _xoaNhanVien() {
    if (_formKey.currentState!.validate()) {
      final sbd = _sbdCtrl.text.trim();
      final before = dsNhanVien.length;
      dsNhanVien.removeWhere((nv) => nv.sbd == sbd);
      final after = dsNhanVien.length;
      if (after < before) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Đã xóa nhân viên SBD $sbd")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('SBD $sbd không tồn tại')));
      }
      setState(() {});
      _formKey.currentState!.reset();
    }
  }

  void _xoaTatCaNhanVien() {
    if (dsNhanVien.isEmpty) {
      Center(
        child: Text(
          "Danh sách trống",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Xác nhận"),
            content: Text("Bạn có chắc chắn muốn xóa toàn bộ dự liệu ?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Hủy"),
              ),
              ElevatedButton(
                onPressed: () {
                  dsNhanVien.clear();
                  Navigator.pop(ctx);
                },
                child: Text("Đồng ý"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Xoá dữ liệu nhân viên",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(
                label: "SBD",
                controller: _sbdCtrl,
                extraValidator: (value) => (value == null || value.isEmpty)
                    ? "SBD không được bỏ trống"
                    : null,
                inputType: InputType.textAndNumber,
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _xoaNhanVien,
                    child: Text("Xóa dữ liệu"),
                  ),
                  ElevatedButton(
                    onPressed: _xoaTatCaNhanVien,
                    child: Text("Xóa toàn bộ dữ liệu"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimNhanVienScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TimNhanVienScreenState();
}

class TimNhanVienScreenState extends State<TimNhanVienScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sbdCtrl = TextEditingController();

  void _timNhanVien() {
    if (_formKey.currentState!.validate()) {
      final sbd = _sbdCtrl.text.trim();
      final nv = dsNhanVien.firstWhere(
            (nv) => nv.sbd == sbd,
        orElse: () =>
            NhanVien(sbd: "", hoTen: "", tuoi: 0, loai: "", luongCB: 0),
      );
      if (nv.sbd.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("SBD không tồn tại")));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChinhSuaNhanVienScreen(nv)),
        );
      }
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tìm nhân viên",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(
                label: "SBD",
                controller: _sbdCtrl,
                inputType: InputType.textAndNumber,
                extraValidator: (value) => (value == null || value.isEmpty)
                    ? "SBD không được bỏ trống"
                    : null,
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: _timNhanVien,
                child: Text(
                  "Tra cứu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChinhSuaNhanVienScreen extends StatefulWidget {
  final NhanVien nhanVien;

  ChinhSuaNhanVienScreen(this.nhanVien);

  @override
  State<StatefulWidget> createState() => ChinhSuaNhanVienScreenState();
}

class ChinhSuaNhanVienScreenState extends State<ChinhSuaNhanVienScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _hotenCtrl;
  late final TextEditingController _tuoiCtrl;
  late final TextEditingController _loaiCtrl;
  late final TextEditingController _luongCBCtrl;

  @override
  void initState() {
    super.initState();
    _hotenCtrl = TextEditingController(text: widget.nhanVien.hoTen);
    _tuoiCtrl = TextEditingController(text: widget.nhanVien.tuoi.toString());
    _loaiCtrl = TextEditingController(text: widget.nhanVien.loai);
    _luongCBCtrl = TextEditingController(
      text: widget.nhanVien.luongCB.toString(),
    );
  }

  void chinhSuaNhanVien() {
    widget.nhanVien.hoTen = _hotenCtrl.text.trim();
    widget.nhanVien.tuoi = int.tryParse(_tuoiCtrl.text.trim()) ?? 0;
    widget.nhanVien.loai = _loaiCtrl.text.trim();
    widget.nhanVien.luongCB = double.tryParse(_luongCBCtrl.text.trim()) ?? 0;
    setState(() {});
    _formKey.currentState!.reset();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chỉnh sửa dữ liệu nhân viên",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "SBD: ${widget.nhanVien.sbd}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Họ và tên",
                controller: _hotenCtrl,
                inputType: InputType.text,
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Tuổi",
                controller: _tuoiCtrl,
                inputType: InputType.number,
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Loại",
                controller: _loaiCtrl,
                inputType: InputType.text,
              ),
              SizedBox(height: 15),
              buildTextField(
                label: "Lương cơ bản",
                controller: _luongCBCtrl,
                inputType: InputType.number,
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: chinhSuaNhanVien,
                child: Text("Lưu thay đổi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
