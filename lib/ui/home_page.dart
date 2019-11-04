import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:luggage_app_final/ui/flight_page.dart';
import 'package:luggage_app_final/ui/page_drawer.dart';
import 'package:luggage_app_final/ui/qr_code_page.dart';
import 'package:luggage_app_final/ui/ticket_page.dart';
import 'luggages_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class NavigationViewItem {
  final String title;
  final Widget widget;

  NavigationViewItem(this.title, this.widget);
}

class _HomePageState extends State<HomePage> {

  final List<NavigationViewItem> items = <NavigationViewItem>[
    NavigationViewItem('Luggage List', LuggagesPage()),
    NavigationViewItem('Ticket Info', TicketPage()),
    NavigationViewItem('Flight Info', FlightPage()),
    NavigationViewItem('QR Code', QRCodePage()),
  ];

  final controller = PageController(
    initialPage: 0,
  );

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PageDrawer(),
      backgroundColor: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
      appBar: AppBar(
        title: Text(items[index].title.toUpperCase()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(
            Icons.business_center,
            size: 30,
            color: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
          ),
          Icon(
            Icons.confirmation_number,
            size: 30,
            color: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
          ),
          Icon(
            Icons.flight,
            size: 30,
            color: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
          ),
          Icon(
            Icons.code,
            size: 30,
            color: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
          )
        ],
        animationCurve: Curves.easeOutQuint,
        backgroundColor: Colors.transparent,
        onTap: (index) => {
          controller.animateToPage(
            index,
            curve: Curves.easeOutQuint,
            duration: Duration(seconds: 1),
          )
        },
        index: index,
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Opacity(
              opacity: 0.25,
              child: Image.network(
                'https://images.pexels.com/photos/1815384/pexels-photo-1815384.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              child: PageView(
                controller: controller,
                children: items.map((x) => x.widget).toList(),
                onPageChanged: (index) => {
                  setState(() => this.index = index)
                },
              ),
            ),
          ),
        ]
      ),
    );
  }
}