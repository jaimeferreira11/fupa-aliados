class TokenModel {
  String accessToken;
  String tokenType;
  String refreshToken;
  String scope;

  TokenModel(
      {this.accessToken, this.tokenType, this.refreshToken, this.scope});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['refresh_token'] = this.refreshToken;
    data['scope'] = this.scope;
    return data;
  }
}
