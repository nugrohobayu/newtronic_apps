import 'package:flutter/material.dart';
import 'package:newtronic_apps/components/button/button_view.dart';
import 'package:newtronic_apps/components/card_content/card_content.dart';
import 'package:newtronic_apps/components/image_view/image_view.dart';
import 'package:newtronic_apps/data/viewmodel/home_viewmodel.dart';
import 'package:newtronic_apps/utils/size_config.dart';
import 'package:newtronic_apps/view/downloaded_view.dart';
import 'package:provider/provider.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/HomeView';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFAEAEAE),
          title: ImageView(
            image: provider.urlLogo,
            width: SizeConfig.width * .4,
            color: const Color(0xff2563EB),
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: const Color(0xff2563EB),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff2563EB),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageView(
                      image: provider.urlLogo,
                      width: SizeConfig.width * .3,
                    ),
                    Text(provider.titleMenu,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(Icons.download, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Hasil Download',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, DownloadedView.routeName);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
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
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ButtonView(
                        name: e.value.title,
                        backgroundColor: provider.currentBtn == e.key
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFFAEAEAE),
                        textColor: provider.currentBtn == e.key
                            ? Colors.white
                            : Colors.black,
                        width: SizeConfig.width * .35,
                        textSize: 16,
                        textWeight: FontWeight.w600,
                        onPressed: () {
                          provider.clickedButton(e.key);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              ...provider.listContent.asMap().entries.map((e) {
                return CardContent(playlist: e.value);
              }),
            ],
          ),
        ),
      );
    });
  }
}
