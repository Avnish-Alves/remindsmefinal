import 'package:flutter/material.dart';
import 'package:loc/data/app_states.dart';
import 'package:loc/pages/reminders_new.dart';
import 'package:loc/widgets/place_holders.dart';
import 'package:provider/provider.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    final appStates = Provider.of<AppStates>(context);

    return appStates.favoriteAll().isEmpty
        ? const EmptySpace(comment: 'Add favorites')
        : ListView.builder(
            itemCount: appStates.favoriteAll().length,
            addAutomaticKeepAlives: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (context) {
                          final place = appStates.favoriteRead(index)!;
                          return RemindersNew(
                            latitude: place.position.latitude.toString(),
                            longitude: place.position.longitude.toString(),
                            radius: place.radius.toString(),
                          );
                        },
                      ),
                    );
                  },
                  child: ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.favorite_rounded,
                      size: 32,
                    ),
                    subtitle: Text(
                      '${appStates.favoriteAll()[index].position.latitude}, ${appStates.favoriteAll()[index].position.longitude}',
                      style: const TextStyle(
                        fontFamily: 'Fantasque',
                      ),
                    ),
                    title: Text(
                      '${appStates.favoriteAll()[index].displayName}',
                      style: const TextStyle(
                        fontFamily: 'NotoArabic',
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
