import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/features/locations/data/model/location_model.dart';
import 'package:rick_morty_app/features/locations/data/repository/location_repository_impl.dart';
import 'package:rick_morty_app/features/locations/domain/use_case/location_use_case.dart';
import 'package:rick_morty_app/features/locations/presentation/location_bloc/bloc/location_bloc.dart';
import 'package:rick_morty_app/features/locations/presentation/screens/location_detail_screen.dart';
import 'package:rick_morty_app/features/search_screen/widgets/widgets.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late ScrollController _scrollController;
  bool isLoading = false;
  int currentPage = 1;
  bool isListView = true;
  List<LocationModel> locationList = [];

  LocationBloc bloc = LocationBloc(
    locationUseCase: LocationUseCase(
      locationRepository: LocationRepositoryImpl(),
    ),
  );
  @override
  void initState() {
    bloc.add(GetAllLocationsEvent(
      currentPage: currentPage,
      isFirstCall: true,
    ));

    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (locationList.isNotEmpty) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          currentPage = currentPage + 1;

          bloc.add(GetAllLocationsEvent(
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
              onChanged: (value) {
                bloc.add(GetAllLocationsEvent(
                  currentPage: currentPage,
                  isFirstCall: true,
                ));
              },
              hintText: 'Найти локацию',
            ),
            SizedBox(height: 24.h),
            BlocConsumer<LocationBloc, LocationState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is LocationLoadedState) {
                  locationList.addAll(
                    state.locationResult.results ?? [],
                  );
                }
                if (state is LocationErrorState) {
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
                if (state is LocationLoadingState) {
                  return Center(
                    child: Lottie.asset('assets/images/rocket.json'),
                  );
                }

                if (state is LocationLoadedState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Всего локаций: ${state.locationResult.info?.count}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 588.h,
                        child: ListViewSeparetedContent(
                          themeProvider: Provider.of(context),
                          scrollController: _scrollController,
                          locationList: locationList,
                        ),
                      ),
                    ],
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
  final ThemeProvider themeProvider;
  final ScrollController _scrollController;
  final List<LocationModel> locationList;

  const ListViewSeparetedContent({
    required ScrollController scrollController,
    required this.locationList,
    super.key,
    required this.themeProvider,
  }) : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: locationList.length,
      itemBuilder: (context, index) {
        if (index >= locationList.length - 1) {
          return const CustomSpinner();
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contex) => LocationDetailScreen(
                  locationModel: locationList[index],
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              color: themeProvider.changeContainerColor(),
              child: Column(
                children: [
                  Image.asset(
                    locationList[index].imageUrl ?? '-',
                    height: 150.h,
                    width: 343.w,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      top: 12.h,
                      bottom: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locationList[index].name ?? '-',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.changeTextColor(),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              locationList[index].type ?? '-',
                              style: TextHelper.w400s12grey,
                            ),
                            SizedBox(width: 5.w),
                            const Text('◦'),
                            SizedBox(width: 5.w),
                            Text(
                              locationList[index].dimension ?? '-',
                              style: TextHelper.w400s12grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 24.h);
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
