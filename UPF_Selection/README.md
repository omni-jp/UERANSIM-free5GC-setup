## UPF selection 構成

### 必要なDockerイメージを取得

```
docker-compose pull
```

### 各コンポーネントを立ち上げる

```
docker-compose up -d
```

```
ubuntu@ubuntu:~/omni-handson/UERANSIM-free5GC-setup/UPF_Selection$ docker-compose up -d
Creating network "upf_selection_default" with the default driver
Creating network "upf_selection_privnet" with the default driver
Creating gtp5g_installer ... done
Creating mongodb         ... done
Creating tshark          ... done
Creating webui           ... done
Creating nrf             ... done
Creating ausf            ... done
Creating amf2            ... done
Creating nssf            ... done
Creating amf1            ... done
Creating udr             ... done
Creating pcf             ... done
Creating udm             ... done
Creating ueransim_gnb1   ... done
Creating ueransim_gnb2   ... done
Creating ueransim        ... done
Creating upf2            ... done
Creating upf1            ... done
Creating smf2            ... done
Creating smf1            ... done
```

### SIM登録

1. http://<server.address>:5000 にアクセス
2. admin/free5gc でログイン
3. SUBSCRIBERSに進み、"New Subscriber"をクリック
4. 初期値のままで、"Submit"をクリック

### UE1を接続


```
./create_ue_session.sh 1
```

UE1のIPアドレスがアサインされていることを確認

```
$ ./create_ue_session.sh 1
UERANSIM v3.2.5
[2021-12-21 15:52:29.506] [nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2021-12-21 15:52:29.506] [rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2021-12-21 15:52:29.507] [nas] [info] Selected plmn[208/93]
[2021-12-21 15:52:29.507] [rrc] [info] Selected cell plmn[208/93] tac[1] category[SUITABLE]
[2021-12-21 15:52:29.507] [nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2021-12-21 15:52:29.507] [nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2021-12-21 15:52:29.507] [nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2021-12-21 15:52:29.507] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-21 15:52:29.507] [nas] [debug] Sending Initial Registration
[2021-12-21 15:52:29.507] [nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2021-12-21 15:52:29.507] [rrc] [debug] Sending RRC Setup Request
[2021-12-21 15:52:29.507] [rrc] [info] RRC connection established
[2021-12-21 15:52:29.507] [rrc] [info] UE switches to state [RRC-CONNECTED]
[2021-12-21 15:52:29.507] [nas] [info] UE switches to state [CM-CONNECTED]
[2021-12-21 15:52:29.531] [nas] [debug] Authentication Request received
[2021-12-21 15:52:29.539] [nas] [debug] Security Mode Command received
[2021-12-21 15:52:29.540] [nas] [debug] Selected integrity[2] ciphering[0]
[2021-12-21 15:52:29.583] [nas] [debug] Registration accept received
[2021-12-21 15:52:29.583] [nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2021-12-21 15:52:29.583] [nas] [debug] Sending Registration Complete
[2021-12-21 15:52:29.583] [nas] [info] Initial Registration is successful
[2021-12-21 15:52:29.583] [nas] [debug] Sending PDU Session Establishment Request
[2021-12-21 15:52:29.583] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-21 15:52:29.831] [nas] [debug] PDU Session Establishment Accept received
[2021-12-21 15:52:29.832] [nas] [info] PDU Session establishment is successful PSI[1]
[2021-12-21 15:52:29.842] [app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun0, 60.60.0.1] is up.
UE started
```

### UE1からの接続確認


```
docker exec -it ueransim bash
ping -I uesimtun0 8.8.8.8 -c 4
```

```
root@cd96e9e378f2:/UERANSIM# ping -I uesimtun0 8.8.8.8 -c 4
PING 8.8.8.8 (8.8.8.8) from 60.60.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=16.5 ms
```

### UE1を切断

コンテナを再起動してUE1を切断する。

```
docker restart ueransim
```

### UE2を接続

```
./create_ue_session.sh 2
```

UE2のIPアドレスがアサインされていることを確認

```
$ ./create_ue_session.sh 2
UERANSIM v3.2.5
[2021-12-21 15:56:03.330] [nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2021-12-21 15:56:03.331] [rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2021-12-21 15:56:03.331] [nas] [info] Selected plmn[208/93]
[2021-12-21 15:56:03.331] [rrc] [info] Selected cell plmn[208/93] tac[2] category[SUITABLE]
[2021-12-21 15:56:03.331] [nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2021-12-21 15:56:03.331] [nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2021-12-21 15:56:03.331] [nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2021-12-21 15:56:03.331] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-21 15:56:03.331] [nas] [debug] Sending Initial Registration
[2021-12-21 15:56:03.331] [nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2021-12-21 15:56:03.331] [rrc] [debug] Sending RRC Setup Request
[2021-12-21 15:56:03.332] [rrc] [info] RRC connection established
[2021-12-21 15:56:03.332] [rrc] [info] UE switches to state [RRC-CONNECTED]
[2021-12-21 15:56:03.332] [nas] [info] UE switches to state [CM-CONNECTED]
[2021-12-21 15:56:03.347] [nas] [debug] Authentication Request received
[2021-12-21 15:56:03.354] [nas] [debug] Security Mode Command received
[2021-12-21 15:56:03.354] [nas] [debug] Selected integrity[2] ciphering[0]
[2021-12-21 15:56:03.385] [nas] [debug] Registration accept received
[2021-12-21 15:56:03.385] [nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2021-12-21 15:56:03.385] [nas] [debug] Sending Registration Complete
[2021-12-21 15:56:03.385] [nas] [info] Initial Registration is successful
[2021-12-21 15:56:03.385] [nas] [debug] Sending PDU Session Establishment Request
[2021-12-21 15:56:03.385] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-21 15:56:03.630] [nas] [debug] PDU Session Establishment Accept received
[2021-12-21 15:56:03.630] [nas] [info] PDU Session establishment is successful PSI[1]
[2021-12-21 15:56:03.639] [app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun1, 60.61.0.1] is up.
UE started
```

### UE2からの接続確認


```
docker exec -it ueransim bash
ping -I uesimtun0 8.8.8.8 -c 4
```

```
root@cd96e9e378f2:/UERANSIM# ping -I uesimtun0 8.8.8.8 -c 4
PING 8.8.8.8 (8.8.8.8) from 60.61.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=16.5 ms
```

### パケットキャプチャ


`pcap/test.pcap`をWireSharkで開き、icmpでフィルタするとUE1, UE2で経路が異なることが確認できる
