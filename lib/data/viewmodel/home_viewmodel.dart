import 'package:flutter/material.dart';
import 'package:newtronic_apps/data/model/button_list_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<ButtonModelList> listButton = [
    ButtonModelList(title: 'Produk'),
    ButtonModelList(title: 'Materi'),
    ButtonModelList(title: 'Layanan'),
    ButtonModelList(title: 'Lainnya'),
  ];
  int currentBtn = 0;

  void clickedButton(index) {
    currentBtn = index;
    notifyListeners();
  }
}
