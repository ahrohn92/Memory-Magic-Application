import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Services/LocaleService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

List<FontSize> fontSizes = [FontSize.SMALL, FontSize.MEDIUM, FontSize.LARGE];

List<String> daysToKeepFilesOptions = ["1", "3", "5", "7", "14", "Forever"];

class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  SettingObserver settingsObs = SettingObserver();

  var noteFontSize;
  var menuFontSize;
  var daysToKeepFiles;

  @override
  void initState() {
    SettingObserver initialSetting = SettingObserver();
    noteFontSize = initialSetting.userSettings.noteFontSize;
    menuFontSize = initialSetting.userSettings.menuFontSize;
    daysToKeepFiles = initialSetting.userSettings.daysToKeepFiles;
    super.initState();
  }

  var language = (I18n.locale?.countryCode != null &&
          I18n.locale?.languageCode != null)
      ? I18n.locale
      // its simply not supported unless it has a language code and a country code
      : Locale("en", "US");

  @override
  Widget build(BuildContext context) {
    final settingObserver = Provider.of<SettingObserver>(context);

    fontSizeToDisplayName(FontSize fontSize) {
      switch (fontSize) {
        case FontSize.SMALL:
          {
            return I18n.of(context)!.small;
          }
        case FontSize.MEDIUM:
          {
            return I18n.of(context)!.medium;
          }
        case FontSize.LARGE:
          {
            return I18n.of(context)!.large;
          }
        default:
          throw new UnimplementedError('not implemented');
      }
    }

    void resetSettings() {
      settingObserver.saveSetting(Setting());
    }

    return Observer(
      builder: (context) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Text("Days To Keep Notes"),
            Padding(
              padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.promptNoteDeletionTimeline,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  icon: Icon(
                    // Add this
                    Icons.edit_sharp, // Add this
                    color: Colors.blue, // Add this
                  ),
                  value: daysToKeepFiles,
                  onChanged: (newValue) {
                    setState(() {
                      daysToKeepFiles = newValue;
                    });
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: daysToKeepFilesOptions.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem, child: Text((valueItem)));
                  }).toList(),
                ),
              ),
            ),
            Text("Note Font Size"),
            Padding(
              padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.promptNoteFontSize,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  icon: Icon(
                    // Add this
                    Icons.edit_sharp, // Add this
                    color: Colors.blue, // Add this
                  ),
                  value: noteFontSize,
                  onChanged: (newValue) {
                    setState(() {
                      noteFontSize = newValue ?? DEFAULT_FONT_SIZE;
                    });
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: fontSizes.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem,
                        child: Text((fontSizeToDisplayName(valueItem))));
                  }).toList(),
                ),
              ),
            ),
            Text("Menu Font Size"),
            Padding(
              padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.promptMenuFontSize,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  icon: Icon(
                    // Add this
                    Icons.edit_sharp, // Add this
                    color: Colors.blue, // Add this
                  ),
                  value: menuFontSize,
                  onChanged: (newValue) {
                    setState(() {
                      menuFontSize = newValue ?? DEFAULT_FONT_SIZE;
                    });
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: fontSizes.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem,
                        child: Text((fontSizeToDisplayName(valueItem))));
                  }).toList(),
                ),
              ),
            ),
            Text(I18n.of(context)!.language),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.selectLanguage,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  //icon: Icon(                // Add this
                  //  Icons.arrow_drop_down_outlined,  // Add this
                  //  color: Colors.blue,   // Add this
                  //),
                  icon: Image.asset(
                    // Add this
                    //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
                    "assets/images/dropdownarrow.png",
                    width: 28,
                    height: 18,
                    //Icons.arrow_drop_down_outlined,
                    //size: 31,
                    color: Colors.blue, // Add this
                  ),
                  value: language,
                  onChanged: (Locale? newLocale) {
                    setState(() {
                      if (newLocale != null) {
                        language = newLocale;
                      }
                    });
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: GeneratedLocalizationsDelegate()
                      .supportedLocales
                      .map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem,
                        child: Text((LocaleService.getDisplayLanguage(
                            valueItem.languageCode)["name"])));
                  }).toList(),
                ),
              ),
            ),

            //SAVE BUTTON
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 4, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  var setting = Setting();
                  setting.noteFontSize = noteFontSize;
                  setting.daysToKeepFiles = daysToKeepFiles;
                  setting.menuFontSize = menuFontSize;
                  settingObserver.saveSetting(setting);
                  I18n.onLocaleChanged!(language!);
                },
                child: Text(
                  I18n.of(context)!.save,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(30, 40),
                    primary: Colors.lightBlue,
                    onPrimary: Colors.black),
              ),
            ),

            //RESET BUTTON//
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: resetSettings,
                child: Text(
                  I18n.of(context)!.resetSettings,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(30, 40),
                    primary: Colors.lightBlue,
                    onPrimary: Colors.black),
              ),
            ),

            //SECURITY BUTTON
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  I18n.of(context)!.securitySettings,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(30, 40),
                    primary: Colors.lightBlue,
                    onPrimary: Colors.black),
              ),
            ),

            //CANCEL BUTTON
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  final screenNav =
                      Provider.of<MenuObserver>(context, listen: false);
                  screenNav.changeScreen(MENU_SCREENS.MENU);
                },
                child: Text(
                  I18n.of(context)!.cancel,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(30, 40), primary: Colors.grey),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
