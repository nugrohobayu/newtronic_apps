import 'package:flutter/material.dart';
import 'package:newtronic_apps/components/button/button_view.dart';
import 'package:newtronic_apps/components/image_view/image_view.dart';
import 'package:newtronic_apps/data/viewmodel/home_viewmodel.dart';
import 'package:newtronic_apps/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/HomeView';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel(),
        builder: (context, child) {
          return Consumer<HomeViewModel>(builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xFFAEAEAE),
                title: Image.network(
                  provider.urlLogo,
                  width: SizeConfig.width * .4,
                  color: const Color(0xff2563EB),
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported_outlined),
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    provider.type == 'video'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: SizeConfig.height * .3,
                                  child: VimeoPlayer(videoId: '558733589')),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 8),
                                child: Text(
                                  provider.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, bottom: 8.0),
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
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 8),
                                child: Text(
                                  provider.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, bottom: 8.0),
                                child: Text(provider.desc),
                              ),
                            ],
                          ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: provider.listButton.asMap().entries.map((e) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ButtonView(
                              name: e.value.title,
                              backgroundColor: provider.currentBtn == e.key
                                  ? const Color(0xFF3B82F6)
                                  : const Color(0xFFAEAEAE),
                              textColor: provider.currentBtn == e.key
                                  ? Colors.white
                                  : Colors.black,
                              width: SizeConfig.width * .3,
                              onPressed: () {
                                provider.clickedButton(e.key);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    ...provider.listContent.asMap().entries.map((e) {
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  provider.playback(e.key);
                                  provider.played(e.key);
                                },
                                child: provider.currentPlay == e.key
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
                                    e.value.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    e.value.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            ButtonView(
                              name: 'Simpan',
                              width: SizeConfig.width * .28,
                              height: SizeConfig.height * .05,
                              textSize: 14,
                              onPressed: () {},
                            )
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          });
        });
  }
}
