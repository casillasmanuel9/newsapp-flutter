import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
        child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(child: 
            (newsService.articulosCategoriaSeleccionada.length == 0 ) 
            ? Center(child: CircularProgressIndicator(),) 
            : ListaNoticias(newsService.articulosCategoriaSeleccionada),)
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80, 
          child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          return Container(
            child: Column(
              children: <Widget>[
                _CategoryButton(categoria: categories[index]),
                SizedBox(height: 5,),
                Text('$cName')
              ],
            ),
            padding: EdgeInsets.all(8)
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    Key key,
    @required this.categoria,
  }) : super(key: key);

  final Category categoria;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = Provider.of<NewsService>(context).selectedCategory;


    return GestureDetector(
      onTap: () {
        final newsServices = Provider.of<NewsService>(context, listen: false);
        newsServices.selectedCategory = categoria.name;
        },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(categoria.icon, color: (selectedCategory == categoria.name) ? Theme.of(context).accentColor : Colors.black54,),
      ),
    );
  }
}