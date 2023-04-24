class Constants {
  static final auth = _Auth();
}

class _Auth {
  get grantTypePassword => "password";

  get grantTypeRefreshToken => "refresh_token";
}
