import 'package:flutter/material.dart';
import 'package:news/src/services/news_services.dart';
import 'package:news/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab1Page extends StatefulWidget {

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsServices>(context).headlines;
    //newsService.headlines
    //ListaNoticias(key, headlines)
    return Scaffold(
      body: (headlines.length == 0)
          ? Center(child: CircularProgressIndicator(),)
          : ListaNoticias(headlines)
   );
  }

  @override
  bool get wantKeepAlive => true;
}