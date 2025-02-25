class MqttConfig {
  String? broker;
  int? port;
  String? clientID;
  String? username;
  String? password;
  String? topicname;
  String? pid;

  MqttConfig(
      {this.broker,
      this.port,
      this.clientID,
      this.username,
      this.password,
      this.topicname,
      this.pid});

  MqttConfig.fromJson(Map<String, dynamic> json) {
    broker = json['broker'];
    port = json['port'];
    clientID = json['clientID'];
    username = json['username'];
    password = json['password'];
    topicname = json['topicname'];
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['broker'] = broker;
    data['port'] = port;
    data['clientID'] = clientID;
    data['username'] = username;
    data['password'] = password;
    data['topicname'] = topicname;
    data['pid'] = pid;
    return data;
  }
}
