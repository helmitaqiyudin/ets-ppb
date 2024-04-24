import 'package:flutter/material.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import '../widget/book_form_widget.dart';

class AddEditBookPage extends StatefulWidget {
  final Book? book;

  const AddEditBookPage({
    super.key,
    this.book,
  });

  @override
  State<AddEditBookPage> createState() => _AddEditBookPageState();
}

class _AddEditBookPageState extends State<AddEditBookPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String coverUrl;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.book?.title ?? '';
    coverUrl = widget.book?.coverUrl ?? '';
    description = widget.book?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: BookFormWidget(
        title: title,
        coverUrl: coverUrl,
        description: description,
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedCoverUrl: (coverUrl) => setState(() => this.coverUrl = coverUrl),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey[5200],
        ),
        onPressed: addOrUpdateBook,
        child: const Text('Save', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  void addOrUpdateBook() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.book != null;

      if (isUpdating) {
        await updateBook();
      } else {
        await addBook();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateBook() async {
    final book = widget.book!.copy(
      title: title,
      coverUrl: coverUrl,
      description: description,
    );

    await BooksDatabase.instance.update(book);
  }

  Future addBook() async {
    final book = Book(
      title: title,
      coverUrl: coverUrl,
      description: description,
      createdTime: DateTime.now(),
    );

    await BooksDatabase.instance.create(book);
  }
}
