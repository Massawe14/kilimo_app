import 'package:flutter/material.dart';

import '../../../../../util/constants/text_strings.dart';
import 'question_card.dart';

class TCropList extends StatelessWidget {
  const TCropList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (_, index) {
        return const TQuestionCard(
          image: 'assets/images/crops/maize.jpeg',
          title: TTexts.maizeCropTitle,
          description: TTexts.maizeCropDescription,
        );
      },
    );
  }
}
