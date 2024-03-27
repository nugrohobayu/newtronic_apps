import 'package:flutter/material.dart';
import 'package:newtronic_apps/data/model/button_list_model.dart';
import 'package:newtronic_apps/data/service/api.dart';

import '../model/response_api_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    _getList();
  }
  List<ButtonModelList> listButton = [
    ButtonModelList(title: 'Produk'),
    ButtonModelList(title: 'Materi'),
    ButtonModelList(title: 'Layanan'),
    ButtonModelList(title: 'Lainnya'),
  ];
  int currentBtn = 0;
  String urlLogo = '';
  List<Playlist> listContent = [];

  void clickedButton(index) {
    currentBtn = index;
    notifyListeners();
  }

  Future<void> _getList() async {
    final result = await Api().fetchApi();
    if (result!.data.isNotEmpty) {
      urlLogo = result.data.first.logo;
      listContent = result.data.first.playlist;
    }
    notifyListeners();
  }
}
