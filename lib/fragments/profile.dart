import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/button.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/main.dart';
import 'package:lime_mobile_app/models/store.dart';
import 'package:lime_mobile_app/utils.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/spacing.dart';
import 'package:lime_mobile_app/values/strings.dart';
import 'package:provider/provider.dart';

class ProfileFragment extends StatefulWidget {
  ProfileFragment({Key key, this.onNavigate}) : super(key: key);

  final Function(int) onNavigate;

  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  StoreModel store;
  final ScrollController projectsController =
      ScrollController(keepScrollOffset: true);
  final ScrollController surveysController =
      ScrollController(keepScrollOffset: true);
  bool changeName = false;
  bool changePassword = false;

  @override
  void initState() {
    super.initState();
    store = Provider.of<StoreModel>(App.navigatorKey.currentContext);
  }

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    VSpace.md,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 48,
                            height: 48,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: CircleAvatar(
                              child: (store.user.picture == null ||
                                      store.user.picture.isEmpty)
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                              backgroundColor: LColors.purpleColor,
                              backgroundImage: (store.user.picture == null ||
                                      store.user.picture.isEmpty)
                                  ? null
                                  : MemoryImage(store.picture),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            '${store.user.firstName} ${store.user.lastName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          RichText(
                            text: TextSpan(
                              text: 'Edit',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: LColors.purpleColor,
                                    decoration: TextDecoration.underline,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    changeName = true;
                                  });
                                },
                            ),
                          ),
                          HSpace.sm,
                        ],
                      ),
                    ),
                    if (changeName) ...[
                      VSpace.md,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Text(
                          'Edit Name',
                          style: Theme.of(context).textTheme.subtitle1,
                          softWrap: true,
                        ),
                      ),
                      LCard(
                        child: LimitedBox(
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Form(
                                key: _formKeyName,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    LimitedBox(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                            text: store.user.firstName),
                                        keyboardType: TextInputType.text,
                                        validator: (String value) =>
                                            validateRequired(
                                                value, 'First Name'),
                                        decoration: InputDecoration(
                                          hintText: 'First Name',
                                        ),
                                        onChanged: (String value) {
                                          store.user.firstName = value;
                                        },
                                      ),
                                    ),
                                    VSpace.md,
                                    LimitedBox(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                            text: store.user.lastName),
                                        keyboardType: TextInputType.text,
                                        validator: (String value) =>
                                            validateRequired(
                                                value, 'Last Name'),
                                        decoration: InputDecoration(
                                          hintText: 'Last Name',
                                        ),
                                        onChanged: (String value) {
                                          store.user.lastName = value;
                                        },
                                      ),
                                    ),
                                    VSpace.md,
                                    LMiniButton(
                                      'Update Name',
                                      elevation: 0,
                                      onPressed: () {
                                        if (_formKeyName.currentState
                                            .validate()) {
                                          setState(() {
                                            changeName = false;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -24,
                                top: -24,
                                child: IconButton(
                                  icon: Center(
                                    child: Icon(
                                      Icons.cancel,
                                      color: Theme.of(context)
                                          .errorColor
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                  tooltip: 'Cancel name change',
                                  onPressed: () {
                                    setState(() {
                                      changeName = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    VSpace.md,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: LCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Notifications:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        fontFamily: Strings.app.font,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                VSpace.sm,
                                Text(
                                  'Sends an alert everytime you get a new response',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(fontFamily: Strings.app.font),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    VSpace.md,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: LCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Email:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        fontFamily: Strings.app.font,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                VSpace.sm,
                                Text(
                                  '${store.user.firstName ?? 'N/A'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        fontFamily: Strings.app.font,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    VSpace.md,
                    if (!changePassword)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: LCard(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Password:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontFamily: Strings.app.font,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  VSpace.sm,
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '************',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                              fontFamily: Strings.app.font,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        softWrap: true,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Edit',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                color: LColors.purpleColor,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              setState(() {
                                                changePassword = true;
                                              });
                                            },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (changePassword) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Text(
                          'Edit Password',
                          style: Theme.of(context).textTheme.subtitle1,
                          softWrap: true,
                        ),
                      ),
                      LCard(
                        child: LimitedBox(
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Form(
                                key: _formKeyPassword,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    LimitedBox(
                                      child: TextFormField(
                                        controller:
                                            TextEditingController(text: ''),
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (String value) =>
                                            validateRequired(
                                                value, 'Old Password'),
                                        decoration: InputDecoration(
                                          hintText: 'Old Password',
                                        ),
                                        onChanged: (String value) {},
                                      ),
                                    ),
                                    VSpace.md,
                                    LimitedBox(
                                      child: TextFormField(
                                        controller:
                                            TextEditingController(text: ''),
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (String value) =>
                                            validateRequired(
                                                value, 'New Password'),
                                        decoration: InputDecoration(
                                          hintText: 'New Password',
                                        ),
                                        onChanged: (String value) {},
                                      ),
                                    ),
                                    VSpace.md,
                                    LimitedBox(
                                      child: TextFormField(
                                        controller:
                                            TextEditingController(text: ''),
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (String value) =>
                                            validateRequired(value,
                                                'New Password Confirmation'),
                                        decoration: InputDecoration(
                                          hintText: 'Confirm New Password',
                                        ),
                                        onChanged: (String value) {},
                                      ),
                                    ),
                                    VSpace.md,
                                    LMiniButton(
                                      'Update Password',
                                      elevation: 0,
                                      onPressed: () {
                                        if (_formKeyPassword.currentState
                                            .validate()) {
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -24,
                                top: -24,
                                child: IconButton(
                                  icon: Center(
                                    child: Icon(
                                      Icons.cancel,
                                      color: Theme.of(context)
                                          .errorColor
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                  tooltip: 'Cancel password change',
                                  onPressed: () {
                                    setState(() {
                                      changePassword = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    VSpace.md,
                    LButtonCard(
                      label: 'Log out',
                      context: context,
                      color: Colors.white,
                      onTap: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10),
                        ),
                        side: BorderSide(color: LColors.errorColor, width: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
