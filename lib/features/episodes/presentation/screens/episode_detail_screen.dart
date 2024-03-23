import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/internal/components/text_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';

class EpisodeDetailScreen extends StatefulWidget {
  final EpisodeModel episodeModel;

  const EpisodeDetailScreen({
    Key? key,
    required this.episodeModel,
  }) : super(key: key);

  @override
  State<EpisodeDetailScreen> createState() => _EpisodeDetailScreenState();
}

class _EpisodeDetailScreenState extends State<EpisodeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    '${widget.episodeModel.imageUrl}',
                    height: 298.h,
                    width: 375.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 251.h,
            child: ContainerContent(
              themeProvider: Provider.of<ThemeProvider>(context),
              widget: widget,
            ),
          ),
          Positioned(
            top: 201.h,
            left: 123.w,
            right: 114.w,
            child: InkWell(
              onTap: () {
                String videoId = '3YFW5HoAeKo';
                YoutubePlayerController youtubePlayerController =
                    YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                        backgroundColor: Colors.blue,
                        body: Stack(
                          children: [
                            Image.asset(
                              'assets/images/Начальный экран.png',
                              height: 812.h,
                              width: 375.w,
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Lottie.asset(
                                    'assets/images/nlo.json',
                                    height: 300.h,
                                    width: 300.w,
                                  ),
                                  YoutubePlayer(
                                    controller: youtubePlayerController,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.blue[400],
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerContent extends StatelessWidget {
  final ThemeProvider themeProvider;
  const ContainerContent({
    Key? key,
    required this.themeProvider,
    required this.widget,
  }) : super(key: key);

  final EpisodeDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.changeContainerColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.r),
          topRight: Radius.circular(35.r),
        ),
      ),
      height: 561.h,
      width: 375.w,
      child: Padding(
        padding: EdgeInsets.only(
          top: 82.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          children: [
            Text(
              widget.episodeModel.name ?? '-',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: themeProvider.changeTextColor(),
              ),
            ),
            Text(
              'СЕРИЯ ${widget.episodeModel.id}',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.',
              style: TextStyle(
                color: themeProvider.changeTextColor(),
              ),
            ),
            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Премьера',
                    style: TextHelper.w400s12grey,
                  ),
                  Text(
                    widget.episodeModel.airDate ?? '-',
                    style: TextStyle(
                      color: themeProvider.changeTextColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
