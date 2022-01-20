import 'package:dulces/main.dart';
import 'package:dulces/screen/lateral_menu.dart';
import 'package:flutter/material.dart';
import 'package:dulces/theme/app_theme.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'carrito'),
            child: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 35.0,
            ),
          ),
        ],
      ),
      drawer: const LateralMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              typeProduct(Colors.white, AppTheme.primary, 'Chocolates'),
              typeProduct(AppTheme.primary, Colors.white, 'Galletas'),
              typeProduct(Colors.white, AppTheme.primary, 'Chicles'),
              typeProduct(AppTheme.primary, Colors.white, 'Chupetes'),
              typeProduct(Colors.white, AppTheme.primary, 'Caramelos'),
            ],
          ),
        ),
      ),
    );
  }

  Widget typeProduct(Color colorText, Color colorBg, String text) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: colorText),
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        child: Text(
          text,
          style: TextStyle(
              color: colorBg, fontSize: 64.0, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TypeProductos(identification: text)),
      ),
    );
  }
}

class TypeProductos extends StatefulWidget {
  final String identification;
  const TypeProductos({Key? key, required this.identification})
      : super(key: key);

  @override
  State<TypeProductos> createState() => _TypeProductosState();
}

class _TypeProductosState extends State<TypeProductos> {
  late Map<String, dynamic> dataCategory;
  late List<dynamic> data = dataCategory['data'];
  @override
  void initState() {
    super.initState();
    dataCategory = DB.getData(widget.identification.toString());
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.lightBlueAccent;
      }
      return Colors.lightBlueAccent;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(dataCategory['name'].toUpperCase()),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Card(
          elevation: 10,
          child: Column(
            children: [
              ListTile(
                title: Text(data[index]['name']),
                subtitle: Text(data[index]['price']),
              ),
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      data[index]['url_image'],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () =>
                        MyApp().cart_shopping_list.addAll(dataCategory),
                    child: Text(
                      'agregar'.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: data.length,
      ),
    );
  }
}

class DB {
  static final List<Map<String, dynamic>> data = [
    {
      "name": "chocolates",
      "data": [
        {
          "id": 1,
          "name": " KitKat",
          "price": "1.10",
          "url_image":
              "https://tiaecuador.vteximg.com.br/arquivos/ids/164280-1000-1000/262722000.jpg?v=637061525815770000"
        },
        {
          "id": 2,
          "name": " Kinder",
          "price": "2.50",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 3,
          "name": " Huesitos",
          "price": "1.15",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 4,
          "name": " Lacasitos",
          "price": "1.50",
          "url_image":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgHRHFC-8E-IcOenYts9IGOxbkXoySOuZEKN-FHA7Lvd_7Yjt5l4WURqzq7yyEdYP7VmI&usqp=CAU"
        },
        {
          "id": 5,
          "name": " Filipinos",
          "price": "1.75",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 6,
          "name": " Conguitos",
          "price": "1.00",
          "url_image":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlUrEBnJXUMK3V-iinXScY_RwLuknIpNCLffV_7VdV3hvj-qstrXbgQULjadc6b-McHlI&usqp=CAU"
        },
        {
          "id": 7,
          "name": " M&Ms",
          "price": "2.75",
          "url_image":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrC4CtSYOfiO5XTsJm51XCG5PLIwwgDtDg_Vl22OmGZqhk_hPNDe4S1-BDmB4Dxv_cWwg&usqp=CAU"
        },
        {
          "id": 8,
          "name": " Twix",
          "price": "1.50",
          "url_image":
              "https://media.istockphoto.com/photos/twix-chocolate-candy-bars-unwrapped-picture-id458129283?s=612x612"
        },
        {
          "id": 9,
          "name": " Snickers",
          "price": "1.00",
          "url_image":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxpxQ0BebBSK2QMxTXoSAY9DONG1y5mJ3fp0TccUb9EFAphrrXEvH_ktJT6hOmHzi3r_Q&usqp=CAU"
        },
        {
          "id": 10,
          "name": " Tokke",
          "price": "2.10",
          "url_image":
              "https://i0.wp.com/golmarymar.com.ar/wp-content/uploads/ComboTokke72.jpg?fit=600%2C600&ssl=1"
        },
        {
          "id": 11,
          "name": " Smarties",
          "price": "1.50",
          "url_image":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnRXIcy1a8FZphYNMZ1rkvr3T_rR-lfXJqIELWnwAsCkPxlQzrolpbWZQ4Ec0fTe2SANQ&usqp=CAU"
        },
        {
          "id": 12,
          "name": " Hershey's",
          "price": "2.00",
          "url_image":
              "https://ardiaprod.vteximg.com.br/arquivos/ids/204948-500-500/Chocolate-Hershey-s-con-Leche-20-Gr-_1.jpg?v=637605746530500000"
        },
        {
          "id": 13,
          "name": " Bounty",
          "price": "1.20",
          "url_image":
              "https://i0.wp.com/thesweetseria.com/wp-content/uploads/2021/11/Bounty-Chocolate-57g-1.png?fit=600%2C600&ssl=1"
        },
        {
          "id": 14,
          "name": " Galak",
          "price": "2.65",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 15,
          "name": " Ferrero",
          "price": "3.25",
          "url_image":
              "2wCEAAoHCBEREhgSEREYERESERESGBgREhIYGBIYGBgZGRgYGBgcIS4lHB4rIRgYJjgmKy8xNTU1GiQ7QDs0Py40NTEBDAwMEA8QHhISGjcsJCw0NDQxNDQ0NDQxNDQxNDQ0NDQ0NDQ0NDQ0NDg0NDQ0NDQ0NDQ0NDQ0NjY0NDQ0NDQ0NP"
        },
      ],
    },
    {
      "name": "galletas",
      "data": [
        {
          "id": 1,
          "name": " Oreo",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fd500.epimg.net%2Fcincodias%2Fimagenes%2F2016%2F04%2F29%2Fsentidos%2F1461959122_683760_1461959181_noticia_normal.jpg&imgrefurl=https%3A%2F%2Fcincodias.elpais.com%2Fcincodias%2F2016%2F04%2F29%2Fsentidos%2F1461959122_683760.html&tbnid=QeBsFij4I74nsM&vet=12ahUKEwiWlaCKq7_1AhWiwCkDHUs0CkgQMygLegUIARD-AQ..i&docid=7QoKrGbAN8W3oM&w=664&h=310&q=galleta%20oreo&ved=2ahUKEwiWlaCKq7_1AhWiwCkDHUs0CkgQMygLegUIARD-AQ"
        },
        {
          "id": 2,
          "name": " Amor",
          "price": "2.25",
          "url_image":
              "https://www.google.com/imgres?imgurl=http%3A%2F%2Ffotosapp.liris.com.ec%2FImgAX%2F324%2F7861091158109.jpg&imgrefurl=http%3A%2F%2Fmobile.liris.com.ec%2Fdelportal%2Fproduct%2Famor-wafers-pekes-130-gr%2F&tbnid=HtlfP6B0JFzEzM&vet=12ahUKEwi4mcuerL_1AhVSwikDHVXMCasQMygCegUIARDIAQ..i&docid=KS8-bMRZPubs_M&w=324&h=250&itg=1&q=galleta%20amor%20de%20leche&ved=2ahUKEwi4mcuerL_1AhVSwikDHVXMCasQMygCegUIARDIAQ"
        },
        {
          "id": 3,
          "name": " Crackets",
          "price": "1.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcrackets.com.mx%2Finclude%2Fimg%2Fproduct%2Frender-crackets-89g.png&imgrefurl=https%3A%2F%2Fcrackets.com.mx%2F&tbnid=4yIXD_rcJgYp9M&vet=12ahUKEwi8ouLBrL_1AhXKHN8KHaCiCfAQMygEegUIARDHAQ..i&docid=IXS5mgxxidkcRM&w=2397&h=739&itg=1&q=galleta%20ckackets&ved=2ahUKEwi8ouLBrL_1AhXKHN8KHaCiCfAQMygEegUIARDHAQ"
        },
        {
          "id": 4,
          "name": " Ricas",
          "price": "1.75",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Ftiaecuador.vteximg.com.br%2Farquivos%2Fids%2F164293-1000-1000%2F261931000.jpg%3Fv%3D637061526027330000&imgrefurl=https%3A%2F%2Fwww.tia.com.ec%2Fgalletas-saladas-ricas-caja-268-g-261931000%2Fp&tbnid=ifcg8ABQjxsnTM&vet=12ahUKEwiAg5HvrL_1AhVGHN8KHQrgBRMQMygBegUIARDiAQ..i&docid=L6LlUsvZi7-LlM&w=1000&h=1000&q=galleta%20rikas&ved=2ahUKEwiAg5HvrL_1AhVGHN8KHQrgBRMQMygBegUIARDiAQ"
        },
        {
          "id": 5,
          "name": " Arthur",
          "price": "1.30",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fa0.soysuper.com%2F5f1b9556c3eac3ef692d3be4b54ab599.1500.0.0.0.wmark.ed51505f.jpg&imgrefurl=https%3A%2F%2Fsoysuper.com%2Fp%2Fgalletas-rellenas-de-chocolate-arthur-3-paquetes-de-250-gramos&tbnid=iHAwWVoAdlKVeM&vet=12ahUKEwj_l6mhrb_1AhWGn-AKHdVQD3IQMygFegUIARDFAQ..i&docid=RJrys9ptz-WioM&w=1500&h=1250&itg=1&q=galleta%20arthur&ved=2ahUKEwj_l6mhrb_1AhWGn-AKHdVQD3IQMygFegUIARDFAQ"
        },
        {
          "id": 6,
          "name": " Ducales",
          "price": "2.05",
          "url_image":
              "https://www.google.com/search?q=galleta+ducales&client=ms-android-samsung-gj-rev1&prmd=ivmxn&sxsrf=AOaemvKf2c4lRsBLDjixoxOGlj3SkukEAQ:1642648102595&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiM95SFrb_1AhX0RjABHXceChIQ_AUoAXoECAIQAQ&biw=412&bih=829&dpr=2.63#imgrc=IqyyixjYvis31M"
        },
        {
          "id": 7,
          "name": " Ritz",
          "price": "1.95",
          "url_image":
              "https://mercaldas.vtexassets.com/arquivos/ids/199404/Galleta-RITZ-saladas-taco-x67g_79065.jpg?v=637354712411570000"
        },
        {
          "id": 8,
          "name": " Maria",
          "price": "2.05",
          "url_image":
              "https://i0.wp.com/lanoticia.com/wp-content/uploads/2021/04/galleta-maria.jpeg?fit=640%2C389&ssl=1"
        },
        {
          "id": 9,
          "name": " Krit",
          "price": "2.10",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fdateuncapricho.aperitivossnack.com%2F1051-large_default%2Fkrititas-tiras-40gr.jpg&imgrefurl=https%3A%2F%2Fdateuncapricho.aperitivossnack.com%2Fgalletas%2F789-krititas-tiras-40gr-8410014321916.html&tbnid=js4oxBETqUgfUM&vet=12ahUKEwjI6IXnrb_1AhXSwCkDHWPsAjYQMygLegUIARDDAQ..i&docid=RQBKCL1PtAEHRM&w=420&h=420&itg=1&q=galleta%20krit&ved=2ahUKEwjI6IXnrb_1AhXSwCkDHWPsAjYQMygLegUIARDDAQ"
        },
        {
          "id": 10,
          "name": " Club Social",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fyaperito.com%2Fshop%2Fwp-content%2Fuploads%2F2020%2F08%2FGalleta-club-social-26g.jpg&imgrefurl=https%3A%2F%2Fyaperito.com%2Fshop%2Fproducto%2Fgalletas-club-social-original-26-g%2F&tbnid=1EEjim8VaqbzeM&vet=12ahUKEwiE3deJrr_1AhXKHN8KHao8ClQQMygDegUIARDcAQ..i&docid=njDcDZMFRwiXMM&w=900&h=962&itg=1&q=galleta%20clun%20social&ved=2ahUKEwiE3deJrr_1AhXKHN8KHao8ClQQMygDegUIARDcAQ"
        },
        {
          "id": 11,
          "name": " Festival",
          "price": "1.95",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmercaldas.vtexassets.com%2Farquivos%2Fids%2F155983%2F68185.jpg%3Fv%3D636885396883030000&imgrefurl=https%3A%2F%2Fwww.mercaldas.com%2Fgalletas-festival-surtida-x12-paquetes-%2Fp&tbnid=cldTqGdp57mgLM&vet=12ahUKEwj8k_2srr_1AhWGG98KHcX5Db0QMygGegUIARDzAQ..i&docid=_RVENYsCA6AwgM&w=1000&h=1000&itg=1&q=galleta%20festival&ved=2ahUKEwj8k_2srr_1AhWGG98KHcX5Db0QMygGegUIARDzAQ"
        },
        {
          "id": 12,
          "name": " Chiky",
          "price": "2.10",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fdelvalleie.com%2Fwp-content%2Fuploads%2F2021%2F01%2Fchiky.png&imgrefurl=https%3A%2F%2Fdelvalleie.com%2Fproducto%2Fchiky-galletas%2F&tbnid=JQ_UwzjvdCu8CM&vet=12ahUKEwjQ-pTcrr_1AhUFAN8KHbXPDcgQMygKegUIARDzAQ..i&docid=BLTncO1XJUUq1M&w=940&h=788&itg=1&q=galleta%20chiky&ved=2ahUKEwjQ-pTcrr_1AhUFAN8KHbXPDcgQMygKegUIARDzAQ"
        },
        {
          "id": 13,
          "name": " Rellenitas",
          "price": "1.30",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fdojiw2m9tvv09.cloudfront.net%2F57428%2Fproduct%2Fgalletarellenitasgnchocolatepack8und36gr4831.jpg&imgrefurl=https%3A%2F%2Fwww.dorita.pe%2Fproduct%2Fgalleta-rellenitas-gn-chocolate-pack-8-und-36-gr&tbnid=X-6AKtLrHl0ScM&vet=12ahUKEwiL7ab7rr_1AhUkl-AKHT7KA0MQMygKegUIARDWAQ..i&docid=32QbPkvuhrQIAM&w=1080&h=1080&itg=1&q=galleta%20rellenitas&ved=2ahUKEwiL7ab7rr_1AhUkl-AKHT7KA0MQMygKegUIARDWAQ"
        },
        {
          "id": 14,
          "name": " Chokis",
          "price": "2.30",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fstorage.googleapis.com%2Fcodigo_bucket%2Fwp-content%2Fuploads%2F2015%2F03%2Fchokis-galleta-4-1.gif&imgrefurl=https%3A%2F%2Fcodigo.pe%2Fpepsico-ingresa-al-rubro-de-galletas-dulces-con-chokis%2F&tbnid=JY9fqzxOzROKeM&vet=12ahUKEwihk46Xr7_1AhWIwikDHaSQAjsQMygSegUIARCDAg..i&docid=4Dy2TeVNdDnGBM&w=1200&h=476&itg=1&q=galleta%20chokis&ved=2ahUKEwihk46Xr7_1AhWIwikDHaSQAjsQMygSegUIARCDAg"
        },
        {
          "id": 15,
          "name": " Salticas",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fd2o812a6k13pkp.cloudfront.net%2Ffit-in%2F455x455%2FProductos%2F40400701_01.jpg&imgrefurl=https%3A%2F%2Fwww.frecuento.com%2Fgalleta-integral-salticas-75g%2F916963%2F&tbnid=2JVw-r0oOg8uSM&vet=12ahUKEwiawduzr7_1AhXZEt8KHZWwChUQMygPegUIARDlAQ..i&docid=kgknM4zjWeFhOM&w=455&h=455&itg=1&q=galleta%20salticas&ved=2ahUKEwiawduzr7_1AhXZEt8KHZWwChUQMygPegUIARDlAQ"
        },
        {
          "id": 16,
          "name": " Chips Ahoy",
          "price": "1.20",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Ftiaecuador.vteximg.com.br%2Farquivos%2Fids%2F165950-1000-1000%2F262124000.jpg%3Fv%3D637184415387600000&imgrefurl=https%3A%2F%2Fwww.tia.com.ec%2Fgalletas-dulces-mini-chips-ahoy-funda-50-g%2Fp&tbnid=iEJwBzyA1pwTWM&vet=12ahUKEwjJ5snUr7_1AhWNLt8KHSuaDF8QMygBegUIARDWAQ..i&docid=_NBFt9Dv43GL-M&w=1000&h=1000&q=galleta%20chips%20ahoy&ved=2ahUKEwjJ5snUr7_1AhWNLt8KHSuaDF8QMygBegUIARDWAQ"
        },
        {
          "id": 17,
          "name": " Coco",
          "price": "2.95",
          "url_image":
              "https://www.google.com/imgres?imgurl=http%3A%2F%2Ffotosapp.liris.com.ec%2FImgAX%2F324%2F7861091100511.jpg&imgrefurl=http%3A%2F%2Fmobile.liris.com.ec%2Fdelportal%2Fproduct%2Fcoco-classic-galleta-30-gr%2F&tbnid=DLPYrCeC4QYTmM&vet=12ahUKEwiquoD1r7_1AhWDMN8KHQNfAxEQMygCegUIARDnAQ..i&docid=Vf0kDzkR6kmjqM&w=324&h=250&itg=1&q=galleta%20coco&ved=2ahUKEwiquoD1r7_1AhWDMN8KHQNfAxEQMygCegUIARDnAQ"
        },
        {
          "id": 19,
          "name": " Krispiz",
          "price": "3.00",
          "url_image":
              "quURdadNlMZWCAsEkmSiIi3WERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERF"
        },
        {
          "id": 20,
          "name": "Galak",
          "price": "2.99",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.confiteriasusanita.net%2Fwp-content%2Fuploads%2F2020%2F10%2FGALLETA-GALAK-SANDUCHE-VAINILLA-87.5g.jpg&imgrefurl=https%3A%2F%2Fwww.confiteriasusanita.net%2Fproducto%2Fgalleta-galak-sanduche-vainilla-87-5g-cjax72u%2F&tbnid=9Tq0IORF51ZDCM&vet=12ahUKEwiDpoa0sL_1AhUCCN8KHaPrD9YQMygDegUIARDEAQ..i&docid=TCl9N067GWpnzM&w=412&h=135&itg=1&q=galleta%20galak&ved=2ahUKEwiDpoa0sL_1AhUCCN8KHaPrD9YQMygDegUIARDEAQ"
        },
        {
          "id": 21,
          "name": "Donuts",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fstatic.wixstatic.com%2Fmedia%2F19ea18_cf9af5187a1240de813b784bca94a6df~mv2.jpg%2Fv1%2Ffill%2Fw_560%2Ch_318%2Cal_c%2Cq_80%2Cusm_2.00_1.00_0.00%2FImage-empty-state.webp&imgrefurl=https%3A%2F%2Fwww.tuttihuerta.com%2Fproducts-1%2Fgalleta-donuts-chocolate-costa-100-gr&tbnid=_JDsYvFM384_cM&vet=12ahUKEwiin7-Esb_1AhWOc98KHXpFCVoQMygHegUIARDZAQ..i&docid=UmVPABGtFvkbMM&w=560&h=318&itg=1&q=galleta%20dotnus&ved=2ahUKEwiin7-Esb_1AhWOc98KHXpFCVoQMygHegUIARDZAQ"
        },
      ],
    },
    {
      "name": "chicles",
      "data": [
        {
          "id": 1,
          "name": "Orbit",
          "price": "1.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.fybeca.com%2Fdw%2Fimage%2Fv2%2FBDPM_PRD%2Fon%2Fdemandware.static%2F-%2FSites-masterCatalog_FybecaEcuador%2Fdefault%2Fdw8db96777%2Fimages%2Flarge%2F229551_1.jpg%3Fsw%3D1000%26sh%3D1000&imgrefurl=https%3A%2F%2Fwww.fybeca.com%2Fchicle-orbit-hierbabuena-sin-azucar-unidad%2FECFY_P229551.html&tbnid=6qsxoPC2kEq69M&vet=12ahUKEwiGs7DGsb_1AhVPNd8KHXo6CyEQMygJegUIARD5AQ..i&docid=eWTDAS5CSIndrM&w=1000&h=1000&itg=1&q=chicles%20orbit%20&ved=2ahUKEwiGs7DGsb_1AhVPNd8KHXo6CyEQMygJegUIARD5AQ"
        },
        {
          "id": 2,
          "name": "Bubbaloo",
          "price": "1.75",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.elgoloso.com.uy%2Fimgs%2Fproductos%2Fproductos34_3336.jpg&imgrefurl=https%3A%2F%2Fwww.elgoloso.com.uy%2Fcatalogo%2Fgolosinas%2Fcaramelos-chicles-y-chupetines%2Fcaja-de-chicles-bubbaloo-agft%2F&tbnid=rC9yoiQ3jV525M&vet=12ahUKEwjH8Kjtsb_1AhX7Vd8KHeM1DsMQMygOegUIARCLAg..i&docid=yUZLqzhHDO63RM&w=1024&h=1024&itg=1&q=chicles%20buubaloo&ved=2ahUKEwjH8Kjtsb_1AhX7Vd8KHeM1DsMQMygOegUIARCLAg"
        },
        {
          "id": 3,
          "name": "Canets",
          "price": "1.10",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmujerejecutiva.com.mx%2Fwp-content%2Fuploads%2F2018%2F12%2FCanels-2.jpg&imgrefurl=https%3A%2F%2Fmujerejecutiva.com.mx%2Fnegocios%2Fcanels-la-marca-mexicana-que-traspasa-fronteras-alrededor-del-mundo%2F&tbnid=hoeIHQIn4M_tcM&vet=12ahUKEwjLg56Nsr_1AhVtwykDHY5QC1UQMygRegUIARCCAg..i&docid=_g9gFs1DLfx_pM&w=660&h=330&itg=1&q=chicles%20canets&ved=2ahUKEwjLg56Nsr_1AhVtwykDHY5QC1UQMygRegUIARCCAg"
        },
        {
          "id": 4,
          "name": "Eclipse",
          "price": "1.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.ebayimg.com%2Fthumbs%2Fimages%2Fg%2FL00AAOSwk~peX5MV%2Fs-l225.jpg&imgrefurl=https%3A%2F%2Fco.ebay.com%2Fb%2FEclipse-Chewing-Gum%2F258018%2Fbn_1647612&tbnid=7NzwEIrU5AFzGM&vet=12ahUKEwiyk6qtsr_1AhWNdN8KHRpADnUQMygBegUIARDHAQ..i&docid=3L5lb4TST5tzmM&w=225&h=194&itg=1&q=chicles%20eclipse&ved=2ahUKEwiyk6qtsr_1AhWNdN8KHRpADnUQMygBegUIARDHAQ"
        },
        {
          "id": 5,
          "name": "Bubblicious",
          "price": "1.20",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Flookaside.fbsbx.com%2Flookaside%2Fcrawler%2Fmedia%2F%3Fmedia_id%3D3574799665880403&imgrefurl=https%3A%2F%2Fwww.facebook.com%2F147385911955146%2Fposts%2Ftrivia-cu%25C3%25A1l-de-estos-chicles-se-fabricaba-donde-hoy-funciona-la-sede-drago-del-c%2F3574802575880112%2F&tbnid=wnCFrqLdr_xL_M&vet=12ahUKEwip34_Ksr_1AhXGDt8KHZcADiEQMygRegUIARDpAQ..i&docid=-54G0MrtU4RlJM&w=640&h=545&q=chicles%20Bubblicious&ved=2ahUKEwip34_Ksr_1AhXGDt8KHZcADiEQMygRegUIARDpAQ"
        },
        {
          "id": 6,
          "name": "Chiclets",
          "price": "1.30",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.pinimg.com%2Foriginals%2F80%2Fbd%2Fb4%2F80bdb45b480c84a3f4357d73e2f3390d.jpg&imgrefurl=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F305541155960905864%2F&tbnid=5oxIFkWmeoSQuM&vet=12ahUKEwjP7Nbssr_1AhXSnuAKHbbyDQwQMygBegUIARDGAQ..i&docid=AY-Hu3nMp6VZXM&w=600&h=400&itg=1&q=chicles%20chickelts&ved=2ahUKEwjP7Nbssr_1AhXSnuAKHbbyDQwQMygBegUIARDGAQ"
        },
        {
          "id": 7,
          "name": "Trident",
          "price": "2.20",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 8,
          "name": "Bang Bang",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcloud10.todocoleccion.online%2Fcoleccionismo%2Ftc%2F2012%2F05%2F21%2F31852455.jpg%3Fsize%3D720x720%26crop%3Dtrue&imgrefurl=https%3A%2F%2Fwww.todocoleccion.net%2Fcoleccionismo%2Fdos-tabletas-chicles-bang-bang-fresa-menta-no-apto-para-consumo-solo-coleccionismo~x42622989&tbnid=mi9kZUQ4EjWpRM&vet=12ahUKEwj4hIKws7_1AhULO98KHUIPCDMQMygHegUIARDGAQ..i&docid=Xm0cxaC66WsKeM&w=720&h=720&itg=1&q=chicles%20bang%20bang%20&ved=2ahUKEwj4hIKws7_1AhULO98KHUIPCDMQMygHegUIARDGAQ"
        },
        {
          "id": 9,
          "name": "Glub",
          "price": "1.55",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.burbujasonline.es%2Fserver%2FPortal_0007798%2Fimg%2Fproducts%2Fglub-chicle-relleno_3477256_xl.jpg&imgrefurl=https%3A%2F%2Fwww.burbujasonline.es%2Fglub-chicle-relleno_p3477256.htm&tbnid=zL8qAteKt2eHUM&vet=12ahUKEwi6hbrOs7_1AhWlAd8KHca0DfsQMygLegUIARDkAQ..i&docid=hu5ZWdTVxUXPJM&w=350&h=350&itg=1&q=chicles%20gums&ved=2ahUKEwi6hbrOs7_1AhWlAd8KHca0DfsQMygLegUIARDkAQ"
        },
        {
          "id": 10,
          "name": "Clorets",
          "price": "1.00",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 11,
          "name": "Poosh",
          "price": "2.00",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 12,
          "name": "Xtime",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcolombina.com%2Fuploads%2Fproduct%2F7702011078346__7834_principal.png&imgrefurl=https%3A%2F%2Fcolombina.com%2Fco_es%2Fproduct%2Fdetail%2F7702011078346%2Fxtime-extrafuerte-100-uds&tbnid=9zNuq70v4aXEEM&vet=12ahUKEwibhO3AtL_1AhVNJd8KHZYGBeEQMygCegUIARC5AQ..i&docid=T_jzbm16i-JbDM&w=1000&h=1000&itg=1&q=chicles%20xtime&ved=2ahUKEwibhO3AtL_1AhVNJd8KHZYGBeEQMygCegUIARC5AQ"
        },
        {
          "id": 13,
          "name": "Agogó",
          "price": "3.00",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 14,
          "name": "Boomer",
          "price": "1.50",
          "url_image":
              "data:image/jpeg;base64,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"
        },
        {
          "id": 15,
          "name": "Halls",
          "price": "2.95",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcache-aldryn-webs.s3.eu-west-1.amazonaws.com%2Fgallery%2Fmedia%2Fimage%2Fproduct%2Fcaramelo-halls-extra-fuerte-de-32-gr-caja-de-20-unidades-01.jpeg&imgrefurl=http%3A%2F%2Fwww.convending.com%2Fproductos%2F240%2Fcaramelo-halls-extra-fuerte-32-gr-caja-20-unidades&tbnid=ylD4oi85eThl8M&vet=12ahUKEwj4073Otb_1AhVQhuAKHVJVDCMQMygdegUIARCFAg..i&docid=_VJaORFNpswR6M&w=350&h=350&itg=1&q=chicles%20halls&ved=2ahUKEwj4073Otb_1AhVQhuAKHVJVDCMQMygdegUIARCFAg"
        },
        {
          "id": 19,
          "name": "Klets",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages-na.ssl-images-amazon.com%2Fimages%2FI%2F41U%252B6sgmowL._SR600%252C315_PIWhiteStrip%252CBottomLeft%252C0%252C35_PIStarRatingTHREEANDHALF%252CBottomLeft%252C360%252C-6_SR600%252C315_SCLZZZZZZZ_FMpng_BG255%252C255%252C255.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.es%2Fklets-Chicle-sin-az%25C3%25BAcar-unidades%2Fdp%2FB078Q95MWN&tbnid=2Tg8wllQXQrgoM&vet=12ahUKEwjgsLKStr_1AhXDCd8KHV_qCywQMygIegUIARDgAQ..i&docid=p9SBYEKHlCfxFM&w=600&h=315&q=chicles%20klets&ved=2ahUKEwjgsLKStr_1AhXDCd8KHV_qCywQMygIegUIARDgAQ"
        },
      ],
    },
    {
      "name": "chupetes",
      "data": [
        {
          "id": 1,
          "name": "Yoguiño",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Flookaside.fbsbx.com%2Flookaside%2Fcrawler%2Fmedia%2F%3Fmedia_id%3D868282099966307&imgrefurl=https%3A%2F%2Fwww.facebook.com%2FMenesesMartinezDistribuciones%2Fphotos%2Fel-sabor-de-yogurt-en-un-solo-chupete-yogui%25C3%25B1o%2F868282099966307%2F&tbnid=Cec0pFfWc2UY8M&vet=12ahUKEwiFlqW-x7_1AhWFC98KHZokCMwQMygFegQIARBH..i&docid=knGnnImmuz0GdM&w=400&h=300&itg=1&q=chupetes%20Yogui%C3%B1o&ved=2ahUKEwiFlqW-x7_1AhWFC98KHZokCMwQMygFegQIARBH"
        },
        {
          "id": 2,
          "name": "BonBonBum",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fgolosinasperu.com%2Fwp-content%2Fuploads%2F2020%2F10%2F134001001.jpg&imgrefurl=https%3A%2F%2Fgolosinasperu.com%2Fproduct%2Fchupetes-bon-bon-bum-fresa-15x-24x-19g%2F&tbnid=cXFkI17xsi34jM&vet=12ahUKEwjnr7rUx7_1AhWhmeAKHRg1AQMQMygKegUIARDbAQ..i&docid=q6U4m8c_rxn6GM&w=515&h=600&itg=1&q=chupetes%20bonbonbun&ved=2ahUKEwjnr7rUx7_1AhWhmeAKHRg1AQMQMygKegUIARDbAQ"
        },
        {
          "id": 3,
          "name": "Popsi",
          "price": "1.75",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fconfiteriaminerva.com%2Finicio%2Fwp-content%2Fuploads%2FPOPSI.STDA_.jpg&imgrefurl=https%3A%2F%2Fconfiteriaminerva.com%2Finicio%2F%3Fproduct%3Dchupete-popsi-pum-fresa-x-24&tbnid=J4pDd9MZGjas0M&vet=12ahUKEwiFoOb-x7_1AhWvneAKHdvbBSkQMygCegQIARA-..i&docid=A9SqYmUZzW0AwM&w=322&h=330&itg=1&q=chupetes%20popsi%20&ved=2ahUKEwiFoOb-x7_1AhWvneAKHdvbBSkQMygCegQIARA-"
        },
        {
          "id": 4,
          "name": "Pin Pop",
          "price": "2.30",
          "url_image":
              "https://www.google.com/imgres?imgurl=http%3A%2F%2Faldoronline.com%2Fwp-content%2Fuploads%2F2016%2F11%2FPIN-POP-SOUR-ASSORTED-16-x-48-18gr.png&imgrefurl=http%3A%2F%2Fwww.aldoronline.com%2Fproducto%2Fpin-pop-sour-assorted-16x48%2F&tbnid=IZI3nw4wVs9P8M&vet=12ahUKEwj-kp7tx7_1AhVjg-AKHb5dDL0QMygDegUIARCyAQ..i&docid=CYw1Yg9ojL2-OM&w=600&h=600&itg=1&q=chupetes%20pinpop&ved=2ahUKEwj-kp7tx7_1AhVjg-AKHb5dDL0QMygDegUIARCyAQ"
        },
        {
          "id": 5,
          "name": "Blow Pop",
          "price": "2.10",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F81ncS0qC3eL._SX679_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FCharms-Blow-Pops-10-4-paquete%2Fdp%2FB0005YVS0M&tbnid=RCOOa4dERXIJfM&vet=12ahUKEwjxhPeLyL_1AhWWHt8KHdJyBWkQMygBegQIARAv..i&docid=bJVB5xNqethFwM&w=679&h=436&itg=1&q=chupetes%20blow%20pop%20&ved=2ahUKEwjxhPeLyL_1AhWWHt8KHdJyBWkQMygBegQIARAv"
        },
        {
          "id": 6,
          "name": "Sweet Pops",
          "price": "1.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F81MPOuMT3OL._SX679_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FChupetes-caramelo-envueltos-individualmente-Lollipops%2Fdp%2FB08BDY16CS&tbnid=yeiD1tEmSQHTGM&vet=12ahUKEwjSo6WeyL_1AhXMi-AKHZ50DzsQMygCegUIARCpAQ..i&docid=Qib5WcHbclcJ8M&w=679&h=228&itg=1&q=chupetes%20Sweet%20Pops&ved=2ahUKEwjSo6WeyL_1AhXMi-AKHZ50DzsQMygCegUIARCpAQ"
        },
        {
          "id": 7,
          "name": "Paleriko",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages-na.ssl-images-amazon.com%2Fimages%2FI%2F51yvCQ%252BmhxL._SR600%252C315_PIWhiteStrip%252CBottomLeft%252C0%252C35_SCLZZZZZZZ_FMpng_BG255%252C255%252C255.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FPaleriko-Tamarind-caramelo-saborizado-Tamarindo%2Fdp%2FB07B89YHJ1&tbnid=HDMCiw6nctljxM&vet=12ahUKEwjAoc6xyL_1AhVHIt8KHakvCAMQMygAegQIARAa..i&docid=Dbr8uEC36ftZTM&w=600&h=350&itg=1&q=chupetes%20paleriko%20&ved=2ahUKEwjAoc6xyL_1AhVHIt8KHakvCAMQMygAegQIARAa"
        },
        {
          "id": 8,
          "name": "Rockaleta",
          "price": "1.20",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fi2.wp.com%2Fwww.cuboinformativo.top%2Fwp-content%2Fuploads%2F2021%2F03%2FRockaleta-el-dulce-mas-picante-de-mexico.jpg%3Fresize%3D679%252C482%26ssl%3D1&imgrefurl=https%3A%2F%2Fwww.cuboinformativo.top%2Fdulces-mexicanos-picantes%2F&tbnid=tFdphLppYQcHvM&vet=12ahUKEwjvqPbEyL_1AhXOGd8KHQwaBhsQMygBegQIARAc..i&docid=ZJCvHE7vZ5rj-M&w=679&h=482&itg=1&q=chupetes%20rockaleta%20&ved=2ahUKEwjvqPbEyL_1AhXOGd8KHQwaBhsQMygBegQIARAc"
        },
        {
          "id": 9,
          "name": "Globo Pop",
          "price": "1.95",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.llevateloya.pe%2F3135-large_default%2Fchupetes-bon-bon-bum-sabor-mango-bolsa-24-und.jpg&imgrefurl=https%3A%2F%2Fwww.llevateloya.pe%2Fgolosinas%2F2717-chupetes-bon-bon-bum-sabor-mango-bolsa-24-und.html&tbnid=jZT0Ez0EVDwRvM&vet=12ahUKEwjShc_kyL_1AhXhc98KHfRwCA4QMygGegUIARDOAQ..i&docid=IsHBWcJ62zH70M&w=350&h=350&itg=1&q=chupetes%20globo%20pop%20&ved=2ahUKEwjShc_kyL_1AhXhc98KHfRwCA4QMygGegUIARDOAQ"
        },
        {
          "id": 10,
          "name": "Chupa Chups",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.logodesignlove.com%2Fimages%2Fevolution%2Fchupa-chups-lollipops.jpg&imgrefurl=https%3A%2F%2Fideakreativa.net%2Fel-logotipo-de-chupetines-chupa-chups%2F&tbnid=Sr_DvV4au_Vt7M&vet=12ahUKEwjrm-P8yL_1AhVkU98KHfHMCwIQMygEegUIARDJAQ..i&docid=aRcnEjFz6guUfM&w=500&h=334&itg=1&q=chupetes%20chupa%20chups&ved=2ahUKEwjrm-P8yL_1AhVkU98KHfHMCwIQMygEegUIARDJAQ"
        },
        {
          "id": 11,
          "name": "Chupi Plum",
          "price": "1.65",
          "url_image":
              "https://www.google.com/imgres?imgurl=http%3A%2F%2Fwww.surtitodo.com%2Fimagenes%2Fgh-chupetes.jpg&imgrefurl=http%3A%2F%2Fwww.surtitodo.com%2Fchupetes-la-universal.html&tbnid=P6uANUtNogFX0M&vet=12ahUKEwjehPyWyb_1AhWKCd8KHZCqAWoQMygCegQIARB7..i&docid=FnZvcS1tHp9L9M&w=300&h=300&itg=1&q=chupetes%20chupi%20plum&ved=2ahUKEwjehPyWyb_1AhWKCd8KHZCqAWoQMygCegQIARB7"
        },
        {
          "id": 12,
          "name": "Cherry Stick",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.confitelia.com%2F3220%2Fcaramelo-con-palo-fini-pop-cherry.jpg&imgrefurl=https%3A%2F%2Fwww.confitelia.com%2Fes%2Fcaramelo-con-palo-fini-pop-cherry-1964.html&tbnid=niITa731mtWraM&vet=12ahUKEwi0qYu9yb_1AhWMAN8KHSItB8IQMygGegQIARBZ..i&docid=p7YdY_FZ4Q-rgM&w=900&h=643&itg=1&q=chupetes%20Cherry%20Stick&hl=es&ved=2ahUKEwi0qYu9yb_1AhWMAN8KHSItB8IQMygGegQIARBZ"
        },
        {
          "id": 13,
          "name": "Plop",
          "price": "3.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fconfitecaencasa.com%2Fimage%2Fcache%2Fcatalog%2F2814908012d47bf218b75dafd10bb8e2a4c7e35b-252x309.jpg&imgrefurl=https%3A%2F%2Fconfitecaencasa.com%2Findex.php%3Froute%3Dproduct%2Fcategory%26path%3D156&tbnid=AinspJjrqBvffM&vet=12ahUKEwjr8ujRyb_1AhXNVN8KHeJmAEsQMygEegUIARDEAQ..i&docid=6_NgeFYN9m8q6M&w=252&h=309&itg=1&q=chupetes%20plop&hl=es&ved=2ahUKEwjr8ujRyb_1AhXNVN8KHeJmAEsQMygEegUIARDEAQ"
        },
        {
          "id": 14,
          "name": "Pirulitos",
          "price": "1.95",
          "url_image":
              "https://www.google.com/imgres?imgurl=http%3A%2F%2Fwww.icapeb.com%2Fimages%2Ffundas%2Fmax%2Fpirulito-mix-acido.png&imgrefurl=http%3A%2F%2Fwww.icapeb.com%2Fproductos-de-fabrica-de-chupetes-en-quito-guayaquil-ecuador.html&tbnid=XV2D29DaZ6Fo_M&vet=12ahUKEwjbp47fyb_1AhVJhuAKHdYNARgQMygKegUIARDaAQ..i&docid=IZcOvzvCn4yKZM&w=479&h=682&itg=1&q=chupetes%20candy%20mix%20&hl=es&ved=2ahUKEwjbp47fyb_1AhVJhuAKHdYNARgQMygKegUIARDaAQ"
        },
      ],
    },
    {
      "name": "caramelos",
      "data": [
        {"id": 1, "name": "Fisherman", "price": "1.50", "url_image": ""},
        {
          "id": 2,
          "name": "Mentos",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F8%2F80%2FMentos.jpg&imgrefurl=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FMentos&tbnid=8X4eHbyzIzdx5M&vet=12ahUKEwiFs4LGyr_1AhWCBt8KHa_FAL4QMygBegUIARDJAQ..i&docid=GXkLp5UZTLLKdM&w=1024&h=768&itg=1&q=caramelos%20mentos%20&hl=es&ved=2ahUKEwiFs4LGyr_1AhWCBt8KHa_FAL4QMygBegUIARDJAQ"
        },
        {
          "id": 3,
          "name": "Gummy",
          "price": "1.75",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.lacasadelasgolosinas.com%2F6659-thickbox_default%2Fcaramelos-de-goma-gummy-jelly-de-dulciora-bolsita-100gr.jpg&imgrefurl=https%3A%2F%2Fwww.lacasadelasgolosinas.com%2Fes%2Fcaramelos-de-goma-gummy-jelly-de-dulciora-bolsita-100gr-4574.html&tbnid=qvdaoWg6v1QmOM&vet=12ahUKEwiAm_fTyr_1AhWQc98KHfP-AeIQMygCegUIARC8AQ..i&docid=XeQiITmrz9iItM&w=800&h=800&itg=1&q=caramelos%20gummy&hl=es&ved=2ahUKEwiAm_fTyr_1AhWQc98KHfP-AeIQMygCegUIARC8AQ"
        },
        {
          "id": 4,
          "name": "Smint",
          "price": "1.95",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.egolosinas.com%2Fblog%2Fwp-content%2Fuploads%2F2018%2F03%2FBanner-Smint.jpg&imgrefurl=https%3A%2F%2Fwww.egolosinas.com%2Fblog%2Fsmint%2F&tbnid=2svMx-_YevWCIM&vet=12ahUKEwizgajnyr_1AhXOdN8KHU8aCKcQMygHegUIARDLAQ..i&docid=nAN5m0A88ORUQM&w=600&h=300&itg=1&q=caramelos%20smint&hl=es&ved=2ahUKEwizgajnyr_1AhXOdN8KHU8aCKcQMygHegUIARDLAQ"
        },
        {
          "id": 5,
          "name": "Sugus",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F51-aK5BgRbL.jpg&imgrefurl=https%3A%2F%2Fwww.desertcart.ec%2Fproducts%2F59046476-sugus-caramelos-masticables-sabor-a-frutas-surtido-700-gr-gluten-free&tbnid=0mdAqQK8DTqcSM&vet=12ahUKEwiouJmNy7_1AhVHCN8KHeF1CL0QMygFegUIARDvAQ..i&docid=lA1K47YeCAlh-M&w=1054&h=1000&itg=1&q=caramelos%20sugus%20&hl=es&ved=2ahUKEwiouJmNy7_1AhVHCN8KHeF1CL0QMygFegUIARDvAQ"
        },
        {
          "id": 6,
          "name": "Palotes",
          "price": "1.25",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.damel.com%2Fimages%2Fcontent%2F1%2Fc106_img1.png&imgrefurl=https%3A%2F%2Fwww.damel.com%2Fpalotes.html&tbnid=ikEjAyksh1gGNM&vet=12ahUKEwip0MSdy7_1AhWSwykDHcZIAqwQMygCegUIARDOAQ..i&docid=5Oy4LbX_EAr4NM&w=431&h=530&itg=1&q=caramelos%20palotes%20&hl=es&ved=2ahUKEwip0MSdy7_1AhWSwykDHcZIAqwQMygCegUIARDOAQ"
        },
        {
          "id": 7,
          "name": "Mentolin",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.fiestasmix.com%2F20212-thickbox_default%2Fcaramelos-mentolin-de-menta-fresca-1-kg.jpg&imgrefurl=https%3A%2F%2Fwww.fiestasmix.com%2Fcaramelos-de-menta%2Fcaramelos-mentolin-de-menta-fresca-1-kg.html&tbnid=sbSyTkEiOsF5GM&vet=12ahUKEwjPgqWry7_1AhWMmeAKHbVkA_8QMygIegUIARDfAQ..i&docid=XVoB3c36hRcVaM&w=800&h=800&itg=1&q=caramelos%20mentolin%20&hl=es&ved=2ahUKEwjPgqWry7_1AhWMmeAKHbVkA_8QMygIegUIARDfAQ"
        },
        {
          "id": 8,
          "name": "Wether's",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.laberintogoloso.com%2Fwp-content%2Fuploads%2F2020%2F04%2Fwerther-s-original-1.jpg&imgrefurl=https%3A%2F%2Fwww.laberintogoloso.com%2Fproducto%2Fcaramelos-a-granel-werthers-original-cream-candies%2F&tbnid=CEK4A2qrRxmc8M&vet=12ahUKEwjkkt6_y7_1AhXUi-AKHYczDvMQMygDegUIARDNAQ..i&docid=36PEi10Od1AwdM&w=600&h=600&itg=1&q=caramelos%20Wether%27s&hl=es&ved=2ahUKEwjkkt6_y7_1AhXUi-AKHYczDvMQMygDegUIARDNAQ"
        },
        {
          "id": 9,
          "name": "Lonka",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.celiacosburgos.org%2Fadftp%2Ffresa-nata.jpg&imgrefurl=https%3A%2F%2Fwww.celiacosburgos.org%2Fes%2Fcontenido%2F%3Fiddoc%3D197&tbnid=HORZUX3mSXxwLM&vet=12ahUKEwiModHWy7_1AhUGHd8KHRrvDL8QMygoegUIARCXAg..i&docid=xKdT98odnRTBWM&w=500&h=360&itg=1&q=caramelos%20lonka&hl=es&ved=2ahUKEwiModHWy7_1AhUGHd8KHRrvDL8QMygoegUIARCXAg"
        },
        {
          "id": 10,
          "name": "Gerio",
          "price": "1.75",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.fiestasmix.com%2F19766-thickbox_default%2Fcaramelos-rellenos-de-miel-gerio-1-kg.jpg&imgrefurl=https%3A%2F%2Fwww.fiestasmix.com%2Fgerio%2Fcaramelos-rellenos-de-miel-gerio-1-kg.html&tbnid=3MKmx0_WDUM5kM&vet=12ahUKEwjP-dzty7_1AhVGxCkDHQTuD6EQMygHegUIARDdAQ..i&docid=VuT0bgiK_HtXeM&w=800&h=800&itg=1&q=caramelos%20gerio%20&hl=es&ved=2ahUKEwjP-dzty7_1AhVGxCkDHQTuD6EQMygHegUIARDdAQ"
        },
        {
          "id": 11,
          "name": "Kopiko",
          "price": "3.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F51AOZH%2BA16L._AC_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FKopiko-Dulces-caf%25C3%25A9-en-bolsa%2Fdp%2FB07V7167YC&tbnid=7zQtvEI-FPiVTM&vet=12ahUKEwjuh9j9y7_1AhVCBt8KHUt1AEsQMygAegUIARDHAQ..i&docid=AUv6fAYX9LQIlM&w=338&h=468&itg=1&q=caramelos%20kopiko%20&hl=es&ved=2ahUKEwjuh9j9y7_1AhVCBt8KHUt1AEsQMygAegUIARDHAQ"
        },
        {"id": 13, "name": "Misky", "price": "2.00", "url_image": ""},
        {
          "id": 14,
          "name": "Butter Toffees",
          "price": "1.25",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Ftiaecuador.vteximg.com.br%2Farquivos%2Fids%2F180076-1000-1000%2F262402001.jpg%3Fv%3D637566235004800000&imgrefurl=https%3A%2F%2Fwww.tia.com.ec%2Fcaramelos-masticables-butter-toffees-150-g-chocolate-262402001%2Fp&tbnid=0STpUVuEa5UJZM&vet=12ahUKEwjykPebzL_1AhVqkuAKHXgcCdAQMygAegUIARDOAQ..i&docid=lphJY46oChdaRM&w=1000&h=1000&itg=1&q=caramelos%20Butter%20Toffees&hl=es&ved=2ahUKEwjykPebzL_1AhVqkuAKHXgcCdAQMygAegUIARDOAQ"
        },
        {
          "id": 15,
          "name": "Leche y Miel",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcomisariatoeconomico.com%2Fwp-content%2Fuploads%2F2020%2F10%2F7862106450034.jpg&imgrefurl=https%3A%2F%2Fcomisariatoeconomico.com%2Fproducto%2Fcaramelo-universal-leche-y-miel-400gr%2F&tbnid=Tn-7y1uZUBD_PM&vet=12ahUKEwip2tqqzL_1AhWkc98KHR5qBNIQMygBegUIARDLAQ..i&docid=1qgtS15h8Y9VDM&w=1000&h=1000&itg=1&q=caramelos%20leche%20y%20miel%20&hl=es&ved=2ahUKEwip2tqqzL_1AhWkc98KHR5qBNIQMygBegUIARDLAQ"
        },
        {
          "id": 16,
          "name": "Creme Savers",
          "price": "2.00",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F71hqA5To7KL._SL1500_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FCreme-Savers-Caramelo-remolinadas-originales%2Fdp%2FB09FFQ7MS1&tbnid=N5Caq8IJzV-jbM&vet=12ahUKEwiL7uC3zL_1AhWQPt8KHTwTDTIQMygBegQIARBP..i&docid=6peGpoge73UKWM&w=1500&h=1500&itg=1&q=caramelos%20Creme%20Savers&hl=es&ved=2ahUKEwiL7uC3zL_1AhWQPt8KHTwTDTIQMygBegQIARBP"
        },
        {
          "id": 17,
          "name": "Strong",
          "price": "1.50",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Flookaside.fbsbx.com%2Flookaside%2Fcrawler%2Fmedia%2F%3Fmedia_id%3D3278647985489386&imgrefurl=https%3A%2F%2Fm.facebook.com%2Fhebillahnos%2Fphotos%2Fa.229422400411975%2F3278647985489386%2F%3Ftype%3D3&tbnid=ARbUxK6U6OmSrM&vet=12ahUKEwiu_MfGzL_1AhUFD98KHSR4Bm8QMygEegUIARDMAQ..i&docid=C7ZD0QbUpNjraM&w=1076&h=605&itg=1&q=caramelos%20strong&hl=es&ved=2ahUKEwiu_MfGzL_1AhUFD98KHSR4Bm8QMygEegUIARDMAQ"
        },
        {
          "id": 19,
          "name": "Flynn Paff",
          "price": "1.30",
          "url_image":
              "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn11.bigcommerce.com%2Fs-adywb9ndo9%2Fimages%2Fstencil%2F1280x1280%2Fproducts%2F1081%2F759%2FFlynn_Paff_Caramelos-70_un__39375.1606675875.jpg%3Fc%3D1&imgrefurl=https%3A%2F%2Fargentina2u.com%2Fflynn-paff-caramelos-tutti-frutti-8-gr-0-28-oz%2F&tbnid=isB-B7BVYaUkNM&vet=12ahUKEwj3quXlzL_1AhWEMN8KHZGKDuYQMygFegUIARDXAQ..i&docid=uOqdGhdMfQNOvM&w=1280&h=1106&itg=1&q=caramelos%20Flynn%20Paff&hl=es&ved=2ahUKEwj3quXlzL_1AhWEMN8KHZGKDuYQMygFegUIARDXAQ"
        },
      ],
    },
  ];

  static Map<String, dynamic> getData(String identification) {
    late Map<String, dynamic> dataFinal;
    for (final Map<String, dynamic> item in data) {
      if (item['name'].toString() == identification.toLowerCase()) {
        dataFinal = item;
      }
    }
    return dataFinal;
  }
}
