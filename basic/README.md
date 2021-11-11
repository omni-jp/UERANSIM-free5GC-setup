## 基本構成

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
Creating network "basic_default" with the default driver
Creating network "basic_privnet" with the default driver
Creating gtp5g_installer ... done
Creating mongodb         ... done
Creating webui           ... done
Creating nrf             ... done
Creating udr             ... done
Creating ausf            ... done
Creating amf             ... done
Creating pcf             ... done
Creating udm             ... done
Creating nssf            ... done
Creating ueransim        ... done
Creating upf1            ... done
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
[2021-11-11 15:32:49.569] [nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2021-11-11 15:32:49.569] [rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2021-11-11 15:32:49.570] [nas] [info] Selected plmn[208/93]
[2021-11-11 15:32:49.570] [rrc] [info] Selected cell plmn[208/93] tac[1] category[SUITABLE]
[2021-11-11 15:32:49.570] [nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2021-11-11 15:32:49.570] [nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2021-11-11 15:32:49.570] [nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2021-11-11 15:32:49.570] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-11-11 15:32:49.570] [nas] [debug] Sending Initial Registration
[2021-11-11 15:32:49.570] [nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2021-11-11 15:32:49.570] [rrc] [debug] Sending RRC Setup Request
[2021-11-11 15:32:49.570] [rrc] [info] RRC connection established
[2021-11-11 15:32:49.570] [rrc] [info] UE switches to state [RRC-CONNECTED]
[2021-11-11 15:32:49.570] [nas] [info] UE switches to state [CM-CONNECTED]
[2021-11-11 15:32:49.596] [nas] [debug] Authentication Request received
[2021-11-11 15:32:49.604] [nas] [debug] Security Mode Command received
[2021-11-11 15:32:49.604] [nas] [debug] Selected integrity[2] ciphering[0]
[2021-11-11 15:32:49.645] [nas] [debug] Registration accept received
[2021-11-11 15:32:49.645] [nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2021-11-11 15:32:49.645] [nas] [debug] Sending Registration Complete
[2021-11-11 15:32:49.645] [nas] [info] Initial Registration is successful
[2021-11-11 15:32:49.645] [nas] [debug] Sending PDU Session Establishment Request
[2021-11-11 15:32:49.645] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2021-11-11 15:32:49.894] [nas] [debug] PDU Session Establishment Accept received
[2021-11-11 15:32:49.894] [nas] [info] PDU Session establishment is successful PSI[1]
[2021-11-11 15:32:49.905] [app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun0, 60.60.0.1] is up.
all UEs started
```

### 確認


```
docker exec -it ueransim bash
ping -I uesimtun0 8.8.8.8
```

```
root@cd96e9e378f2:/UERANSIM# ping -I uesimtun0 8.8.8.8 -c 4
PING 8.8.8.8 (8.8.8.8) from 60.60.0.1 uesimtun0: 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=14.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=16.5 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=15.4 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=16.5 ms

--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3006ms
rtt min/avg/max/mdev = 14.574/15.769/16.586/0.842 ms
```


