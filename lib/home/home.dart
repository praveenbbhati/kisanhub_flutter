import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kisanhub_assignment/home/home_presenter.dart';
import 'package:kisanhub_assignment/models/ActivityResponse.dart';
import 'package:kisanhub_assignment/models/Activity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:kisanhub_assignment/auth.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> implements HomeScreenContract, AuthStateListener {
  
  BuildContext _ctx;
  HomeScreenPresenter _homeScreenPresenter;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  List activities = List();

  _HomePageState(){
    _homeScreenPresenter = HomeScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  @override
    void initState() {
      setState(() => _isLoading = true);
      _homeScreenPresenter.getActivities();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    
    _ctx = context;

    makeListTile(Activity activity) => Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              
              "Activity - " + activity.activityId,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            Text(
              activity.date,
              style: TextStyle(
                fontSize: 16.0
              ),
            ),    
          ],
        ),
        Row(
          children: <Widget>[
            Image.network(
              activity.wakeUpImage,
              width: 100.0,
              height: 100.0,
            ),
            Text(
              activity.wakeUp,
              style: TextStyle(
                fontSize: 40.0
              ),
            ),
          ],
        ),
        Row(children: <Widget>[
          Image.network(
            activity.totalStepsImage,
            width: 100.0,
            height: 100.0,
          ),
          Text(
            
            activity.totalSteps + " Steps",
            style: TextStyle(
                fontSize: 40.0
            ),
          ),
              
        ]),
      ],
    );

    makeCard(Activity activity) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        decoration: BoxDecoration(color: Color(0xffffffff)),
        child: makeListTile(activity),
      ),
    );

    

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(activities[index]);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        key: scaffoldKey,
        title: Text('Activities'),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: _isLoading ? Center(
        child:CircularProgressIndicator() ,  
      ) : makeBody ,
    );
  }

  Future<void> logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("auth_token");
    pref.remove("is_login");
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_OUT);
 }

  @override
  void onAuthStateChanged(AuthState state) {
    if(state == AuthState.LOGGED_OUT)
      Navigator.of(_ctx).pushReplacementNamed("/login");
  }

  @override
  void onActivitiesSuccess(ActivityResponse activityResponse) {

    setState(() {
      _isLoading = false;
      activities = activityResponse.activities;
    });
    
  }

  @override
  void onActivitisError(String errorTxt) {
    setState(() => _isLoading = false);
    _showSnackBar(errorTxt);
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }
}