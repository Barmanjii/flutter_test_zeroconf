import 'package:dartssh2/dartssh2.dart';

void dartssh2(String robotIP) async {
  final socket = await SSHSocket.connect(robotIP, 22);

  final client = SSHClient(socket,
      username: 'peppermint', onPasswordRequest: () => "Ppmt@1234");

  client.close();
  await client.done;
}
