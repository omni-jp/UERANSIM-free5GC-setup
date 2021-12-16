## multi UPF構成

### 必要なDockerイメージを取得

```
docker-compose pull
```

### 各コンポーネントを立ち上げる

```
docker-compose up -d
```

```
$ docker-compose up -d
Creating network "multiupf1_default" with the default driver
Creating network "multiupf1_privnet" with the default driver
Creating mongodb         ... done
Creating tshark          ... done
Creating gtp5g_installer ... done
Creating webui           ... done
Creating nrf             ... done
Creating nssf            ... done
Creating amf             ... done
Creating udr             ... done
Creating pcf             ... done
Creating udm             ... done
Creating ausf            ... done
Creating ueransim        ... done
Creating upf1            ... done
Creating upf2            ... done
Creating smf             ... done
```

### SIM登録

1. http://<server.address>:5000 にアクセス
2. admin/free5gc でログイン
3. SUBSCRIBERSに進み、"New Subscriber"をクリック
4. 初期値のままで、"Submit"をクリック
5. 再度"New Subscriber"をクリックしUE2を登録する
6. SUPIを"208930000000004"と変更して"Submit"をクリック

### UEを接続


```
./create_ue_session.sh
```

2つのUEのIPアドレスがアサインされていることを確認

```
$ ./create_ue_session.sh
Start 2 UE instances
UERANSIM v3.2.4
[2021-12-16 09:51:51.547] [nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2021-12-16 09:51:51.548] [rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2021-12-16 09:51:51.548] [nas] [info] Selected plmn[208/93]
[2021-12-16 09:51:51.548] [rrc] [info] Selected cell plmn[208/93] tac[1] category[SUITABLE]
[2021-12-16 09:51:51.548] [nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2021-12-16 09:51:51.548] [nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2021-12-16 09:51:51.548] [nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2021-12-16 09:51:51.551] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-16 09:51:51.551] [nas] [debug] Sending Initial Registration
[2021-12-16 09:51:51.551] [nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2021-12-16 09:51:51.551] [rrc] [debug] Sending RRC Setup Request
[2021-12-16 09:51:51.551] [rrc] [info] RRC connection established
[2021-12-16 09:51:51.551] [rrc] [info] UE switches to state [RRC-CONNECTED]
[2021-12-16 09:51:51.551] [nas] [info] UE switches to state [CM-CONNECTED]
[2021-12-16 09:51:51.574] [nas] [debug] Authentication Request received
[2021-12-16 09:51:51.582] [nas] [debug] Security Mode Command received
[2021-12-16 09:51:51.582] [nas] [debug] Selected integrity[2] ciphering[0]
[2021-12-16 09:51:51.635] [nas] [debug] Registration accept received
[2021-12-16 09:51:51.635] [nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2021-12-16 09:51:51.635] [nas] [debug] Sending Registration Complete
[2021-12-16 09:51:51.636] [nas] [info] Initial Registration is successful
[2021-12-16 09:51:51.636] [nas] [debug] Sending PDU Session Establishment Request
[2021-12-16 09:51:51.636] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-16 09:51:51.880] [nas] [debug] PDU Session Establishment Accept received
[2021-12-16 09:51:51.880] [nas] [info] PDU Session establishment is successful PSI[1]
[2021-12-16 09:51:51.889] [app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun0, 60.60.0.1] is up.
UERANSIM v3.2.4
[2021-12-16 09:51:53.547] [nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2021-12-16 09:51:53.548] [rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2021-12-16 09:51:53.548] [nas] [info] Selected plmn[208/93]
[2021-12-16 09:51:53.548] [rrc] [info] Selected cell plmn[208/93] tac[1] category[SUITABLE]
[2021-12-16 09:51:53.548] [nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2021-12-16 09:51:53.548] [nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2021-12-16 09:51:53.548] [nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2021-12-16 09:51:53.548] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-16 09:51:53.548] [nas] [debug] Sending Initial Registration
[2021-12-16 09:51:53.549] [nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2021-12-16 09:51:53.549] [rrc] [debug] Sending RRC Setup Request
[2021-12-16 09:51:53.549] [rrc] [info] RRC connection established
[2021-12-16 09:51:53.549] [rrc] [info] UE switches to state [RRC-CONNECTED]
[2021-12-16 09:51:53.549] [nas] [info] UE switches to state [CM-CONNECTED]
[2021-12-16 09:51:53.571] [nas] [debug] Authentication Request received
[2021-12-16 09:51:53.577] [nas] [debug] Security Mode Command received
[2021-12-16 09:51:53.577] [nas] [debug] Selected integrity[2] ciphering[0]
[2021-12-16 09:51:53.607] [nas] [debug] Registration accept received
[2021-12-16 09:51:53.607] [nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2021-12-16 09:51:53.607] [nas] [debug] Sending Registration Complete
[2021-12-16 09:51:53.607] [nas] [info] Initial Registration is successful
[2021-12-16 09:51:53.607] [nas] [debug] Sending PDU Session Establishment Request
[2021-12-16 09:51:53.607] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-16 09:51:53.844] [nas] [debug] PDU Session Establishment Accept received
[2021-12-16 09:51:53.844] [nas] [info] PDU Session establishment is successful PSI[1]
[2021-12-16 09:51:53.852] [app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun1, 60.61.0.1] is up.
all UEs started

```

### 確認


```
docker exec -it ueransim bash
ping -I uesimtun0 8.8.8.8 -c 4
ping -I uesimtun1 8.8.8.8 -c 4
```

```
root@cd96e9e378f2:/UERANSIM# ping -I uesimtun0 8.8.8.8 -c 4
PING 8.8.8.8 (8.8.8.8) from 60.60.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=16.5 ms

root@cd96e9e378f2:/UERANSIM# ping -I uesimtun1 8.8.8.8 -c 4
PING 8.8.8.8 (8.8.8.8) from 60.61.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=16.5 ms

```

`pcap/test.pcap`をWireSharkで開き、icmpでフィルタするとuesimtun0とuesimtun1で経路が異なることが確認できる
