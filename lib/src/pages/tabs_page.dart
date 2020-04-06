import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
        child: Scaffold(
          body: _Paginas(),
          bottomNavigationBar: _Navegacion(),
        ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
      BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados'))
    ],
    currentIndex: navegacionModel.paginaActual,
    onTap: (i) => navegacionModel.paginaActual = i);
  }
}


class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Container(color: Colors.green,)
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{
  int _paginaActual = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    this._pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners(); 
  }

  get pageController => this._pageController;

}