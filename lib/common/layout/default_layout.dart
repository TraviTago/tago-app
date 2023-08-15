import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final bool backBtnComponent;
  final Widget? titleComponet;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.titleComponet,
    this.bottomNavigationBar,
    this.backBtnComponent = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (backBtnComponent) {
      return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const SizedBox(
            width: double.infinity,
            child: Text(
              '홈으로 돌아가기',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xFF595959),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
              splashRadius: 0.1,
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF595959),
                size: 34,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ));
    }
    if (titleComponet != null) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
              size: 34,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: titleComponet,
        foregroundColor: Colors.black,
      );
    } else if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
