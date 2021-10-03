import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/OnboardObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Screens/Onboarding/CloudSetup.dart';
import 'package:untitled3/Screens/Onboarding/Permission.dart';
import 'package:untitled3/Screens/Onboarding/SelectLanguage.dart';
import 'package:untitled3/Screens/Onboarding/Walkthrough.dart';

import 'package:untitled3/generated/i18n.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  _OnBoardingScreenState();

  OnboardObserver onboardObserver = OnboardObserver();
  Setting onbaordSetting =  Setting();

  static const int NUM_OF_ONBOARDING_SCREEN = 4; 

  String _screenName(index){
      List<String> boardingScreens = [
        I18n.of(context)!.OboardLangSetup,
        I18n.of(context)!.OboardPermissionSetup,
        I18n.of(context)!.OboardCloudSettup,
        I18n.of(context)!.WalkthroughScreen,
    ];
    return boardingScreens[index];
   }

   Widget _changeScreen(index) {
   
    
    //when onboarding is completed
    if(index > NUM_OF_ONBOARDING_SCREEN-1){
        final settingObserver = Provider.of<SettingObserver>(context);
        onbaordSetting.isFirstRun = false;

        settingObserver.saveSetting(onbaordSetting);
        //move to the Main screen
         Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>  MainNavigator(),
                  ));
        
        return Text("Welcome to Memory Magic");
    }

    String name = _screenName(index);

    print("Oboarding screen: name $name  indext $index " );


    if (name == I18n.of(context)!.OboardLangSetup) {
      return  SelectLanguageScreen();
    }
    if (name == I18n.of(context)!.OboardPermissionSetup) {
      print("Return " + name);
      return PermissionScreen();
    }
    if (name == I18n.of(context)!.OboardCloudSettup) {
      print("Return " + name);
      return CloudSetupScreen();
    }

    return WalkthroughScreen();
   }

  AppBar buildAppBar(BuildContext context) {
    
    final settingObserver = Provider.of<SettingObserver>(context);
    return AppBar(
      
      toolbarHeight: 90,
      title: Observer(
          builder: (_) => Text(
                '${_screenName(onboardObserver.currentScreenIndex)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              )),
      backgroundColor: Color(0xFF33ACE3),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Center(
          child: Observer(
                  builder: (_) => 
                      _changeScreen(onboardObserver.currentScreenIndex)
          ) 
        ),

        persistentFooterButtons: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                    child: Text("BACK"),
                    onPressed: ()=>{onboardObserver.moveToPrevScreen()},
                  ), 
            ElevatedButton(
                    child: Text("NEXT"),
                    onPressed: ()=>{onboardObserver.moveToNextScreen()},
                  ),

          ])
        ],
    );
  }
}