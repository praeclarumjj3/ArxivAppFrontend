import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/services/local_storage_service.dart';
import 'package:arxiv_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../locator.dart';
import '../base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User _currentUser;
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  void navigate(String id) {
    _navigationService.pushNamedAndRemoveUntil(id);
  }

  Future<String> signInWithGoogle() async {
    setState(ViewState.Busy);
    var googleSignInAccount = await googleSignIn.signIn();
    var googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    var authResult = await _auth.signInWithCredential(credential);
    // ignore: omit_local_variable_types
    User user = authResult.user;

    if (user != null) {
      setState(ViewState.Idle);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      _currentUser = _auth.currentUser;
      notifyListeners();
      _localStorageService.isLoggedIn = true;
      assert(user.uid == _currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    } else {
      setState(ViewState.Error);
      await Fluttertoast.showToast(
          msg: 'Login failed!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    setState(ViewState.Busy);
    await googleSignIn.signOut();
    setState(ViewState.Idle);
    print('User Signed Out');
  }

  User get currentUser => _currentUser;
}
