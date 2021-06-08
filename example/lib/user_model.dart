class User {
  final String id;
  final String email;
  final Credentials credentials;

  factory User.demo() => User(
        id: 'e3cd60ee-c876-11eb-b8bc-0242ac130003',
        email: 'me@example.com',
        credentials: Credentials(
          token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
              '.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ'
              '.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
          refreshToken: '0123456789abcdefghijklmnopqrstuvwxyz',
          tokenExpiry: 1623170058,
          type: 'jwt',
        ),
      );

  factory User.fromMap(Map<String, dynamic> root) {
    final credentials = root['credentials'] as Map<String, dynamic>;
    return User(
      id: root['id'] as String,
      email: root['email'] as String,
      credentials: Credentials(
        token: credentials['token'] as String,
        refreshToken: credentials['refreshToken'] as String,
        tokenExpiry: credentials['tokenExpiry'] as int,
        type: credentials['type'] as String,
      ),
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'email': email,
        'credentials': <String, dynamic>{
          'token': credentials.token,
          'refreshToken': credentials.refreshToken,
          'tokenExpiry': credentials.tokenExpiry,
          'type': credentials.type,
        },
      };

  User({required this.id, required this.email, required this.credentials});
}

class Credentials {
  final String token;
  final String refreshToken;
  final int tokenExpiry;
  final String type;

  Credentials({
    required this.token,
    required this.refreshToken,
    required this.tokenExpiry,
    required this.type,
  });
}
