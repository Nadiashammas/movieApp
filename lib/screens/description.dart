import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final String name, image, info;
  final int id;
  final List images;
  const Description({
    Key? key,
    required this.name,
    required this.image,
    required this.info,
    required this.id,
    required this.images,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.network(widget.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Text(
                  widget.info,
                  style: TextStyle(fontSize: 20, height: 1.8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.5,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: widget.images.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                          onTap: () {
                            print('tapped');
                          },
                          child: Image.network(
                              'https://image.tmdb.org/t/p/w500' +
                                  widget.images[index]['file_path'].toString()),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
