# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true

PATH=$PATH:/opt/local/bin:$HOME/bin
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/utils/zlib/target/lib
#. /opt/petalinux/2019.1/settings.sh

#source /opt/petalinux/2019.1/environment-setup-aarch64-xilinx-linux
#source /opt/petalinux/2019.1/settings.sh


_sel(){
    echo "1. arm-none-linux-gnueabi ( 4.3.2 2008q3-72 ) - ( T2200          ) "
    echo "2. aarch64-xilinx-linux   ( 8.2.0  - 2019.1 ) - ( DKK NOKIA LGE  ) "
    echo "3. aarch64-xilinx-linux   ( 11.2.0 - 2022.2 ) - ( UQ             ) "
    echo "4. arm-none-linux-gnueabi ( 4.8.3           ) - ( JTower MU, HU  ) "
    echo "5. aarch64-xilinx-linux   ( 9.2.0  - 2020.2 ) - ( JTOWER OIU) "
    echo "6. aarch64-xilinx-linux   ( 12.2.0 - 2023.1 ) - ( UQ[DPD], N-DAS MU-RU, J-TOWER R1 ) "
    echo "7. aarch64-xilinx-linux   ( 12.2.0 - 2023.2 ) - ( UPLUS_5G_MB_VE ) "
    echo "8. aarch64-xilinx-linux   ( 8.2.0  - 2019.1 ) - ( O-RAN(SSHv3)   ) "
    echo "9. aarch64-xilinx-linux   ( 8.2.0  - 2020.1 ) - ( O-RAN(MONOCLOCK)) "
    echo "10. arm-linux-gnueabi-gcc ( 7.5.0           ) - ( N-DAS HU       ) "
    echo "11. aarch64-linux-gnu-gcc ( 8.2.0  - 2019.1 ) - ( DKK(old)A2K ) "

    #sel=8
    read sel

    case $sel in
        1)
            P=/opt/t2200/arm-2008q3/bin
            PATH=$PATH:$P
            CROSS_COMPILE=arm-none-linux-gnueabi-gcc
            echo $P
            $CROSS_COMPILE -v
            ;;
        2)
            PATH_HEADER=/opt/petalinux/2019.1
            P=$PATH_HEADER/sysroots/aarch64-xilinx-linux
            CROSS_COMPILE=aarch64-xilinx-linux-gcc
            echo ""
            echo ". $PATH_HEADER/environment-setup-aarch64-xilinx-linux"
            . $PATH_HEADER/environment-setup-aarch64-xilinx-linux
            echo ". $PATH_HEADER/settings.sh"
            . $PATH_HEADER/settings.sh
            echo ""
            export PATH="$P:$PATH"
            ;;
        3)
            PATH_HEADER=/opt/petalinux/2022.2
            P=$PATH_HEADER/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux
            CROSS_COMPILE=aarch64-xilinx-linux-gcc
            echo "다음 명령어를 실행하세요"
            echo ""
            echo ". $PATH_HEADER/environment-setup-cortexa72-cortexa53-xilinx-linux"
            echo ". /opt/petalinux/2022.2/settings.sh;"
            echo "$CROSS_COMPILE -v"
            echo ""
            echo "PATH => $P"
            ;;
        4)
            P=/opt/arm-2014.05/bin
            PATH=$PATH:$P
            CROSS_COMPILE=arm-none-linux-gnueabi-gcc
            echo $P
            $CROSS_COMPILE -v
            ;;
        5)
            PATH_HEADER=/opt/petalinux/2020.2
            P=$PATH_HEADER/sysroots/aarch64-xilinx-linux
            CROSS_COMPILER=aarch64-xilinx-linux-gcc
            echo "다음 명령어를 실행하세요"
            echo ""
            echo ". $PATH_HEADER/environment-setup-aarch64-xilinx-linux"
            echo "$CROSS_COMPILER -v"
            echo ""
            export PATH="$P:$PATH"

            . $PATH_HEADER/environment-setup-aarch64-xilinx-linux
            . $PATH_HEADER/settings.sh
            $CROSS_COMPILER -v
            ;;
        6)
            PATH_HEADER=/opt/petalinux/2023.1
            P=$PATH_HEADER/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/
            CROSS_COMPILE=aarch64-xilinx-linux-gcc
            echo "다음 명령어를 실행하세요"
            echo ""
            echo ". $PATH_HEADER/environment-setup-cortexa72-cortexa53-xilinx-linux"
            echo ". $PATH_HEADER/settings.sh"
            echo "$CROSS_COMPILER -v"
            echo ""
            echo "PATH => $P"

            . $PATH_HEADER/environment-setup-cortexa72-cortexa53-xilinx-linux
            . $PATH_HEADER/settings.sh
            #$CROSS_COMPILER -v
            #echo ". $PATH_HEADER/environment-setup-aarch64-xilinx-linux"
            #. $PATH_HEADER/environment-setup-aarch64-xilinx-linux
            #echo ". $PATH_HEADER/settings.sh"
            #. $PATH_HEADER/settings.sh
            #echo "다음 명령어를 실행하세요"
            #echo ""
            #echo ". $PATH_HEADER/environment-setup-cortexa72-cortexa53-xilinx-linux"
            #echo ". $PATH_HEADER/settings.sh"
            #echo "$CROSS_COMPILE -v"
            #echo ""
            #echo "PATH => $P"
            ;;
        7)
            PATH_HEADER=/opt/petalinux/2023.2
            P=$PATH_HEADER/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/
            CROSS_COMPILER=aarch64-xilinx-linux-gcc
            echo "다음 명령어를 실행하세요"
            echo ""
            echo ". $PATH_HEADER/environment-setup-cortexa72-cortexa53-xilinx-linux"
            echo "$CROSS_COMPILER -v"
            echo ""
            echo "PATH => $P"

            . $PATH_HEADER/environment-setup-cortexa72-cortexa53-xilinx-linux
            $CROSS_COMPILER -v
            ;;
        8)
            PATH_HEADER=/opt/petalinux/2019.1_SSLv3
            P=$PATH_HEADER/sysroots/aarch64-xilinx-linux
            CROSS_COMPILER=aarch64-xilinx-linux-gcc
            echo "다음 명령어를 실행하세요"
            echo ""
            echo ". $PATH_HEADER/environment-setup-aarch64-xilinx-linux"
            echo "$CROSS_COMPILER -v"
            echo ""
            export PATH="$P:$PATH"

            . $PATH_HEADER/environment-setup-aarch64-xilinx-linux
            $CROSS_COMPILER -v
            ;;
        9)
            PATH_HEADER=/opt/petalinux/2020.1
            P=$PATH_HEADER/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/
            CROSS_COMPILE=aarch64-xilinx-linux-gcc
            echo ". $PATH_HEADER/environment-setup-aarch64-xilinx-linux"
            . $PATH_HEADER/environment-setup-aarch64-xilinx-linux
            echo ". $PATH_HEADER/settings.sh"
            . $PATH_HEADER/settings.sh
            #echo "다음 명령어를 실행하세요"
            #echo ""
            #echo ". $PATH_HEADER/environment-setup-cortexa72-cortexa53-xilinx-linux"
            #echo ". $PATH_HEADER/settings.sh"
            #echo "$CROSS_COMPILE -v"
            #echo ""
            echo "PATH => $P"
            ;;
        10)
            CROSS_COMPILE=arm-linux-gnueabi-gcc
            $CROSS_COMPILE -v
            ;;
        11)
             PATH_HEADER=/opt/petalinux/2019_A2K
             P=$PATH_HEADER/sysroots/aarch64/lin/aarch64-linux/bin
             CROSS_COMPILE=aarch64-linux-gnu-gcc
            echo ". $PATH_HEADER/settings.sh"
            . $PATH_HEADER/settings.sh
             export PATH="$P:$PATH"
             ;;
        *)
            echo "select compiler number"
            ;;
    esac

}




































