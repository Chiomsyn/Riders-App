import 'package:flutter/material.dart';

import '../../../core/global/colors.dart';

class DefaultBottomWidget extends StatefulWidget {
  VoidCallback onClick;
  ScrollController? scrollController;
  DefaultBottomWidget(
      {required this.onClick, required this.scrollController, super.key});

  @override
  State<DefaultBottomWidget> createState() => _DefaultBottomWidgetState();
}

class _DefaultBottomWidgetState extends State<DefaultBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      color: bgColor(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 8.0,
                width: 70.0,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: widget.onClick,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: drawerProfileBgColor(context)),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(Icons.search)),
                    const Text(
                      "Where are you going to?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 20,
                controller: widget.scrollController,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.history),
                    title: Text('Address: $index'),
                    subtitle: Text('City: $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
