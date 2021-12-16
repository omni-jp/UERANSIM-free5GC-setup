## ULCL構成

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
Creating network "ulcl_default" with the default driver
Creating network "ulcl_privnet" with the default driver
Creating gtp5g_installer ... done
Creating tshark          ... done
Creating mongodb         ... done
Creating nrf             ... done
Creating webui           ... done
Creating udm             ... done
Creating amf             ... done
Creating udr             ... done
Creating nssf            ... done
Creating pcf             ... done
Creating ausf            ... done
Creating ueransim        ... done
Creating upf2            ... done
Creating upf1            ... done
Creating upf3            ... done
Creating smf             ... done
```

### SIM登録

1. http://<server.address>:5000 にアクセス
2. admin/free5gc でログイン
3. SUBSCRIBERSに進み、"New Subscriber"をクリック
4. 初期値のままで、"Submit"をクリック


### UEを接続


```
./create_ue_session.sh
```

```
$ ./create_ue_session.sh
Start 1 UE instances
UERANSIM v3.2.4
[2021-12-15 16:19:50.648] [nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2021-12-15 16:19:50.648] [rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2021-12-15 16:19:50.648] [nas] [info] Selected plmn[208/93]
[2021-12-15 16:19:50.648] [rrc] [info] Selected cell plmn[208/93] tac[1] category[SUITABLE]
[2021-12-15 16:19:50.648] [nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2021-12-15 16:19:50.648] [nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2021-12-15 16:19:50.648] [nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2021-12-15 16:19:50.648] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-15 16:19:50.648] [nas] [debug] Sending Initial Registration
[2021-12-15 16:19:50.649] [nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2021-12-15 16:19:50.649] [rrc] [debug] Sending RRC Setup Request
[2021-12-15 16:19:50.649] [rrc] [info] RRC connection established
[2021-12-15 16:19:50.649] [rrc] [info] UE switches to state [RRC-CONNECTED]
[2021-12-15 16:19:50.649] [nas] [info] UE switches to state [CM-CONNECTED]
[2021-12-15 16:19:50.674] [nas] [debug] Authentication Request received
[2021-12-15 16:19:50.681] [nas] [debug] Security Mode Command received
[2021-12-15 16:19:50.682] [nas] [debug] Selected integrity[2] ciphering[0]
[2021-12-15 16:19:50.726] [nas] [debug] Registration accept received
[2021-12-15 16:19:50.726] [nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2021-12-15 16:19:50.726] [nas] [debug] Sending Registration Complete
[2021-12-15 16:19:50.726] [nas] [info] Initial Registration is successful
[2021-12-15 16:19:50.727] [nas] [debug] Sending PDU Session Establishment Request
[2021-12-15 16:19:50.727] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-12-15 16:19:50.978] [nas] [debug] PDU Session Establishment Accept received
[2021-12-15 16:19:50.978] [nas] [info] PDU Session establishment is successful PSI[1]
[2021-12-15 16:19:50.991] [app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun0, 60.60.0.1] is up.
all UEs started
```

### 確認


```
docker exec -it ueransim bash
ping -I uesimtun0 8.8.8.8 -c 4
ping -I uesimtun0 1.1.1.1 -c 4
ping -I uesimtun0 8.8.4.4 -c 4
```

```
root@cd96e9e378f2:/UERANSIM# ping -I uesimtun0 8.8.8.8 -c 4
PING 8.8.8.8 (8.8.8.8) from 60.60.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=16.5 ms

root@cd96e9e378f2:/UERANSIM# ping -I uesimtun0 1.1.1.1 -c 4
PING 1.1.1.1 (1.1.1.1) from 60.60.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 1.1.1.1: icmp_seq=4 ttl=117 time=16.5 ms

root@cd96e9e378f2:/UERANSIM# ping -I uesimtun0 8.8.4.4 -c 4
PING 8.8.4.4 (8.8.4.4) from 60.60.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 8.8.4.4: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 8.8.4.4: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 8.8.4.4: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 8.8.4.4: icmp_seq=4 ttl=117 time=16.5 ms
```

`pcap/test.pcap`をWireSharkで開き、icmpでフィルタすると8.8.8.8のみ経路が異なることが確認できる。
