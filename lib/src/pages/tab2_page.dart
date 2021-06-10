import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:news/src/models/category_model.dart';
import 'package:news/src/services/news_services.dart';
import 'package:news/src/theme/tema.dart';
import 'package:news/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
 
    final newsService =  Provider.of<NewsServices>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            Expanded(
              child: ListaNoticias(newsService.getArticulosCategoriaSeleccionada),
            ),
          ],
        ),
   ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsServices>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              _CategoryButton(categories[index]),
              SizedBox(height: 5,),
              Text('${cName[0].toUpperCase()}${cName.substring(1)}')
            ],
          ),
        );
       },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;


  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {

    final newsServices = Provider.of<NewsServices>(context);

    return GestureDetector(
      onTap: () {
        final newsServices = Provider.of<NewsServices>(context, listen:false);
        newsServices.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal:10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsServices.selectedCategory == this.categoria.name) 
               ? miTema.accentColor
               : Colors.black54,
        ),
      ),
    );
  }
}