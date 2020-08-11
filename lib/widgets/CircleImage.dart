part of m7utils;
class CircleImage extends StatelessWidget {
  final double size;
  final ImageProvider image;

  const CircleImage({this.image,this.size}) ;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: this.image,fit: BoxFit.fill),
      ),

    );
  }
}
