import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_mobx/store/job_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool _isBtnEnabled = false;

  JobStore jobStore;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_isBtnEnabled != _controller.value.text.isNotEmpty) {
        setState(() {
          _isBtnEnabled = _controller.value.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('xxxx');
    jobStore = context.watch<JobStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Github Jobs'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Описание вакансии',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Observer(
                      builder: (context) {
                        print('22222');
                        return MaterialButton(
                          onPressed: _isBtnEnabled
                              ? () {
                                  jobStore.initText();
                                  jobStore.setQuery(_controller.text);
                                  jobStore.loadJob();
                                }
                              : null,
                          elevation: 3,
                          disabledColor: const Color(0xFFE9E9E9),
                          color: const Color(0xFFE5E5E5),
                          child: Text(
                            'Искать',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Observer(builder: (context) {
                print('11111');
                if (jobStore.isInitText == true) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: Center(
                      child: Text('Введите описание вакансии'),
                    ),
                  );
                }
                if (jobStore.loadingError) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Введите описание вакансии'),
                        MaterialButton(
                          onPressed: () {
                            jobStore.loadJob();
                          },
                          elevation: 3,
                          disabledColor: const Color(0xFFE9E9E9),
                          color: const Color(0xFFE5E5E5),
                          child: const Text(
                            'Повторить',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  if (jobStore.isLoading) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: jobStore.jobs
                        .map(
                          (job) => ListTile(
                            title: Text(
                              '${job.company}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              '${job.location}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text('${job.createdAt}'),
                            onTap: () {
                              Navigator.pushNamed(context, '/jobPage',
                                  arguments: job);
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
