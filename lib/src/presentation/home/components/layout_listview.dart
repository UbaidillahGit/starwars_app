import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/application/prov_people.dart';
import 'package:starwars_app/src/application/prov_scroll_notifier.dart';
import 'package:starwars_app/src/presentation/detail/detail_page.dart';

class LayoutListview extends ConsumerWidget {
  const LayoutListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchPeople = ref.watch(peopleProvider); ///_____ Watch people data
    return ListView.builder(
      itemCount: watchPeople.value?.results?.length ?? 0,
      shrinkWrap: true,
      controller: ref.watch(scrollProvider.notifier).scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute( ///_____ Route to people detail
              builder: (_) => PeopleDetailPage(detailUrl: watchPeople.value?.results?[index].url ?? ''),
            ));
          },
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
                          '${watchPeople.value?.results?[index].name}',
                          style: const TextStyle(fontFamily: 'Starjedi', color: Colors.white, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${watchPeople.value?.results?[index].birthYear}',
                          style: const TextStyle(
                            fontFamily: 'Starjedi',
                            color: Colors.white,
                            fontSize: 18,
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
    );
  }
}
