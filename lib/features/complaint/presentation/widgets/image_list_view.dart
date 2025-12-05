import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesListView extends StatelessWidget {
  final List<String> images;

  const ImagesListView({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            images[index],
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
        );
      },
    );
  }
}
