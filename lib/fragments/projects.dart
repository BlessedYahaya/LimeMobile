import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime/components/card.dart';
import 'package:lime/components/scaffold.dart';
import 'package:lime/main.dart';
import 'package:lime/models/project.dart';
import 'package:lime/models/store.dart';
import 'package:lime/views/project.dart';
import 'package:provider/provider.dart';

class ProjectsFragment extends StatefulWidget {
  ProjectsFragment({Key key, this.onNavigate}) : super(key: key);

  final Function(int) onNavigate;

  @override
  _ProjectsFragmentState createState() => _ProjectsFragmentState();
}

class _ProjectsFragmentState extends State<ProjectsFragment> {
  StoreModel store;
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true);

  List<ProjectModel> get selectedProjects =>
      store.projects.where((ProjectModel p) => p.checked).toList();

  @override
  void initState() {
    super.initState();
    store = Provider.of<StoreModel>(App.navigatorKey.currentContext);
  }

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('Projects'),
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
                              text:
                                  'Delete${selectedProjects.length == 0 ? '' : selectedProjects.length == 1 ? ' Project' : ' Projects'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Theme.of(context).errorColor,
                                    decoration: TextDecoration.underline,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // TODO: show some dialog
                                  print('TODO');
                                },
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (ProjectModel project in store.projects)
                      LCheckCard(
                        project.checked,
                        (bool value) {
                          setState(() {
                            project.checked = value;
                          });
                        },
                        onTap: () {
                          App.pushPageRoute(
                            ProjectView(project: project),
                            fullscreenDialog: true,
                          );
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
