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
  String urlVideo = '';
  String idVideo = '';
  String img = '';
  String title = '';
  String desc = '';
  String type = '';
  List<Playlist> listContent = [];
  int currentPlay = 0;
  bool isPlayed = true;

  void played(index) {
    if (type == 'video') {
      splitUrl(urlVideo);
    }
    currentPlay = index;
    notifyListeners();
  }

  void clickedButton(index) {
    currentBtn = index;
    notifyListeners();
  }

  Future<void> _getList() async {
    final result = await Api().fetchApi();
    if (result!.data.isNotEmpty) {
      urlLogo = result.data.first.logo;
      img = result.data.first.playlist.first.url;
      title = result.data.first.playlist.first.title;
      desc = result.data.first.playlist.first.description;
      listContent = result.data.first.playlist;
    }
    notifyListeners();
  }

  void playback(int index) {
    if (listContent[index].type == 'video') {
      urlVideo = listContent[index].url;
    }
    img = listContent[index].url;
    title = listContent[index].title;
    desc = listContent[index].description;
    type = listContent[index].type;
    notifyListeners();
  }

  void splitUrl(String url) {
    List<String> parts = url.split('/');
    String lastPart = parts.last;
    List<String> idAndParams = lastPart.split('?');
    String id = idAndParams.first;
    idVideo = id;
    notifyListeners();
  }
}
