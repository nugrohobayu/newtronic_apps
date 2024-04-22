import 'package:flutter/material.dart';
import 'package:newtronic_apps/components/dialog/dialog_view.dart';
import 'package:newtronic_apps/data/model/response_api_model.dart';
import 'package:newtronic_apps/data/viewmodel/home_viewmodel.dart';
import 'package:newtronic_apps/utils/file_downloader.dart';
import 'package:provider/provider.dart';

import '../../utils/size_config.dart';
import '../button/button_view.dart';

class CardContent extends StatelessWidget {
  final Playlist playlist;
  const CardContent({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isDownload(playlist.id.toString()),
          builder: (context, snapshot) {
            var isDownloaded = snapshot.data ?? false;
            return Container(
              margin: const EdgeInsets.only(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.black26),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        await provider.getImageFile(playlist.title);
                        provider.playback(playlist.id - 1);
                        provider.played(playlist.id - 1);
                      },
                      child: provider.currentPlay == playlist.id - 1
                          ? const Icon(
                              Icons.pause_circle,
                              color: Colors.black87,
                              size: 50,
                            )
                          : const Icon(
                              Icons.play_circle,
                              color: Colors.black87,
                              size: 50,
                            )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlist.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          playlist.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ButtonView(
                    name: isDownloaded ? "Tersimpan" : 'Simpan',
                    backgroundColor: isDownloaded ? Colors.green : Colors.blue,
                    width: SizeConfig.width * .28,
                    height: SizeConfig.height * .05,
                    textSize: 14,
                    onPressed: () {
                      if (!isDownloaded) {
                        FileDownloader()
                            .downloadFromUrl(playlist.url, playlist.title)
                            .then((value) {
                          if (value == true) {
                            DialogView.info(
                              context,
                              description: 'Berhasil Unduh File',
                              onPressedOk: () => Navigator.pop(context),
                            );
                            provider.download(playlist);
                          }
                        });
                      } else {
                        provider.removeDownloaded(playlist.id.toString());
                      }
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
