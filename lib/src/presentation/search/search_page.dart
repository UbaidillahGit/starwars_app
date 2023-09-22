
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_text.dart';
import 'package:starwars_app/src/application/prov_search.dart';
import 'package:starwars_app/src/presentation/detail/detail_page.dart';
import 'package:starwars_app/src/presentation/utils/debouncer.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_loading.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  ///_____ Timer to delay callback while user typing a keyword
  ///_____ so API will only called when user completed the keyword typing
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        title: TextFormField(
          style: const TextStyle(color: Colors.white),
          onChanged: (value) => _debouncer.run(() => ref.read<HomeSearchNotifier>(searchProvider.notifier).search(keyword: value)),
          decoration: const InputDecoration(
            hintText: 'Search Character',
            fillColor: Colors.white,
            focusColor: Colors.white,
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: ref.watch(searchProvider)?.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ((){
                  if (data.results?.isNotEmpty == true) {
                    return ListView.builder(
                      itemCount: data.results?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PeopleDetailPage(detailUrl: data.results?[index].url ?? ''),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              '${data.results?[index].name}',
                              style: const TextStyle(fontFamily: 'Starjedi', color: Colors.white),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CustomText().starjediWhite(txt: 'Character Not Found'),
                    ); 
                  }
                }()),
              );
            },
            error: (error, stackTrace) {
              return const Text(
                'Type Something',
                style: TextStyle(fontFamily: 'Starjedi', color: Colors.white),
              );
            },
            loading: () => const Center(
              child: CustomLoadingOne(title: 'Loading...'),
            ),
          ),
    );
  }
}
