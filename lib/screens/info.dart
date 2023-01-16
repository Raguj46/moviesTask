import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/movielistmodel.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key,required this.data}) : super(key: key);
  final MovieListModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(data.originalTitle.toString()),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        // padding: const EdgeInsets.all(8),
        child: Padding(
                padding: const EdgeInsets.only(left: 2,bottom: 6.0,right: 2,top: 2),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 1
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children:  [
                            const Text("Movie Name :",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                            const SizedBox(width: 2,),
                            Expanded(child: Text("${data.title}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold))),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children:  [
                            const Text("Popularity :",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                            const SizedBox(width: 2,),
                            Text("${data.popularity}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children:  [
                            const Text("Release Date :",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                            const SizedBox(width: 2,),
                            Text("${data.releaseDate}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              const SizedBox(width:1),
                              Container(
                                height: 200,
                                width: 200,
                                child: CachedNetworkImage(
                                  imageUrl: "https://image.tmdb.org/t/p/original${data.posterPath}",
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          child: const Text('Overview',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 12,),
                        Expanded(
                          child: Text("${data.overview}"),)
                      ],
                    ),
                  ),
                ),
              ) ,),
    );
  }
}
