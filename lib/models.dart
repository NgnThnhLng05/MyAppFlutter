// chua class du lieu
import 'package:flutter/material.dart';

class NhanVien {
  String sbd, hoTen, loai;
  int tuoi;
  double luongCB;

  NhanVien({
    required this.sbd,
    required this.hoTen,
    required this.tuoi,
    required this.loai,
    required this.luongCB,
  });
}

List<NhanVien> dsNhanVien = [];
