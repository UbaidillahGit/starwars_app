import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/application/prov_people.dart';
import 'package:starwars_app/src/presentation/home/components/home_refresh_loading.dart';
import 'package:starwars_app/src/presentation/home/components/layout_gridview.dart';
import 'package:starwars_app/src/presentation/home/components/layout_listview.dart';
import 'package:starwars_app/src/presentation/search/search_page.dart';
import 'package:starwars_app/src/presentation/utils/home_loading.dart';

final layoutGridProvider = StateProvider<bool>((ref) => false);


class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  ///_____ Call API data for all Species/Character
  _init() {
    ref.read(peopleProvider.notifier).getPoeple();
  } 

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(peopleProvider); ///_____ Watch for people/character data
    final watchGridLayout = ref.watch(layoutGridProvider); ///_____ Watch for layout changes

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
        leading: IconButton(
          onPressed: () {
            if (watchGridLayout) {
              ref.read(layoutGridProvider.notifier).update((state) => false);
            } else {
              ref.read(layoutGridProvider.notifier).update((state) => true);
            }
          },
          icon: Icon(watchGridLayout ? Icons.grid_view_rounded : Icons.view_list_rounded, color: Colors.white),
        ),
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
            child: watchGridLayout == true ? const LayoutGridview() : const LayoutListview(),
          );
        },
        error: (error, stack) => Container(),
        loading: () => const HomePageLoading(),
      ),
      floatingActionButton: ref.watch(peopleProvider.notifier).isLoadingPagination == true ? const HomePageRefreshLoading() : Container(),
    );
  }
}
