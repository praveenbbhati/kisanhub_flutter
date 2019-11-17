
import 'package:kisanhub_assignment/models/ActivityResponse.dart';
import 'package:kisanhub_assignment/data/rest_ds.dart';

abstract class HomeScreenContract{
  void onActivitiesSuccess(ActivityResponse activityResponse);
  void onActivitisError(String errorTxt);
}

class HomeScreenPresenter{
  HomeScreenContract _view;
  RestData api = RestData();
  HomeScreenPresenter(this._view);

  getActivities(){
    api.getActivities().then((ActivityResponse activityResponse){
      _view.onActivitiesSuccess(activityResponse);
    }).catchError((Object error) => _view.onActivitisError(error.toString()));
  }
}