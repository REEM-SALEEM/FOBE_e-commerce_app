import 'package:flutter/material.dart';

class PreviewCATWidget extends StatelessWidget {
  const PreviewCATWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final List<String> image;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 80,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    'http://172.16.8.138:5000/products/${image[index]}',
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox();
          },
          itemCount: image.length,
        ),
      ),
    );
  }
}
