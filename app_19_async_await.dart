Map<int, String> users = {
  1: "user1@email.com",
  2: "user2@email.com",
  3: "user3@email.com",
};

Map<String, List<String>> posts = {
  "user1@email.com": ["post1 by user1", "post2 by user1", "post3 by user1"],
  "user2@email.com": ["post1 by user2", "post2 by user2", "post3 by user2"],
};

void main() async {
  print('Start');
  List<String> userPosts = [];
  try {
    userPosts = await fetchUserPosts(userId: 88);
  } catch (err) {
    print('exception is $err');
  }
  print('End , Found ${userPosts.length} posts');
}

Future<List<String>> fetchUserPosts({required userId}) async {
  String user = await getUser(userId);
  List<String> posts = await getPosts(user);
  posts.forEach(print);

  // (await getPosts(await getUser(userId))).forEach(print);

  print("Work is Completed");
  return posts;
}

Future<String> getUser(int userId) {
  return Future.delayed(Duration(seconds: 2), () {
    print("getting user by id: $userId ");
    return users[userId] ?? Future.error("Failed to load user: Unfound User");
  });
}

Future<List<String>> getPosts(String user) {
  return Future.delayed(Duration(seconds: 2), () {
    print("getting posts of: $user....");
    return posts[user] ?? Future.error("Failed to load posts: Unfound posts");
  });
}
