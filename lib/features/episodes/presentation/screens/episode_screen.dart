import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/episodes/data/repository/episode_repository_impl.dart';
import 'package:rick_morty_app/features/episodes/domain/use_case/episode_use_case.dart';
import 'package:rick_morty_app/features/episodes/presentation/episode/bloc/episode_bloc.dart';
import 'package:rick_morty_app/features/locations/presentation/screens/location_screen.dart';
import 'package:rick_morty_app/internal/components/textfields.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';

class EpisodeSreen extends StatefulWidget {
  const EpisodeSreen({super.key});

  @override
  State<EpisodeSreen> createState() => _EpisodeSreenState();
}

class _EpisodeSreenState extends State<EpisodeSreen> {
  late ScrollController _scrollController;
  bool isLoading = false;
  int currentPage = 1;
  bool isListView = true;
  List<EpisodeModel> episodeList = [];

  EpisodeBloc bloc = EpisodeBloc(
      episodeUseCase:
          EpisodeUseCase(episodeRepository: EpisodeRepositoryImpl()));

  @override
  void initState() {
    bloc.add(GetAllEpisodesEvent(
      currentPage: currentPage,
      isFirstCall: true,
    ));

    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (episodeList.isNotEmpty) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          currentPage = currentPage + 1;

          bloc.add(GetAllEpisodesEvent(
            currentPage: currentPage,
            isFirstCall: false,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            SearchTextField(
              themeProvider: Provider.of<ThemeProvider>(context),
              hintText: 'Найти эпизод',
              onChanged: (value) {
                bloc.add(GetAllEpisodesEvent(
                  currentPage: currentPage,
                  isFirstCall: true,
                ));
              },
            ),
            const TabBar(
              indicatorWeight: 5,
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              tabs: [
                Tab(text: 'СЕЗОН 1'),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            BlocConsumer<EpisodeBloc, EpisodeState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is EpisodeErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.error.message.toString(),
                      ),
                    ),
                  );
                }
                if (state is EpisodeLoadedState) {
                  episodeList.addAll(state.episodeResult.results ?? []);
                }
              },
              builder: (context, state) {
                if (state is EpisodeLoadingState) {
                  return Center(
                    child: Lottie.asset('assets/images/rocket.json'),
                  );
                }
                if (state is EpisodeLoadedState) {
                  return Expanded(
                    child: TabBarView(
                      children: [
                        SizedBox(
                          height: 588.h,
                          child: ListViewSeparetedContent(
                            themeProvider: Provider.of<ThemeProvider>(context),
                            scrollController: _scrollController,
                            episodeList: episodeList,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}

class ListViewSeparetedContent extends StatelessWidget {
  final ScrollController _scrollController;
  final List<EpisodeModel> episodeList;
  final ThemeProvider themeProvider;

  const ListViewSeparetedContent({
    required ScrollController scrollController,
    required this.episodeList,
    super.key,
    required this.themeProvider,
  }) : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: episodeList.length,
      itemBuilder: (context, index) {
        if (index >= episodeList.length - 1) {
          return const CustomSpinner();
        }
        return InkWell(
          onTap: () {
            context.push(
              RouterConstants.episodeDetailScreen,
              extra: {
                'episodeModel': episodeList[index],
              },
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  episodeList[index].imageUrl ?? '-',
                  height: 70.h,
                  fit: BoxFit.cover,
                  width: 70.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'СЕРИЯ ${episodeList[index].id}',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      '${episodeList[index].name}',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: themeProvider.changeTextColor(),
                      ),
                    ),
                    Text(
                      '${episodeList[index].airDate}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (contex, index) {
        return const SizedBox(height: 24);
      },
    );
  }
}
