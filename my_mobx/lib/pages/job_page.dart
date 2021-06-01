import 'package:flutter/material.dart';
import 'package:my_mobx/models/job.dart';

class JobPage extends StatelessWidget {
  const JobPage({Key key, this.job}) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.company),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.network(job.companyLogo, fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ),
              ListTile(
                title: Text(
                  job.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Location: ${job.location}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(job.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
