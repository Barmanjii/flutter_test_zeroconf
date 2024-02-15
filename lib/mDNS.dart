// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Example script to illustrate how to use the mdns package to discover the port
// of a Dart observatory over mDNS.

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test_zeroconf/ssh.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:flutter_test_zeroconf/params.dart';

Future<void> mDNS() async {
  // Parse the command line arguments.
  final robot = Robot();
  await robot.getMachineId(); // Call the method to retrieve the machine ID

  final String name = "_${robot.machineId}._tcp.local";
  final MDnsClient client = MDnsClient();
  // Start the client with default options.
  await client.start();

  // Get the PTR record for the service.
  await for (final PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    // Use the domainName from the PTR record to get the SRV record,
    // which will have the port and local hostname.
    // Note that duplicate messages may come through, especially if any
    // other mDNS queries are running elsewhere on the machine.
    await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      final String targetHostname = srv.target;
      final List<InternetAddress> addresses =
          await InternetAddress.lookup(targetHostname);
      for (var address in addresses) {
        final String roobtIPAddress = address.address;
        dartssh2(roobtIPAddress);
        print(
            'Resolved address: ${address.address} , Target:Port ${srv.target}:${srv.port} ');
      }
    }
  }
  client.stop();

  print('Done.');
}
