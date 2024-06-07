import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelGroupKey: 'default_channel_group',
        channelKey: 'default_channel',
        channelName: 'Default notifications',
        channelDescription: 'Notification channel for default Notifications',
        importance: NotificationImportance.Default,
      ),
      NotificationChannel(
        channelGroupKey: 'high_channel_group',
        channelKey: 'high_channel',
        channelName: 'High Importance notifications',
        channelDescription: 'Notification channel for High Importance',
        importance: NotificationImportance.High
      )
    ],
  // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'default_channel_group',
        channelGroupName: 'Group 1'),
      NotificationChannelGroup(
        channelGroupKey: 'high_channel_group', 
        channelGroupName: 'Group 2')
    ],
    debug: true
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Notifications',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                  if (!isAllowed) {
                    AwesomeNotifications().requestPermissionToSendNotifications();
                  } else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Permissions Already Granted'),
                      )
                    );
                  }
                });
              },
              child: const Text('Request Permissions')
            ),
            OutlinedButton(
              onPressed: () {
                AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                  if (!isAllowed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notifications have been disabled'),
                      )
                    );
                  } else{
                    AwesomeNotifications().createNotification(
                      content: NotificationContent(
                        id: 1,
                        channelKey: 'default_channel',
                        actionType: ActionType.Default,
                        title: 'Default Notification',
                        body: 'This is a DEFAULT notification!',
                      )
                    );
                  }
                });
              },
              child: const Text('Default Notification')
            ),
            OutlinedButton(
              onPressed: () {
                AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                  if (!isAllowed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notifications have been disabled'),
                      )
                    );
                  } else{
                    AwesomeNotifications().createNotification(
                      content: NotificationContent(
                        id: 2,
                        channelKey: 'high_channel',
                        actionType: ActionType.Default,
                        title: 'High Importance',
                        body: 'This is a notification of High Importance',
                      )
                    );
                  }
                });
              },
              child: const Text('On Screen Notification')
            ),
          ],
        ),
      )
    );
  }
}




