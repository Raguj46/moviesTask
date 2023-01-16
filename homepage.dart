import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ragumovie/cubit/movielist_cubit.dart';

import '../model/movielistmodel.dart';
import 'info.dart';
class HomepageWidget extends StatefulWidget {
  const HomepageWidget({Key? key}) : super(key: key);

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  @override
  void initState() {
    context.read<MovielistCubit>().GetmovieList();
    super.initState();
  }
  bool ascend=true;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8,),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-140,
                  height: 42,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (String query){
                      context.read<MovielistCubit>().search(query);
                    },
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2,color: Colors.black),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2,color: Colors.black),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2,color: Colors.black),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Search',
                    ),
                  )
                ),
                const SizedBox(width: 6,),
                (ascend)?
                    InkWell(
                        onTap: (){
                          context.read<MovielistCubit>().sort(1);
                          setState(() {
                            ascend=false;
                          });
                        },

                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.green,width: 2)),
                        child: Row(children: const [
                          Text('Ascending'),
                          SizedBox(width: 2,),
                          Icon(Icons.arrow_circle_down_rounded)
                        ],),
                      ),
                    ):
                InkWell(
                        onTap: (){
                          context.read<MovielistCubit>().sort(0);
                          setState(() {
                            ascend=true;
                          });
                        },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.redAccent,width: 2)),
                        child: Row(children: const [
                          Text('Descending'),
                          SizedBox(width: 2,),
                          Icon(Icons.arrow_circle_up_rounded)
                        ],),
                      ),
                    )

              ],
            ),
              const SizedBox(height: 12,),
              BlocBuilder<MovielistCubit, MovielistState>(
        builder: (context, state) {
          print(state.runtimeType);
          if(state is MovielistLoaded){
            List<MovieListModel> datalist=[];
            datalist=state.datalist;
            print(datalist.length);
          return Container(
                height: MediaQuery.of(context).size.height-180,
                child:GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.88
                    ),
                    itemCount: datalist.length,
                    itemBuilder: (BuildContext,index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 2,bottom: 6.0,right: 2,top: 2),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoWidget(data: datalist[index],)));
                      },
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    const SizedBox(width:1),
                                    Container(
                                      height: 96,
                                    child: CachedNetworkImage(
                                      imageUrl: "https://image.tmdb.org/t/p/original${datalist[index].posterPath}",
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                      errorWidget: (context, url, error) => const Icon(Icons.local_movies_outlined),
                                    ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 4,),
                              Text("${datalist[index].title}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4,),
                              Text("Popularity : ${datalist[index].popularity}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }, ) ,);}else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                 Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
  },
)
          ],),
        ),
      );
  }
}
