import 'package:employee_management_app/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:employee_management_app/features/posts/presentation/pages/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../bloc/posts/posts_bloc.dart';
import 'fiche_de_paie_page.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  int _currentPageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    PostsPageContent(), // Current page
    FicheDePaiePage(
      salaire: 1500,
      hoursPerWeek: 0,
      sodexo: 100,
      taxes: -60,
      bonus: 570,
      status: '',
      hireDate: DateTime.now(),
      endOfContract: DateTime.now(),
    ),
    TasksPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg?w=826&t=st=1686474818~exp=1686475418~hmac=528fb200dfd018902d964822fd0e37458c835291cd674708d7c1c6552e0e82ef'), // Replace with your image URL
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'John',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Doe',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text('📧 ', style: TextStyle(fontSize: 18)),
                      Text('Email: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('johndoe@gov.tn'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('🎯 ', style: TextStyle(fontSize: 18)),
                      Text('Badge: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('On Fresh Recruitment'),
                      SizedBox(width: 5),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('🏆 ', style: TextStyle(fontSize: 18)),
                      Text('Points: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('1200'),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 100),
            Center(
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                progressColor: Colors.green,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,
                percent: 0.7,
                footer: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "Productivity",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                ),
                center: new Text(
                  "70.0%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: _buildAppBar(),
      body: Row(
        children: [
          Expanded(
            child: _pages[_currentPageIndex],
          ),
          const VerticalDivider(width: 1),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Fiche de paie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Tasks',
          ),
        ],
      ),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Posts'),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostAddUpdatePage(isUpdatePost: false),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}

class PostsPageContent extends StatefulWidget {
  const PostsPageContent({Key? key}) : super(key: key);

  @override
  State<PostsPageContent> createState() => _PostsPageContentState();
}

class _PostsPageContentState extends State<PostsPageContent> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedPostsState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(post.body),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostAddUpdatePage(
                            isUpdatePost: true,
                            post: post,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ErrorPostsState) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
