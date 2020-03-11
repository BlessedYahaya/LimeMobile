import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/models/project.dart';

class ProjectsFragment extends StatefulWidget {
  ProjectsFragment({Key key, this.onNavigate}) : super(key: key);

  final Function(int) onNavigate;

  @override
  _ProjectsFragmentState createState() => _ProjectsFragmentState();
}

class _ProjectsFragmentState extends State<ProjectsFragment> {
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true);

  List<ProjectModel> projects;

  @override
  void initState() {
    super.initState();
    projects = [
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
      ProjectModel(label: 'LAPL - Project SVO'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('Lime'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: CustomScrollView(
        key: PageStorageKey<String>('projects-list'),
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: 'Delete',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Theme.of(context).errorColor,
                                    decoration: TextDecoration.underline,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (ProjectModel project in projects)
                      LCheckCard(
                        project.checked,
                        (bool value) {
                          setState(() {
                            project.checked = value;
                          });
                        },
                        label: project.label,
                        context: context,
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
