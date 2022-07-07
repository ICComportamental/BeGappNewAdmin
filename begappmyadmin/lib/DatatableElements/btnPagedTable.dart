import 'package:flutter/material.dart';

class PagedTableButtons extends StatelessWidget {
  final Function previous;
  final Function next;

  const PagedTableButtons({
    Key? key,
    required this.previous,
    required this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
          onTap: () => previous(),
          child: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () => next(),
          child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.purple, shape: BoxShape.circle),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )),
        ),
      ]),
    );
  }
}
