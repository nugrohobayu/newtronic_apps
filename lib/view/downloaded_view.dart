import 'package:flutter/material.dart';
import 'package:newtronic_apps/components/card_content/card_content.dart';
import 'package:newtronic_apps/data/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

import '../components/image_view/image_view.dart';
import '../utils/size_config.dart';

class DownloadedView extends StatelessWidget {
  static const routeName = '/DownloadedView';
  const DownloadedView({Key? key}) : super(key: key);

  Widget _cardContent() {
    return Consumer<HomeViewModel>(builder: (context, provider, child) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: provider.playlist.length,
        itemBuilder: (context, index) {
          final listDownloaded = provider.playlist[index];
          return CardContent(playlist: listDownloaded);
        },
      );
    });
  }

  Widget _cardPlayback() {
    return Consumer<HomeViewModel>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            provider.type == 'video'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: SizeConfig.height * .3,
                          child: VimeoPlayer(
                            videoId: provider.idVideo,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                        child: Text(
                          provider.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: Text(provider.desc),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageView(
                        image: provider.img,
                        height: SizeConfig.height * .3,
                        width: SizeConfig.width,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                        child: Text(
                          provider.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: Text(provider.desc),
                      ),
                    ],
                  ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloads"),
      ),
      body: Container(
        height: SizeConfig.height,
        padding: const EdgeInsets.only(top: 8.0),
        child: Consumer<HomeViewModel>(builder: (context, provider, child) {
          return Column(
            children: [
              provider.playlist.isNotEmpty ? _cardPlayback() : const SizedBox(),
              _cardContent(),
            ],
          );
        }),
      ),
    );
  }
}
