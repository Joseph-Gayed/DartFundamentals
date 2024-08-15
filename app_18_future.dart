Map<int, String> users = {
  1: "user1@email.com",
  2: "user2@email.com",
  3: "user3@email.com",
};

Map<String, List<String>> posts = {
  "user1@email.com": ["post1 by user1", "post2 by user1", "post3 by user1"],
  "user2@email.com": ["post1 by user2", "post2 by user2", "post3 by user2"],
};

void main() {
  print('Start');
  fetchUserPosts(userId:3);
  print('End');
}

void fetchUserPosts({required userId}) {
  getUser(userId)
  .catchError((err) {
    print('exception is $err');
    return ""; // Return an empty list on error
  })
  .then((user) {
    return getPosts(user);
  })
  .catchError((err) {
    print('exception is $err');
    return <String>[]; // Return an empty list on error
  })
  .then((List<String> posts) {
    posts.forEach(print);
  })
  .catchError((err) {
    print('exception is $err');
  })
  .whenComplete(() => print("Work is Completed"));
}

Future<String> getUser(int userId) {
  return Future.delayed(Duration(seconds: 3), () {
    print("getting user by id: $userId .....");
    return users[userId] ?? Future.error("Failed to load user: Unfound User");
  });
}

Future<List<String>> getPosts(String user) {
  return Future.delayed(Duration(seconds: 3), () {
    print("getting posts of: $user ....");
    return posts[user] ?? Future.error("Failed to load posts: Unfound posts");
  });
}
