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
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    List<String> getLanguages() {
      return languages.where((element) => element != selectedLanguage).toList();
    }

    bool isMobileVersion() {
      return MediaQuery.of(context).size.width < 915;
    }

    void showLanguagePicker() {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: isMobileVersion() ? const Radius.circular(15) : Radius.zero,
            topRight: isMobileVersion() ? const Radius.circular(15) : Radius.zero,
            bottomLeft: const Radius.circular(15),
            bottomRight: const Radius.circular(15),
          ),
        ),
        items: getLanguages().map((String language) {
          return PopupMenuItem<String>(
            value: language,
            child: SizedBox(
              // width: button.size.width,
              child: Center(
                child: Text(
                  language,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
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


    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: showLanguagePicker,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(10),
              topLeft: const Radius.circular(10),
              bottomRight: Radius.circular(isOpened && !isMobileVersion() ? 0 : 10),
              bottomLeft: Radius.circular(isOpened && !isMobileVersion() ? 0 : 10),
            ),
            color: isHovered
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.25)
                : Theme.of(context).colorScheme.onBackground,
          ),
          height: 50,
          width: 130,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedLanguage,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
      ),
    );
  }
}
