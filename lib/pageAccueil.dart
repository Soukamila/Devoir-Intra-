import 'package:flutter/material.dart';
import 'api_service.dart'; 
import 'models.dart';
import 'pageRecherche.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  int _navpage =0;
   List <Movie> Movies = [];

  void getAllMovies()async {
    dynamic listMovs = await APIService.get( 'https://api.tvmaze.com/shows'); 
     
    
     setState(() {
            Movies=  listMovs.map<Movie>((mv)=> Movie.fromJson(mv)).toList();
          });
  }

  @override
  void initState(){
    super.initState();
    getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(

      appBar: AppBar(
        
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.blue
      ),
      // body: Center(
        
      
      //   child: ElevatedButton(
      //     child: Text ("Get Movies"),
      //   onPressed:(){
      //       getAllMovies();
      //     }
      //  )
      // 
     // ),
     
     body: _navpage ==2

     ?const Recherche()
     :SingleChildScrollView(
      child:Column(
        children: Movies.map((Movie mov){
          return MovieWidget(mov); 
        }).toList(),
      )
     ),
     bottomNavigationBar:_BottomNav(_navpage,onTap: (idx){
      setState(() {
              _navpage= idx;
            });
     },)
    );

    
  }
}

Widget MovieWidget(Movie mov){
 return Column(
            children: [
          Text (mov.name),
          mov.image != null
? Image.network(mov.image!): SizedBox(),
          Text (mov.summary.toString()),
    //       mov.summary != null
    // ? Text(
    //     mov.summary!.replaceAll(RegExp(r'<[^>]*>'), ''),
    //   )
   // : Text("Pas de résumé")
          ]
          );
  }

class _BottomNav extends StatelessWidget {
  final int i;
  final Function(int) onTap;

  _BottomNav(this.i,{required this.onTap});
  @override
  Widget build(BuildContext c) => BottomNavigationBar(
    currentIndex: i,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    onTap: onTap,
    
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
      BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Films'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Recherche'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,
                                          color: Colors.red), label: 'Favoris'),
      
    ],
  );
}
