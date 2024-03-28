import 'package:flutter/material.dart';
import 'package:newtronic_apps/components/card_content/card_content.dart';
import 'package:newtronic_apps/data/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class DownloadedView extends StatelessWidget {
  static const routeName = '/DownloadedView';
  const DownloadedView({Key? key}) : super(key: key);

  Widget _cardContent() {
    return Consumer<HomeViewModel>(builder: (context, provider, child) {
      return ListView.builder(
        itemCount: provider.playlist.length,
        itemBuilder: (context, index) {
          final listDownloaded = provider.playlist[index];
          return CardContent(playlist: listDownloaded);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloaded Video"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _cardContent(),
      ),
    );
  }
}
