import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final bool backBtnComponent;
  final Widget? titleComponet;
  final Widget? titleComponetWithoutPop;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? titleCompnentWithPrimaryColor;
  final VoidCallback? popMethod;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.titleComponet,
    this.titleComponetWithoutPop,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.titleCompnentWithPrimaryColor,
    this.backBtnComponent = false,
    this.popMethod,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      body: (floatingActionButton == null)
          ? child
          : Stack(
              children: <Widget>[
                child,
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Center(child: floatingActionButton!),
                ),
              ],
            ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (popMethod != null) {
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
            onPressed: popMethod,
          ),
        ),
        title: titleComponet,
        foregroundColor: Colors.black,
      );
    }

    if (titleComponetWithoutPop != null) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: titleComponetWithoutPop,
        foregroundColor: Colors.black,
      );
    }
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
                color: LABEL_TEXT_SUB_COLOR,
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
                color: LABEL_TEXT_SUB_COLOR,
                size: 34,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ));
    }
    if (titleCompnentWithPrimaryColor != null) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: PRIMARY_COLOR,
              size: 34,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: titleCompnentWithPrimaryColor,
        foregroundColor: Colors.black,
      );
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
