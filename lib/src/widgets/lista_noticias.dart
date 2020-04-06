import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;
 
  const ListaNoticias( this.noticias );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 10),
          child: ListView.builder(
        itemCount : this.noticias.length,
        itemBuilder: (BuildContext context, int index) {
          return Noticia( noticia: noticias[index], index: index);
        },
      ),
    );
  }
}


class Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const Noticia({
    @required this.noticia,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia: this.noticia, index: this.index,),
        _TarjetaTitulo(noticia: this.noticia),
        _TarjetaImagen(noticia: this.noticia),
        _TarjetaBody(noticia: this.noticia),

        _TarjetaBotonoes(),

        SizedBox(height: 10,),
        Divider()
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar({
    @required this.noticia,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10.0 ),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text('${index + 1}', style: TextStyle(color: miTema.accentColor),),
          Text('${noticia.source.name}', )
        ],
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;

  const _TarjetaTitulo({
    @required this.noticia,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(this.noticia.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {

  final Article noticia;

  const _TarjetaImagen({
    @required this.noticia,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(50)),
          child: Container(
          child: (noticia.urlToImage != null) ?
           FadeInImage(
            placeholder: AssetImage('assets/img/giphy.gif'), 
            image: NetworkImage(noticia.urlToImage)
          ) : 
          Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody({
    @required this.noticia,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: (this.noticia.description != null ) ? 
      Text(this.noticia.description):
      Text('data')
    );
  }
}

class _TarjetaBotonoes extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: (){}, 
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: miTema.accentColor,
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10,),
          RawMaterialButton(
            onPressed: (){}, 
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.blue,
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}