import 'package:flutter/material.dart';

void main() {
  runApp(const BusinessApp());
}

class BusinessApp extends StatelessWidget {
  const BusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileCardScreen(),
    ); 
  }
}

class ProfileCardScreen extends StatefulWidget{
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  bool _isFollowing = false;
  bool _isLiked = false;
  int _followerCount = 10000000;
  int _likesCount = 1000;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('developer Profile'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(
        child: Card(
          elevation: 6,
          child:Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('web/icons/my_photo.png'),
                ),
                SizedBox(height: 16),
                Text('Rakhmatullayev Shakhruz'),
                Text('Ladies Heartbreaker'),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$_followerCount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Column(
                        children: [
                          Text(
                            '$_likesCount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Likes ❤️',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleFollow,
                      icon: Icon(_isFollowing ? Icons.check : Icons.person_add),
                      label: Text(_isFollowing ? 'Following' : 'Follow'),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _toggleLike,
                      label: Text(_isLiked ? 'Liked' : 'like'),
                    ),
                    
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _resetButton,
                      label: Text('reset')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      if (_isFollowing){
        _followerCount++;
      }
      else {
        _followerCount--;
      }
    });
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked){
        _likesCount++;
      }
      else {
        _likesCount--;
      }
    });
  }
  void _resetButton () {
    setState(() {
      _isFollowing = false;
      _isLiked = false;
      _followerCount = 10000000;
      _likesCount = 1000;
    });
  }
}






