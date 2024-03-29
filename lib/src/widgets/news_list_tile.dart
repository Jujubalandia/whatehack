import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whatehack/src/widgets/load_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';

class NewListTile extends StatelessWidget {
  final int itemId;

  NewListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }
              return buildTile(itemSnapshot.data);
            });
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score ?? 0} points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.type}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
