import 'package:flutter/material.dart';
import 'package:flutter_navigation/fetch_file.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/';
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Home page',
          style: TextStyle(
            fontSize: 40,
            color: Colors.blue[400],
          ),
        ),
      ),
      drawer: DrawerForAllPages(),
    );
  }
}

class AlbumsView extends StatefulWidget {
  static const routeName = '/albums';
  const AlbumsView({Key? key}) : super(key: key);

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerForAllPages(),
      body: FutureBuilder<List<BandsInfo>>(
        future: parseJson(context),
        builder:
            (BuildContext context, AsyncSnapshot<List<BandsInfo>> snapshot) {
          final bands = snapshot.data ?? [];
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: bands.length,
            itemBuilder: (context, index) {
              final _bands = bands[index];
              return ListTile(
                  title: Text(_bands.name),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PageInfo(nameBand: _bands),
                      ),
                    );
                  });
            },
          );
        },
      ),
    );
  }
}

class PageInfo extends StatelessWidget {
  final BandsInfo nameBand;
  const PageInfo({Key? key, required this.nameBand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(nameBand.name),
      ),
      body: Container(
        child: Text(nameBand.about),
      ),
    );
  }
}

class DrawerForAllPages extends StatefulWidget {
  const DrawerForAllPages({Key? key}) : super(key: key);

  @override
  State<DrawerForAllPages> createState() => _DrawerForAllPagesState();
}

class _DrawerForAllPagesState extends State<DrawerForAllPages> {
  List<bool> isSelected = [true, false];
  PageController _controller = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return Drawer(
      child: ListView.builder(
        controller: _controller,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const DrawerHeader(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.artmajeur.com/medias/standard/d/a/darchuk-76/artwork/15028037_dsc08278.jpg'),
                  radius: 100,
                ),
              ),
              ListTile(
                selected: selectedIndex == 0,
                title: const Text('Home'),
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });

                  Navigator.of(context).pushNamed('/');
                },
              ),
              Divider(
                color: Colors.grey[350],
              ),
              ListTile(
                selected: selectedIndex == 1,
                title: Text('Albums'),
                leading: Icon(Icons.library_music_outlined),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });

                  Navigator.of(context).pushNamed('/albums');
                },
              ),
              Divider(
                color: Colors.grey[350],
              ),
            ],
          );
        },
      ),
    );
  }
}
