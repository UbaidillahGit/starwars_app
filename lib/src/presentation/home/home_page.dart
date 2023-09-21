import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/application/prov_people.dart';
import 'package:starwars_app/src/presentation/detail/detail_page.dart';
import 'package:starwars_app/src/presentation/utils/home_loading.dart';
import 'package:starwars_app/src/presentation/home/components/home_refresh_loading.dart';
import 'package:starwars_app/src/presentation/search/search_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _init();
  }

  ///_____ Init ScrollController and call API data for all Species/Character
  _init() {
    _scrollController = ScrollController(initialScrollOffset: 10)..addListener(_scrollListener);
    // ref.read(provSpecies.notifier).listSpecies();
    ref.read(peopleProvider.notifier).getPoeple();
  }

  ///_____ Trigger pagination when scroll position is on max extent
  _scrollListener() async {
    if (_scrollController?.position.maxScrollExtent == _scrollController?.offset) {
      ref.read(peopleProvider.notifier).paginationNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(peopleProvider);
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage())),
            icon: const Icon(Icons.search),
          )
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Star Wars',
          style: TextStyle(fontFamily: 'Starjedi'),
        ),
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: watch.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                    itemCount: data.results?.length ?? 0,
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => PeopleDetailPage(detailUrl: data.results?[index].url ?? ''))),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
                                image: AssetImage('assets/images/card.jpeg'),
                                opacity: 100,
                              ),
                            ),
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${data.results?[index].name}',
                                        style: const TextStyle(fontFamily: 'Starjedi', color: Colors.white, fontSize: 40),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${data.results?[index].birthYear}',
                                        style: const TextStyle(
                                          fontFamily: 'Starjedi',
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stack) => Container(),
        loading: () => const HomePageLoading(),
      ),
      floatingActionButton: ref.watch(peopleProvider.notifier).isLoadingPagination == true ? const HomePageRefreshLoading() : Container(),
    );
  }
}
