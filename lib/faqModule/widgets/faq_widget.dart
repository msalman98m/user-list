import 'package:flutter/material.dart';
import 'package:userlist/theme/theme_extension.dart';

class FaqWidget extends StatefulWidget {
  final String question;
  final String answer;
  const FaqWidget({super.key, required this.question, required this.answer});

  @override
  FaqWidgetState createState() => FaqWidgetState();
}

class FaqWidgetState extends State<FaqWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.colors.cardBackground,
          borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      padding: isExpanded == true
          ? EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.05)
          : const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onFocusChange: (expanded) {
              setState(() {
                isExpanded = expanded;
              });
            },
            title: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01),
              child: Text(
                widget.question,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 11, color: context.colors.heading),
              ),
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            trailing: Icon(
              isExpanded ? Icons.close : Icons.add,
              color: context.colors.brandColor,
              size: 18,
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06),
              child: Text(
                widget.answer,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 10,
                      color: context.colors.subheading,
                      height: 1.75,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
