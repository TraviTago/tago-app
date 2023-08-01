import 'package:flutter/material.dart';

class PersonCounter extends StatefulWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const PersonCounter({
    Key? key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  PersonCounterState createState() => PersonCounterState();
}

class PersonCounterState extends State<PersonCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: const Color(0xFFDADADA),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              splashRadius: 18,
              onPressed: widget.count > 1 ? widget.onDecrement : null,
              icon: Icon(
                Icons.remove,
                size: 18.0,
                color: widget.count > 1
                    ? const Color(0xFF595959)
                    : const Color(0xFFDADADA),
              ),
            ),
            Text(
              '${widget.count}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              splashRadius: 18,
              onPressed: widget.onIncrement,
              icon: const Icon(
                Icons.add,
                size: 18.0,
                color: Color(0xFF595959),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
