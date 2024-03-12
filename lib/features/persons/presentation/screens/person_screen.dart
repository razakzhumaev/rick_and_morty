import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';
import 'package:rick_morty_app/features/persons/data/repository/person_repository_impl.dart';
import 'package:rick_morty_app/features/persons/domain/use_case/person_use_case.dart';
import 'package:rick_morty_app/features/persons/presentation/person_bloc/bloc/person_bloc.dart';
import 'package:rick_morty_app/features/persons/presentation/screens/person_detail_screen.dart';
import 'package:rick_morty_app/features/search_screen/widgets/widgets.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';
import 'package:rick_morty_app/internal/helpers/utils.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  PersonBloc bloc = PersonBloc(
    personUseCase: PersonUseCase(
      personRepository: PersonRepositoryImpl(),
    ),
  );

  late ScrollController _scrollController;
  bool isLoading = false;
  int currentPage = 1;
  bool isListView = true;
  List<PersonModel> personList = [];

  @override
  void initState() {
    bloc.add(GetAllPersonsEvent(
      currentPage: currentPage,
      isFirstCall: true,
    ));

    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (personList.isNotEmpty) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          currentPage = currentPage + 1;

          bloc.add(GetAllPersonsEvent(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchTextField(
              themeProvider: Provider.of<ThemeProvider>(context),
              onChanged: (val) {
                bloc.add(GetAllPersonsEvent(
                  currentPage: currentPage,
                  isFirstCall: true,
                  isSearch: true,
                  name: val,
                ));
              },
              hintText: 'Найти персонажа',
              suffixIcon: const Icon(Icons.flashlight_on_outlined),
            ),
            SizedBox(height: 24.h),
            SingleChildScrollView(
              child: BlocConsumer<PersonBloc, PersonState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state is PersonLoadedState) {
                    if (state.isSearch) {
                      personList.clear();
                    }

                    personList.addAll(state.personResult.results ?? []);

                    isLoading = false;
                  }
                  if (state is PersonErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.error.message.toString(),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  print('state is $state');

                  if (state is PersonLoadingState) {
                    return Center(
                      child: Lottie.asset('assets/images/rocket.json'),
                    );
                  }

                  if (state is PersonErrorState) {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('error'),
                        ),
                        Text('${state.error.message}'),
                      ],
                    );
                  }

                  if (state is PersonLoadedState) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Всего персонажей: ${state.personResult.info?.count}',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                isListView = !isListView;
                                setState(() {});
                              },
                              child: Icon(
                                isListView ? Icons.grid_view : Icons.abc,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 588.h,
                          child: isListView
                              ? ListViewSeparatedContent(
                                  themeProvider:
                                      Provider.of<ThemeProvider>(context),
                                  scrollController: _scrollController,
                                  personList: personList,
                                )
                              : GridViewContent(
                                  themeProvider:
                                      Provider.of<ThemeProvider>(context),
                                  personList: personList,
                                  scrollController: _scrollController,
                                ),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListViewSeparatedContent extends StatelessWidget {
  final ScrollController _scrollController;
  final List<PersonModel> personList;
  final ThemeProvider themeProvider;

  const ListViewSeparatedContent({
    super.key,
    required ScrollController scrollController,
    required this.personList,
    required this.themeProvider,
  }) : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: personList.length,
      itemBuilder: (context, index) {
        if (index >= personList.length - 1) {
          return const CustomSpinner();
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonDetailScreen(
                  personModel: personList[index],
                ),
              ),
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  personList[index].image ?? '-',
                  height: 74,
                  width: 74,
                ),
              ),
              const SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusDeadAliveConverter(
                      personList[index].status,
                    ),
                    style: TextStyle(
                      color: statusColorConverter(personList[index].status),
                    ),
                  ),
                  Text(
                    '${personList[index].name}',
                    style: TextStyle(color: themeProvider.changeTextColor()),
                    // TextHelper.w500s16white,
                  ),
                  Text(
                    '${statusSpeciesConverter(
                      personList[index].species,
                    )}, ${statusGenderConverter(
                      personList[index].gender,
                    )}',
                    style: TextHelper.w400s12grey,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 24.h);
      },
    );
  }
}

class GridViewContent extends StatelessWidget {
  final ScrollController _scrollController;
  final List<PersonModel> personList;
  final ThemeProvider themeProvider;

  const GridViewContent({
    super.key,
    required ScrollController scrollController,
    required this.personList,
    required this.themeProvider,
  }) : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: personList.length,
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        if (index >= personList.length - 1) {
          return const CustomSpinner();
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonDetailScreen(
                  personModel: personList[index],
                ),
              ),
            );
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  personList[index].image ?? '-',
                  height: 74,
                  width: 74,
                ),
              ),
              const SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusDeadAliveConverter(personList[index].status),
                    style: TextStyle(
                      color: statusColorConverter(personList[index].status),
                    ),
                  ),
                  Text(
                    '${personList[index].name}',
                    style: TextStyle(color: themeProvider.changeTextColor()),
                  ),
                  Text(
                    '${statusSpeciesConverter(
                      personList[index].species,
                    )}, ${statusGenderConverter(
                      personList[index].gender,
                    )}',
                    style: TextHelper.w400s12grey,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: !Platform.isAndroid
          ? const CircularProgressIndicator()
          : CupertinoActivityIndicator(
              radius: 15.r,
              color: Colors.grey,
            ),
    );
  }
}
