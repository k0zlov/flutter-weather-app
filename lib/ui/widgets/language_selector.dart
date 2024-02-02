import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String selectedLanguage = 'English';
  List<String> languages = ['Spanish', 'French', 'German', 'English'];
  bool isOpened = false;

  List<String> getLanguages() {
    return languages.where((element) => element != selectedLanguage).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showLanguagePicker,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(10),
            topLeft: const Radius.circular(10),
            bottomRight: Radius.circular(isOpened ? 0 : 10),
            bottomLeft: Radius.circular(isOpened ? 0 : 10),
          ),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        height: 45,
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedLanguage,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                    ),
              ),
              Icon(
                isOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguagePicker() {
    setState(() {
      isOpened = true;
    });
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, button.size.height), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu<String>(
      constraints: BoxConstraints(minWidth: button.size.width),
      color: Theme.of(context).colorScheme.onBackground,
      context: context,
      position: position,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      items: getLanguages().map((String language) {
        return PopupMenuItem<String>(
          textStyle: Theme.of(context).textTheme.bodyMedium,
          value: language,
          child: SizedBox(
            // width: button.size.width,
            child: Center(child: Text(language)),
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedLanguage = value;
        });
      }
      Future.delayed(
        const Duration(milliseconds: 250),
        () => setState(() => isOpened = false),
      );
    });
  }
}
