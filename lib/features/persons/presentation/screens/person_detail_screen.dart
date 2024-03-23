import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/episodes/presentation/screens/episode_detail_screen.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';
import 'package:rick_morty_app/features/persons/data/repository/person_repository_impl.dart';
import 'package:rick_morty_app/features/persons/domain/use_case/person_use_case.dart';
import 'package:rick_morty_app/features/persons/presentation/person_bloc/bloc/person_bloc.dart';
import 'package:rick_morty_app/internal/components/text_helper.dart';
import 'package:rick_morty_app/internal/components/textfields.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';
import 'package:rick_morty_app/internal/helpers/utils.dart';

class PersonDetailScreen extends StatefulWidget {
  final PersonModel personModel;

  const PersonDetailScreen({
    Key? key,
    required this.personModel,
  }) : super(key: key);

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  PersonBloc bloc = PersonBloc(
    personUseCase: PersonUseCase(
      personRepository: PersonRepositoryImpl(),
    ),
  );

  @override
  void initState() {
    bloc.add(GetPersonEpisodeEvent(personModel: widget.personModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            child: Stack(
              children: [
                Image.network(
                  '${widget.personModel.image}',
                  height: 218.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 138.h,
                    right: 114.w,
                    left: 115.w,
                  ),
                  child: CircleAvatar(
                    radius: 73.r,
                    backgroundImage: NetworkImage(
                      widget.personModel.image ?? '-',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 90.h),
          Text(
            widget.personModel.name ?? '-',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeProvider.changeTextColor(),
              fontSize: 34.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            statusDeadAliveConverter(
              widget.personModel.status,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: statusColorConverter(widget.personModel.status),
            ),
          ),
          SizedBox(height: 36.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: 16.w,
                left: 16.w,
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    'Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: themeProvider.changeTextColor(),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Пол', style: TextHelper.w400s12grey),
                          Text(
                            statusGenderConverter(widget.personModel.gender),
                            style: TextStyle(
                              color: themeProvider.changeTextColor(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 118.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Расса',
                            style: TextHelper.w400s12grey,
                          ),
                          Text(
                            statusSpeciesConverter(widget.personModel.species),
                            style: TextStyle(
                              color: themeProvider.changeTextColor(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Место рождения',
                            style: TextHelper.w400s12grey,
                          ),
                          Text(
                            '${widget.personModel.origin?.name}',
                            style: TextStyle(
                              color: themeProvider.changeTextColor(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Местоположение',
                            style: TextHelper.w400s12grey,
                          ),
                          Text(
                            '${widget.personModel.location?.name}',
                            style: TextStyle(
                              color: themeProvider.changeTextColor(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  SizedBox(height: 36.h),
                  const Divider(),
                  SizedBox(height: 36.h),
                  Row(
                    children: [
                      Text(
                        'Эпизоды',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: themeProvider.changeTextColor(),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Все эпизоды',
                        style: TextHelper.w400s12grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<PersonBloc, PersonState>(
                    bloc: bloc,
                    builder: (context, state) {
                      debugPrint('state is $state');
                      if (state is EpisodeLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is EpisodeLoadedState) {
                        return PersonEpisodeListViewSepareted(
                          personEpisodeModel: state.personEpisodeModel,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonEpisodeListViewSepareted extends StatelessWidget {
  final List<EpisodeModel> personEpisodeModel;

  const PersonEpisodeListViewSepareted({
    Key? key,
    required this.personEpisodeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: personEpisodeModel.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EpisodeDetailScreen(
                  episodeModel: personEpisodeModel[index],
                ),
              ),
            );
          },
          child: Row(
            children: [
              SizedBox(
                height: 74.h,
                width: 74.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    'https://static1.colliderimages.com/wordpress/wp-content/uploads/2022/08/Rick--Morty-Season-6EWKSF-feature.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Серия ${personEpisodeModel[index].id}',
                    style: TextHelper.s16blue,
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 220,
                    child: Text(
                      personEpisodeModel[index].name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextHelper.s16black,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    personEpisodeModel[index].airDate.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 15.sp,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 24.h),
    );
  }
}
