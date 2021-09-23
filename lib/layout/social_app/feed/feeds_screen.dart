import 'package:flutter/material.dart';
import 'package:zigzag_app_flutter/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            margin: EdgeInsets.all(8.0),
            child:
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: AssetImage('assets/images/handsome.jpg'),
                fit: BoxFit.cover,
                height: 200.0,
                width: double.infinity,
              ),
              Text(
                'communicate with friends',
                style: Theme.of(context).textTheme.subtitle1,
              )
            ]),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(
              height: 8.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          )
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg'),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Abdullah Mansour',
                            style: TextStyle(height: 1.3),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text('January 21, 2021 at 11:00 pm',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                width: double.infinity,
                child: Wrap(children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 25.0,
                          child: Text(
                            '#software',
                            style: TextStyle(color: defaultColor),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 25.0,
                          child: Text(
                            '#flutter',
                            style: TextStyle(color: defaultColor),
                          )),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
                height: 160.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/handsome.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              '120',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.message,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              '120 comments',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg'),
                        ),
                        SizedBox(
                          width: 1.0,
                        ),
                        Text('write a comment',
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}
