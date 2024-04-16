# Nxt-FC DUAL



![Nxt-FC](https://khalil-picgo-1321910894.cos.ap-hongkong.myqcloud.com/images/202404161605587.png)

> All GPIO & function small size PX4 for UAV research for HKUST UAV-Group

ArduPilot and PX4 firmware are supported !

Dimension of Nxt-FC: 27mmx32mmx8mm

Micoair is now producing Nxt-FC:  [Micoair official website](https://micoair.com/index.php/flightcontroller_nxtpx4v2/) [Taobao](https://item.taobao.com/item.htm?id=720171355815&spm=a1z10.1-c-s.w4004-25090944919.4.188ad2c4TMdjoU) [Ali-Express](https://www.aliexpress.com/item/1005006044318535.html?gps-id=pcStoreJustForYou&scm=1007.23125.137358.0&scm_id=1007.23125.137358.0&scm-url=1007.23125.137358.0&pvid=d0d3d352-9d44-4efb-a90d-83d814b7750d&_t=gps-id:pcStoreJustForYou,scm-url:1007.23125.137358.0,pvid:d0d3d352-9d44-4efb-a90d-83d814b7750d,tpp_buckets:668%232846%238108%231977&pdp_npi=4%40dis%21USD%2168.82%2168.82%21%21%21498.00%21498.00%21%402103094c17132550041616003e82e6%2112000035464129852%21rec%21HK%21%21AB&spm=a2g0o.store_pc_home.smartJustForYou_2005294076979.1005006044318535)

![image-20240417000420113](https://khalil-picgo-1321910894.cos.ap-hongkong.myqcloud.com/images/202404170004223.png)

![image-20240417000600083](https://khalil-picgo-1321910894.cos.ap-hongkong.myqcloud.com/images/202404170006223.png)

| UART   | TTY             | SerialName       | Suggest Funcion                                                                      |
| ------ | --------------- | ---------------- | ------------------------------------------------------------------------------------ |
| USART1 | /dev/ttyS0      | SERIAL_GPS1      |                                                                                   |
| USART2 | /dev/ttyS1      | SERIAL_GPS2      |                                                                                   |
| USART3 | /dev/ttyS2 | SERIAL_TEL1 |  |
| UART4  | /dev/ttyS3      | SERIAL_TEL2      |                         |
| UART5 | /dev/ttyS4 | SERIAL_RC | Receiver |
| USART6 | /dev/ttyS5 | Debug       | Currently not available, can be enable |
| UART7 | /dev/ttyS6     | SERIAL_TEL3      | AUX                                                                                  |
| UART8 | /dev/ttyS7 | SERIAL_TEL4 | AUX |

## Getting start

### Use precompiled bootloader and firmware

1. Use the firmware files from ./firmware.

2. QGC upgrade is also available.

### Compile locally

Follow the PX4 standard approach.

Bootloader:

```shell
make hkust_nxt-dual_bootloader
```

Firmware:

```shell
make hkust_nxt-dual
```

## Setting up Nx-FC

### PX4 Configuration settings

#### Power

Set power_source  **Power Module**, then calibrate voltage and current analog data

![1683205772803](https://raw.githubusercontent.com/Peize-Liu/my-images/master/202309060126575.png)

#### Receiver

Set **RC_PORT_CONFIG** with **Radio controller**

![1683205983224](https://raw.githubusercontent.com/Peize-Liu/my-images/master/202309060126964.png)

#### MAVLink

Set **MAV_0_CONFIG** with **TELEM 2**

![1683206065854](https://raw.githubusercontent.com/Peize-Liu/my-images/master/202309060127686.png)

#### HIGH_RES_IMU and High frequency /imu/data

create file in your tf-card  /etc/extras.txt

```txt
mavlink stream -d /dev/ttyS3 -s ATTITUDE -r 200

mavlink stream -d /dev/ttyS3 -s HIGHRES_IMU -r 1000
```

then using the following settings

IMU_GYRO_RATEMAX: 2000Hz

IMU_INTEG_RATE: 400Hz

MAV_0_MODE: External vision

Set Uart4 to 921600

MAV_0_RATE 92160B/s

**after these settings you will have  250Hz /imu/data_raw /imu/data**

## TODO

- [ ]  500Hz stable firmware based on PX4 1.14 
