import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newtronic_apps/data/model/button_list_model.dart';
import 'package:newtronic_apps/data/service/api.dart';
import 'package:newtronic_apps/data/service/database_service.dart';
import 'package:newtronic_apps/utils/downloads_path.dart';
import 'package:path_provider/path_provider.dart';
import '../enums/result_data.dart';
import '../model/response_api_model.dart';

class HomeViewModel extends ChangeNotifier {
  final DatabaseService databaseService;
  HomeViewModel({required this.databaseService}) {
    _getList();
    _getPlaylist();
  }
  List<ButtonModelList> listButton = [
    ButtonModelList(title: 'Produk'),
    ButtonModelList(title: 'Materi'),
    ButtonModelList(title: 'Layanan'),
    ButtonModelList(title: 'Lainnya'),
  ];

  int currentBtn = 0;
  String urlLogo = '';
  String titleMenu = '';
  String descMenu = '';
  String urlVideo = '';
  String idVideo = '';
  String img = '';
  String title = '';
  String desc = '';
  String type = '';
  List<Playlist> listContent = [];
  int? currentPlay;
  bool isPlayed = true;

  List<Playlist> _playlist = [];
  List<Playlist> get playlist => _playlist;
  late ResultData resultData;

  Future _getPlaylist() async {
    final result = await DatabaseService().getDownloaded();
    _playlist = result;
    notifyListeners();
  }

  File? urlImageLoc;
  File? urlVideoLoc;

  Future getImageFile(String fileName) async {
    final directory = Platform.isAndroid
        ? (await DownloadsPath.downloadsDirectory())
        : (await getApplicationDocumentsDirectory()).path;
    final fileNameDir = '$directory/$fileName';
    File imageFile = File(fileNameDir);
    urlImageLoc = imageFile;
    urlVideoLoc = imageFile;
    notifyListeners();
  }

  void splitUrlLoc(String url) {
    List<String> parts = url.split('/');
    String lastPart = parts.last;
    List<String> idAndParams = lastPart.split('?');
    String id = idAndParams.first;
    idVideo = id;
    notifyListeners();
  }

  void download(Playlist playlist) async {
    try {
      await databaseService.addDownloaded(playlist);
      _getPlaylist();
    } catch (e) {
      notifyListeners();
    }
  }

  void removeDownloaded(String id) async {
    try {
      await databaseService.deleteDownloaded(id);
      _getPlaylist();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<bool> isDownload(String id) async {
    final downloadedPlaylist = await databaseService.getDownloadById(id);
    return downloadedPlaylist.isNotEmpty;
  }

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
    try {
      resultData = ResultData.loading;
      notifyListeners();
      final result = await Api().fetchApi();
      if (result!.data.isNotEmpty) {
        resultData = ResultData.hasData;
        urlLogo = result.data.first.logo;
        titleMenu = result.data.first.title;
        descMenu = result.data.first.description;
        img = result.data.first.playlist.first.url;
        title = result.data.first.playlist.first.title;
        desc = result.data.first.playlist.first.description;
        listContent = result.data.first.playlist;
        notifyListeners();
      } else {
        resultData = ResultData.noData;
        notifyListeners();
      }
    } catch (error) {
      resultData = ResultData.error;
      notifyListeners();
    }

    // final result = await Api().fetchApi();
    // if (result!.data.isNotEmpty) {
    //   urlLogo = result.data.first.logo;
    //   titleMenu = result.data.first.title;
    //   descMenu = result.data.first.description;
    //   img = result.data.first.playlist.first.url;
    //   title = result.data.first.playlist.first.title;
    //   desc = result.data.first.playlist.first.description;
    //   listContent = result.data.first.playlist;
    // }
    // notifyListeners();
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
