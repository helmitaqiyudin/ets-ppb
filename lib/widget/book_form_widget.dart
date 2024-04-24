import 'package:flutter/material.dart';

class BookFormWidget extends StatelessWidget {
  final String? title;
  final String? coverUrl;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedCoverUrl;
  final ValueChanged<String> onChangedDescription;

  const BookFormWidget({
    Key? key,
    this.title = '',
    this.coverUrl = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedCoverUrl,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(height: 8),
              buildCoverUrl(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildCoverUrl() => TextFormField(
    maxLines: 1,
    initialValue: coverUrl,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'cover url link',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (coverUrl) =>
    coverUrl != null && coverUrl.isEmpty ? 'The cover cannot be empty' : null,
    onChanged: onChangedCoverUrl,
  );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}
