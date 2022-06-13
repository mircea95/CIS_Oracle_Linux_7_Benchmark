
#!/bin/bash

##
## Copyright 2021 BSD Management
##
### Variables ###
## This section defines global variables used in the script
args=$@
state=0

help_text() {
    cat  << EOF |fmt -sw99

Profile: Level 1 - Server
Author: BSD Management

This script runs tests on the system to check for compliance against the CIS Oracle Linux 7 Benchmarks.
No changes are made to system files by this script.

  Options:
EOF

    cat << EOF | column -t -s'|'
||-h,|--help|Prints this help text
|||--debug|Run script with debug output turned on


EOF

    cat << EOF

  Examples:
            
EOF

exit 0

} ## Outputs help text
parse_args() {
    args=$@
    
    ## Call help_text function if -h or --help present
    $(echo $args | egrep -- '-h' &>/dev/null) && help_text
} ## Parse arguments passed in to the script

## Section 1 - Filesystem Configuration
## Section 1.1 - Disable unused filesystems
test_1.1.1.1() {
    result=Fail
    echo "1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Automated)"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: modprobe -n -v cramfs | grep -E '(cramfs|install)':"
    echo "---------------------------------------------------"
    modprobe -n -v cramfs | grep -E '(cramfs|install)'
    echo "---------------------------------------------------"
    echo "      COMAND: lsmod | grep cramfs:"
    echo "---------------------------------------------------"
    lsmod | grep cramfs
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(diff -qsZ <(modprobe -n -v cramfs 2>/dev/null | tail -n1) <(echo "install /bin/true") &>/dev/null; echo $?) -ne 0 ] && state=$(( $state + 1 ))
    [ $(lsmod | grep cramfs | wc -l) -ne 0 ] && state=$(( $state + 2 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
    
} 
test_1.1.1.3() {
    result=Fail
    echo "1.1.1.3 Ensure mounting of udf filesystems is disabled (Automated)"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: modprobe -n -v udf | grep -E '(udf|install)':"
    echo "---------------------------------------------------"
    modprobe -n -v udf | grep -E '(udf|install)'
    echo "---------------------------------------------------"
    echo "      COMAND: lsmod | grep udf:"
    echo "---------------------------------------------------"
    lsmod | grep udf
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(diff -qsZ <(modprobe -n -v udf 2>/dev/null | tail -n1) <(echo "install /bin/true") &>/dev/null; echo $?) -ne 0 ] && state=$(( $state + 1 ))
    [ $(lsmod | grep udf | wc -l) -ne 0 ] && state=$(( $state + 2 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
    
} 
test_1.1.2() {
    result=Fail
    echo "1.1.2 Ensure /tmp is configured (Automated)"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: mount | grep -E '\s/tmp\s':"
    echo "---------------------------------------------------"
    mount | grep -E '\s/tmp\s'
    echo "---------------------------------------------------"
    echo "      COMAND: grep -E '\s/tmp\s' /etc/fstab | grep -E -v '^\s*#':"
    echo "---------------------------------------------------"
    grep -E '\s/tmp\s' /etc/fstab | grep -E -v '^\s*#'
    echo "---------------------------------------------------"
    echo "      COMAND: systemctl is-enabled tmp.mount:"
    echo "---------------------------------------------------"
    systemctl is-enabled tmp.mount
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/tmp\s' | wc -l) -eq 0 ] && state=$(( $state + 1 ))
    [ $(grep -E '\s/tmp\s' /etc/fstab | grep -E -v '^\s*#' | wc -l) -eq 0 ] && state=$(( $state + 2 ))
    [ $(diff -qsZ <(systemctl is-enabled tmp.mount 2>/dev/null | tail -n1) <(echo "enabled") &>/dev/null; echo $?) -ne 0 ] && state=$(( $state + 3 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   } 
test_1.1.3() {
    result=Fail
    echo "1.1.3 Ensure noexec option set on /tmp partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: mount | grep -E '\s/tmp\s' | grep -v noexec:"
    echo "---------------------------------------------------"
    mount | grep -E '\s/tmp\s' | grep -v noexec
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/tmp\s' | grep -v noexec | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   } 
test_1.1.4() {
    result=Fail
    echo "1.1.4 Ensure nodev option set on /tmp partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: mount | grep -E '\s/tmp\s' | grep -v nodev:"
    echo "---------------------------------------------------"
    mount | grep -E '\s/tmp\s' | grep -v nodev
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/tmp\s' | grep -v nodev | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.5() {
    result=Fail
    echo "1.1.5 Ensure nosuid option set on /tmp partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount | grep -E '\s/tmp\s' | grep -v nosuid:"
    echo "---------------------------------------------------"
    mount | grep -E '\s/tmp\s' | grep -v nosuid
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/tmp\s' | grep -v nosuid | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.6() {
    result=Fail
    echo "1.1.6 Ensure /dev/shm is configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  *---* :"
    echo "---------------------------------------------------"
    *comanda* 
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/tmp\s' | grep -v nosuid | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.7() {
    result=Fail
    echo "1.1.7 Ensure noexec option set on /dev/shm partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   mount | grep -E '\s/dev/shm\s' | grep -v noexec :"
    echo "---------------------------------------------------"
     mount | grep -E '\s/dev/shm\s' | grep -v noexec
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/dev/shm\s' | grep -v noexec | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.8() {
    result=Fail
    echo "1.1.8 Ensure nodev option set on /dev/shm partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount | grep -E '\s/dev/shm\s' | grep -v nodev :"
    echo "---------------------------------------------------"
    mount | grep -E '\s/dev/shm\s' | grep -v nodev
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/dev/shm\s' | grep -v nodev | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.9() {
    result=Fail
    echo "1.1.9 Ensure nosuid option set on /dev/shm partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount | grep -E '\s/dev/shm\s' | grep -v nosuid :"
    echo "---------------------------------------------------"
    mount | grep -E '\s/dev/shm\s' | grep -v nosuid
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/dev/shm\s' | grep -v nosuid | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.12() {
    result=Fail
    echo "1.1.12 Ensure noexec option set on /var/tmp partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount | grep -E '\s/var/tmp\s' | grep -v noexec:"
    echo "---------------------------------------------------"
    mount | grep -E '\s/var/tmp\s' | grep -v noexec 
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/var/tmp\s' | grep -v noexec | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.13() {
    result=Fail
    echo "1.1.13 Ensure nodev option set on /var/tmp partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount | grep -E '\s/var/tmp\s' | grep -v nodev:"
    echo "---------------------------------------------------"
    mount | grep -E '\s/var/tmp\s' | grep -v nodev
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/var/tmp\s' | grep -v nodev | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.14() {
    result=Fail
    echo "1.1.14 Ensure nosuid option set on /var/tmp partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount | grep -E '\s/var/tmp\s' | grep -v nosuid:"
    echo "---------------------------------------------------"
    mount | grep -E '\s/var/tmp\s' | grep -v nosuid 
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/var/tmp\s' | grep -v nosuid | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.18() {
    result=Fail
    echo "1.1.18 Ensure nodev option set on /home partition"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   mount | grep -E '\s/home\s' | grep -v nodev :"
    echo "---------------------------------------------------"
    mount | grep -E '\s/home\s' | grep -v nodev 
    echo "---------------------------------------------------"
    ## Check State ##
    [ $( mount | grep -E '\s/home\s' | grep -v nodev | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.19() {
    result=Fail
    echo "1.1.19 Ensure noexec option set on removable media partitions"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount :"
    echo "---------------------------------------------------"
    mount 
    echo "---------------------------------------------------"
    ## Check State ##
    devices=$(lsblk -pnlS | awk '/usb/ {print $1}')
    filesystems=$(for device in "$devices"; do lsblk -nlp $device | egrep -v '^$device|[SWAP]' | awk '{print $1}'; done)
    
    for filesystem in $filesystems; do
        fs_without_opt=$(mount | grep "$filesystem " | grep -v noexec &>/dev/null | wc -l)
        [ $fs_without_opt -ne 0 ]  && state=1
    done
        
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.20() {
    result=Fail
    echo "1.1.20 Ensure nodev option set on removable media partitions"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount :"
    echo "---------------------------------------------------"
    mount 
    echo "---------------------------------------------------"
    ## Check State ##
    devices=$(lsblk -pnlS | awk '/usb/ {print $1}')
    filesystems=$(for device in "$devices"; do lsblk -nlp $device | egrep -v '^$device|[SWAP]' | awk '{print $1}'; done)
    
    for filesystem in $filesystems; do
        fs_without_opt=$(mount | grep "$filesystem " | grep -v nodev &>/dev/null | wc -l)
        [ $fs_without_opt -ne 0 ]  && state=1
    done
        
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.21() {
    result=Fail
    echo "1.1.21 Ensure nosuid option set on removable media partitions "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  mount :"
    echo "---------------------------------------------------"
    mount 
    echo "---------------------------------------------------"
    ## Check State ##
    devices=$(lsblk -pnlS | awk '/usb/ {print $1}')
    filesystems=$(for device in "$devices"; do lsblk -nlp $device | egrep -v '^$device|[SWAP]' | awk '{print $1}'; done)
    
    for filesystem in $filesystems; do
        fs_without_opt=$(mount | grep "$filesystem " | grep -v nosuid &>/dev/null | wc -l)
        [ $fs_without_opt -ne 0 ]  && state=1
    done
        
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.22() {
    result=Fail
    echo "1.1.22 Ensure sticky bit is set on all world-writable directories"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null:"
    echo "---------------------------------------------------"
    df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null 
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.23() {
    result=Fail
    echo "1.1.23 Disable Automounting"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  systemctl is-enabled autofs:"
    echo "---------------------------------------------------"
    systemctl is-enabled autofs 
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(mount | grep -E '\s/tmp\s' | grep -v nosuid | wc -l) -ne 0 ] && state=$(( $state + 1 ))
    [ $(diff -qsZ <(systemctl is-enabled autofs | tail -n1) <(echo "disabled") &>/dev/null; echo $?) -eq 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.1.24() {
    result=Fail
    echo "1.1.24 Disable USB Storage"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  modprobe -n -v usb-storage :"
    echo "---------------------------------------------------"
    modprobe -n -v usb-storage 
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(diff -qsZ <(modprobe -n -v usb-storage  2>/dev/null | tail -n1) <(echo "install /bin/true") &>/dev/null; echo $?) -ne 0 ] && state=$(( $state + 1 ))
    [ $(lsmod | grep cramfs | wc -l) -ne 0 ] && state=$(( $state + 2 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
## Section 1.2 - Configure Software Updates
test_1.2.1() {
    result=Fail
    echo "1.2.1 Ensure GPG keys are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n' :"
    echo "---------------------------------------------------"
    rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q gpg-pubkey | wc -l) -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.2.2() {
    result=Fail
    echo "1.2.2 Ensure package manager repositories are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  yum repolist :"
    echo "---------------------------------------------------"
    yum repolist
    echo "---------------------------------------------------"
    ## Check State ##
    repolist=$(timeout 30 yum repolist 2>/dev/null)
    [ $(echo "$repolist" | egrep -c '^base/7/') -ne 0 -a $(echo "$repolist" | egrep -c '^updates/7/') -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.2.3() {
    result=Fail
    echo "1.2.3 Ensure gpgcheck is globally activated"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: grep ^\s*gpgcheck /etc/yum.conf:"
    echo "---------------------------------------------------"
    grep ^\s*gpgcheck /etc/yum.conf
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -R ^gpgcheck=0 /etc/yum.conf /etc/yum.repos.d/ | wc -l) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
## Section 1.3 - Configure sudo
test_1.3.1() {
    result=Fail
    echo "1.3.1 Ensure sudo is installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q sudo:"
    echo "---------------------------------------------------"
    rpm -q sudo
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q sudo | grep ^sudo-\s* | wc -l) -eq 1 ] && result="Pass"
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
   }
test_1.3.2() {
    result=Fail
    echo "1.3.2 Ensure sudo commands use pty"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -Ei '^\s*Defaults\s+([^#]\S+,\s*)?use_pty\b' /etc/sudoers /etc/sudoers.d/*:"
    echo "---------------------------------------------------"
    grep -Ei '^\s*Defaults\s+([^#]\S+,\s*)?use_pty\b' /etc/sudoers /etc/sudoers.d/*
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(diff -qsZ <(grep -Ei '^\s*Defaults\s+([^#]\S+,\s*)?use_pty\b' /etc/sudoers | tail -n1) <(echo "Defaults use_pty") &>/dev/null; echo $?) -ne 0 ] && state=$(( $state + 1 ))
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.3.3() {
    result=Fail
    echo "1.3.3 Ensure sudo log file exists"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  Comand error print!"
    echo "---------------------------------------------------"
    grep -Ei '^\s*Defaults\s+([^#;]+,\s*)?logfile\s*=\s*(")?[^#;]+(")?' /etc/sudoers /etc/sudoers.d/*
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -Ei '^\s*Defaults\s+([^#;]+,\s*)?logfile\s*=\s*(")?[^#;]+(")?' /etc/sudoers | wc -l) -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
## Section 1.4 - Filesystem Integrity Checking
test_1.4.1() {
    result=Fail
    echo "1.4.1 Ensure AIDE is installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q aide:"
    echo "---------------------------------------------------"
    rpm -q aide
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q aide &>/dev/null; echo $?) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.4.2() {
    result=Fail
    echo "1.4.2 Ensure filesystem integrity is regularly checked"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  crontab -u root -l | grep aide2:"
    crontab -u root -l | grep aide2
    echo "---------------------------------------------------"
    echo "      COMAND:  grep -r aide /etc/cron.* /etc/crontab :"
    grep -r aide /etc/cron.* /etc/crontab
    echo "---------------------------------------------------"
    echo "      COMAND:  systemctl is-enabled aidecheck.service:"
    systemctl is-enabled aidecheck.service
    echo "---------------------------------------------------"
    echo "      COMAND:  systemctl is-enabled aidecheck.timer:"
    systemctl is-enabled aidecheck.timer
    echo "---------------------------------------------------"
    echo "      COMAND:  systemctl status aidecheck.timer :"
    systemctl status aidecheck.timer
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -Rl 'aide' /var/spool/cron/root /etc/cron* 2>/dev/null | wc -l) -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
## Section 1.5 - Secure Boot Settings
test_1.5.1() {
    result=Fail
    echo "1.5.1 Ensure bootloader password is set"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ""^\s*GRUB2_PASSWORD"" /boot/grub2/user.cfg:"
    grep "^\s*GRUB2_PASSWORD" /boot/grub2/user.cfg
    echo "---------------------------------------------------"
    echo "      COMAND:  grep ""^\s*set superusers"" /boot/grub2/grub.cfg:"
    grep "^\s*set superusers" /boot/grub2/grub.cfg
     echo "---------------------------------------------------"
    echo "      COMAND:  grep ""^\s*password"" /boot/grub2/grub.cfg :"
    grep "^\s*password" /boot/grub2/grub.cfg
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep "^GRUB2_PASSWORD=" /boot/grub2/grub.cfg /boot/grub2/user.cfg | wc -l) -ne 0 ] && state=0
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.5.2() {
    result=Fail
    echo "1.5.2 Ensure permissions on bootloader config are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   stat /boot/grub2/grub.cfg :"
    stat /boot/grub2/grub.cfg
    echo "---------------------------------------------------"
    echo "      COMAND:   stat /boot/grub2/user.cfg :"
    stat /boot/grub2/user.cfg
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(stat /boot/grub2/grub.cfg | grep 0/ | wc -l) -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.5.3() {
    result=Fail
    echo "1.5.3 Ensure authentication required for single user mode"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   grep /sbin/sulogin /usr/lib/systemd/system/rescue.service :"
    grep /sbin/sulogin /usr/lib/systemd/system/rescue.service
    echo "---------------------------------------------------"
    echo "      COMAND:   grep /sbin/sulogin /usr/lib/systemd/system/emergency.service :"
    grep /sbin/sulogin /usr/lib/systemd/system/emergency.service
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    str='ExecStart=-/bin/sh -c "/usr/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"'
    
    [ "$(grep /sbin/sulogin /usr/lib/systemd/system/rescue.service)" == "$str" ] || state=1
    [ "$(grep /sbin/sulogin /usr/lib/systemd/system/emergency.service)" == "$str" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
## Section 1.6 - Additional Process Hardening
test_1.6.1() {
    result=Fail
    echo "1.6.1 Ensure core dumps are restricted"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   grep -E ""^\s*\*\s+hard\s+core"" /etc/security/limits.conf /etc/security/limits.d/*:"
    grep -E "^\s*\*\s+hard\s+core" /etc/security/limits.conf /etc/security/limits.d/*
    echo "---------------------------------------------------"
    echo "      COMAND:   sysctl fs.suid_dumpable :"
    sysctl fs.suid_dumpable
    echo "---------------------------------------------------"
    echo "      COMAND:   grep ""fs\.suid_dumpable"" /etc/sysctl.conf /etc/sysctl.d/* :"
    grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    str='ExecStart=-/bin/sh -c "/usr/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"'
    
    [ "$(grep "hard core" /etc/security/limits.conf /etc/security/limits.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "*hardcore0" ] || state=1
    [ "$(sysctl fs.suid_dumpable)" == "fs.suid_dumpable = 0" ] || state=1
    [ "$(grep "fs.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "fs.suid_dumpable=0" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.6.2() {
    result=Fail
    echo "1.6.2 Ensure XD/NX support is enabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  journalctl | grep 'protection: active':"
    echo "---------------------------------------------------"
    journalctl | grep 'protection: active'
    echo "---------------------------------------------------"
    state=0
    str='ExecStart=-/bin/sh -c "/usr/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"'
    
    [ "$(dmesg | grep -o "NX (Execute Disable).*")" == "NX (Execute Disable) protection: active" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.6.3() {
    result=Fail
    echo "1.6.3 Ensure address space layout randomization (ASLR) is enabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: sysctl kernel.randomize_va_space:"
    sysctl kernel.randomize_va_space
    echo "---------------------------------------------------"
    echo "      COMAND: grep ""kernel\.randomize_va_space"" /etc/sysctl.conf /etc/sysctl.d/*:"
    grep "kernel\.randomize_va_space" /etc/sysctl.conf /etc/sysctl.d/*
    echo "---------------------------------------------------"
    ## Check State ##
    [ "$(sysctl kernel.randomize_va_space)" == "kernel.randomize_va_space = 2" ] || state=1
    [ "$(grep "kernel.randomize_va_space" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "kernel.randomize_va_space=2" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.6.4() {
    result=Fail
    echo "1.6.4 Ensure prelink is disabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q prelink:"
    echo "---------------------------------------------------"
    rpm -q prelink
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    str='ExecStart=-/bin/sh -c "/usr/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"'
    
    [ "$(rpm -q prelink)" == "package prelink is not installed" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
## Section 1.7 - Mandatory Access Control
test_1.7.1.1() {
    result=Fail
    echo "1.7.1.1 Ensure SELinux is installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q libselinux :"
    echo "---------------------------------------------------"
    rpm -q libselinux
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q libselinux &>/dev/null; echo $?) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.7.1.2() {
    result=Fail
    echo "1.7.1.2 Ensure SELinux is not disabled in bootloader configuration"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: grep ""^\s*linux"" /boot/grub2/grub.cfg | grep -E ""(selinux=0|enforcing=0)"":"
    echo "---------------------------------------------------"
    grep "^\s*linux" /boot/grub2/grub.cfg | grep -E "(selinux=0|enforcing=0)"
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(grep "^\s+linux" /boot/grub2/grub.cfg | egrep 'selinux=0|enforcing=0' | wc -l) -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.7.1.3() {
    result=Fail
    echo "1.7.1.3 Ensure SELinux policy is configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   grep SELINUXTYPE= /etc/selinux/config :"
    grep SELINUXTYPE= /etc/selinux/config
    echo "---------------------------------------------------"
    echo "      COMAND:   grep SELINUXTYPE= /etc/selinux/config :"
    grep SELINUXTYPE= /etc/selinux/config
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(egrep -c ^SELINUXTYPE=targeted /etc/selinux/config)" -eq 1 ] || state=1
    [ "$(sestatus | awk '/Loaded policy name/ {print $4}')" == "targeted" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.7.1.4() {
    result=Fail
    echo "1.7.1.4 Ensure the SELinux mode is enforcing or permissive"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   grep SELINUX=enforcing /etc/selinux/config :"
    echo "---------------------------------------------------"
    grep SELINUX=enforcing /etc/selinux/config
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(grep SELINUX=enforcing /etc/selinux/config)" == "SELINUX=enforcing" ] || state=1
    [ "$(sestatus | awk '/Current mode/ {print $3}')" == "enforcing" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.7.1.6() {
    result=Fail
    echo "1.7.1.6 Ensure no unconfined services exist"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   ps -eZ | grep unconfined_service_t :"
    echo "---------------------------------------------------"
    ps -eZ | grep unconfined_service_t
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(ps -eZ | grep unconfined_service_t | wc -l)" -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.7.1.7() {
    result=Fail
    echo "1.7.1.7 Ensure SETroubleshoot is not installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q setroubleshoot:"
    echo "---------------------------------------------------"
    rpm -q setroubleshoot
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(rpm -q setroubleshoot)" == "package setroubleshoot is not installed" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.7.1.8() {
    result=Fail
    echo "1.7.1.8 Ensure the MCS Translation Service (mcstrans) is not installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q mcstrans:"
    echo "---------------------------------------------------"
    rpm -q mcstrans
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(rpm -q mcstrans)" == "package mcstrans is not installed" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
## Section 1.8 - Warning Banners
test_1.8.1.1() {
    result=Fail
    echo "1.8.1.1 Ensure message of the day is configured properly"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   cat /etc/motd :"
    cat /etc/motd
    echo "---------------------------------------------------"
    echo "      COMAND:  grep -E -i ""(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))"" /etc/motd :"
    grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(wc -l /etc/motd | awk '{print $1}') -gt 0 ] || state=1
    [ $(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd | wc -l) -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.8.1.2() {
    result=Fail
    echo "1.8.1.2 Ensure local login warning banner is configured properly"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   cat /etc/issue :"
    cat /etc/issue
    echo "---------------------------------------------------"
    echo "      COMAND:   grep -E -i ""(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))"" /etc/issue :"
    grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(wc -l /etc/issue | awk '{print $1}') -gt 0 ] || state=1
    [ $(egrep '(\\v|\\r|\\m|\\s)' /etc/issue | wc -l) -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.8.1.3() {
    result=Fail
    echo "1.8.1.3 Ensure remote login warning banner is configured properly"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  cat /etc/issue.net:"
    cat /etc/issue.net
     echo "---------------------------------------------------"
    echo "      COMAND:  egrep '(\\v|\\r|\\m|\\s)' /etc/issue.net:"
    egrep '(\\v|\\r|\\m|\\s)' /etc/issue.net
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(wc -l /etc/issue.net | awk '{print $1}') -gt 0 ] || state=1
    [ $(egrep '(\\v|\\r|\\m|\\s)' /etc/issue.net | wc -l) -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.8.1.4() {
    result=Fail
    echo "1.8.1.4 Ensure permissions on /etc/motd are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/motd :"
    echo "---------------------------------------------------"
    stat /etc/motd
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(stat /etc/motd | grep 0/ | wc -l) -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.8.1.5() {
    result=Fail
    echo "1.8.1.5 Ensure permissions on /etc/issue are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/issue :"
    echo "---------------------------------------------------"
    stat /etc/issue
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(stat /etc/issue | grep 0/ | wc -l) -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.8.1.6() {
    result=Fail
    echo "1.8.1.6 Ensure permissions on /etc/issue.net are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/issue.net :"
    echo "---------------------------------------------------"
    stat /etc/issue.net
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(stat /etc/issue.net | grep 0/ | wc -l) -ne 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.9() {
    result=Fail
    echo "1.9 Ensure updates, patches, and additional security software are installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: yum check-update :"
    echo "---------------------------------------------------"
    yum check-update
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(yum check-update --security &>/dev/null; echo $?) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_1.10() {
    result=Fail
    echo "1.10 Ensure GDM is removed or login is configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q gdm:"
    echo "---------------------------------------------------"
    rpm -q gdm
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    gdm_file="/etc/dconf/profile/gdm"
    banner_file="/etc/dconf/db/gdm.d/01-banner-message"
    
    if [ "$(rpm -q gdm)" != "package gdm is not installed" ]; then
        if [ -f $file ]; then
            diff -qs $gdm_file <( echo -e "user-db:user\nsystem-db:gdm\nfile-db:/usr/share/gdm/greeter-dconf-defaults\n") || state=1
        else
            state=2
        fi
        
        egrep '^banner-message-enable=true' $banner_file || state=4
        egrep '^banner-message-text=.*' $banner_file || state=8
    fi
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}


## SECTION 2 - 
test_2.1.1() {
    result=Fail
    echo "2.1.1 Ensure xinetd is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q xinetd :"
    echo "---------------------------------------------------"
    rpm -q xinetd
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ "$(rpm -q xinetd)" != "package xinetd is not installed" ]; then
        [ $(systemctl is-enabled xinetd) == "disabled" ] || state=1
    fi
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.1.1() {
    result=Fail
    echo "2.2.1.1 Ensure time synchronization is in use "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q chrony :"
    rpm -q chrony
    echo "---------------------------------------------------"
    echo "      COMMAND # rpm -q ntp :"
    rpm -q ntp
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q ntp &>/dev/null; echo $?) -eq 0 -o $(rpm -q chrony &>/dev/null; echo $?) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.1.2() {
    result=Fail
    echo "2.2.1.2 Ensure chrony is configured "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # grep -E ""^(server|pool)"" /etc/chrony.conf :"
    grep -E "^(server|pool)" /etc/chrony.conf
    echo "---------------------------------------------------"
    echo "      COMMAND # grep ^OPTIONS /etc/sysconfig/chronyd :"
    grep ^OPTIONS /etc/sysconfig/chronyd
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $( rpm -q chrony &>/dev/null; echo $? ) -eq 0 ]; then
        egrep "^(server|pool) .*$" /etc/chrony.conf &>/dev/null || state=$(( $state + 1 ))
        
        if [ -f /etc/sysconfig/chronyd ]; then
            [ $( grep -c 'OPTIONS="-u chrony' /etc/sysconfig/chronyd ) -eq 0 ] && state=$(( $state + 2 ))
        else
            state=$(( $state + 4 ))
        fi
        [ $state -eq 0 ] && result="Pass"
    else
        result=""
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.1.3() {
    result=Fail
    echo "2.2.1.3 Ensure ntp is configured "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # grep ""^restrict"" /etc/ntp.conf :"
    echo "---------------------------------------------------"
    grep "^restrict" /etc/ntp.conf
    echo "---------------------------------------------------"
    grep -E "^(server|pool)" /etc/ntp.conf
    echo "---------------------------------------------------"
    grep "^OPTIONS" /etc/sysconfig/ntpd
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $( rpm -q ntp &>/dev/null; echo $?) -eq 0 ]; then
        grep "^restrict -4 default kod nomodify notrap nopeer noquery" /etc/ntp.conf &>/dev/null || state=1
        grep "^restrict -6 default kod nomodify notrap nopeer noquery" /etc/ntp.conf &>/dev/null || state=2
        [ $(egrep -c "^(server|pool) .*$" /etc/ntp.conf 2>/dev/null) -ge 2 ] || state=4
        [ -f /etc/systemd/system/ntpd.service ] && file="/etc/systemd/system/ntpd.service" || file="/usr/lib/systemd/system/ntpd.service"
        [ $(grep -c 'OPTIONS="-u ntp:ntp' /etc/sysconfig/ntpd) -ne 0 -o $(grep -c 'ExecStart=/usr/sbin/ntpd -u ntp:ntp $OPTIONS' $file) -ne 0 ] || state=8
        
        [ $state -eq 0 ] && result="Pass"
    else
        result="Fail"
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.2() {
    result=Fail
    echo "2.2.2 Ensure X11 Server components are not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -qa xorg-x11-server* :"
    echo "---------------------------------------------------"
    rpm -qa xorg-x11-server*
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -qa xorg-x11-server* | wc -l) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.3() {
    result=Fail
    echo "2.2.3 Ensure Avahi Server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q avahi-autoipd avahi:"
    echo "---------------------------------------------------"
    rpm -q avahi-autoipd avahi
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q avahi-autoipd &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $(rpm -q avahi &>/dev/null; echo $?) -eq 0 ] && state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.4() {
    result=Fail
    echo "2.2.4 Ensure CUPS is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q cups :"
    echo "---------------------------------------------------"
    rpm -q cups
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q cups &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.5() {
    result=Fail
    echo "2.2.5 Ensure DHCP Server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q dhcp :"
    echo "---------------------------------------------------"
    rpm -q dhcp
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q dhcp &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.6() {
    result=Fail
    echo "2.2.6 Ensure LDAP server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q openldap-servers :"
    echo "---------------------------------------------------"
    rpm -q openldap-servers
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q openldap-servers &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.7() {
    result=Fail
    echo "2.2.7 Ensure nfs-utils is not installed or the nfs-server service is masked "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q nfs-utils :"
    echo "---------------------------------------------------"
    rpm -q nfs-utils
    echo "      COMMAND # systemctl is-enabled nfs-server :"
    echo "---------------------------------------------------"
    systemctl is-enabled nfs-server
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(rpm -q nfs-utils &>/dev/null; echo $?) -eq 0 ]; then
        [ $(systemctl is-enabled nfs.service) == "masked" ] || state=1
        [ $(systemctl is-enabled nfs-server.service) == "disabled" ] || state=1
        [ $(netstat -tupln | egrep ":2049 " | wc -l) -eq 0 ] || state=2
    fi
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.8() {
    result=Fail
    echo "2.2.8 Ensure rpcbind is not installed or the rpcbind services are masked "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q rpcbind :"
    rpm -q rpcbind
    echo "---------------------------------------------------"
    echo "      COMMAND # systemctl is-enabled rpcbind :"
    systemctl is-enabled rpcbind
    echo "---------------------------------------------------"
    echo "      COMMAND # systemctl is-enabled rpcbind.socket :"
    systemctl is-enabled rpcbind.socket
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(rpm -q rpcbind &>/dev/null; echo $?) -eq 0 ]; then
        [ $(systemctl is-enabled rpcbind) == "masked" ] || state=1
        [ $( systemctl is-enabled rpcbind.socket) == "masked" ] || state=2
    fi
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.9() {
    result=Fail
    echo "2.2.9 Ensure DNS Server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q bind :"
    echo "---------------------------------------------------"
    rpm -q bind
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q bind &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.10() {
    result=Fail
    echo "2.2.10 Ensure FTP Server is not installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  rpm -q vsftpd :"
    echo "---------------------------------------------------"
    rpm -q vsftpd
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q vsftpd &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.11() {
    result=Fail
    echo "2.2.11 Ensure HTTP server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q httpd :"
    echo "---------------------------------------------------"
    rpm -q httpd
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q httpd &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.12() {
    result=Fail
    echo "2.2.12 Ensure IMAP and POP3 server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q dovecot :"
    echo "---------------------------------------------------"
    rpm -q dovecot
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q dovecot &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.13() {
    result=Fail
    echo "2.2.13 Ensure Samba is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q samba :"
    echo "---------------------------------------------------"
    rpm -q samba
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q samba &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.14() {
    result=Fail
    echo "2.2.14 Ensure HTTP Proxy Server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q squid :"
    echo "---------------------------------------------------"
    rpm -q squid
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q squid &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.15() {
    result=Fail
    echo "2.2.15 Ensure net-snmp is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q net-snmp :"
    echo "---------------------------------------------------"
    rpm -q net-snmp
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q net-snmp &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.16() {
    result=Fail
    echo "2.2.16 Ensure mail transfer agent is configured for local-only mode "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|\[?::1\]?):25\s' :"
    echo "---------------------------------------------------"
    ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|\[?::1\]?):25\s'
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|\[?::1\]?):25\s' | wc -l) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.17() {
    result=Fail
    echo "2.2.17 Ensure rsync is not installed or the rsyncd service is masked "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q rsync :"
    echo "---------------------------------------------------"
    rpm -q rsync
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(rpm -q rsync &>/dev/null; echo $?) -eq 0 ]; then
        [ $(systemctl is-enabled rsyncd) == "masked" ] || state=1
    fi
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.18() {
    result=Fail
    echo "2.2.18 Ensure NIS server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q ypserv :"
    echo "---------------------------------------------------"
    rpm -q ypserv
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q ypserv &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.2.19() {
    result=Fail
    echo "2.2.19 Ensure telnet-server is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q telnet-server :"
    echo "---------------------------------------------------"
    rpm -q telnet-server
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q telnet-server &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.3.1() {
    result=Fail
    echo "2.3.1 Ensure NIS Client is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  rpm -q ypbind :"
    echo "---------------------------------------------------"
    rpm -q ypbind
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $( rpm -q ypbind &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.3.2() {
    result=Fail
    echo "2.3.2 Ensure rsh client is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q rsh :"
    echo "---------------------------------------------------"
    rpm -q rsh
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q rsh &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.3.3() {
    result=Fail
    echo "2.3.3 Ensure talk client is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  rpm -q talk :"
    echo "---------------------------------------------------"
    rpm -q talk
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q talk &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.3.4() {
    result=Fail
    echo "2.3.4 Ensure telnet client is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q telnet :"
    echo "---------------------------------------------------"
    rpm -q telnet
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q telnet &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_2.3.5() {
    result=Fail
    echo "2.3.5 Ensure LDAP client is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  rpm -q openldap-clients :"
    echo "---------------------------------------------------"
    rpm -q openldap-clients
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q openldap-clients &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

## Section 3 - 
test_3.1.2() {
    result=Fail
    echo "3.1.2 Ensure wireless interfaces are disabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  ip link show up :"
    echo "---------------------------------------------------"
    iw list
    echo ""
    ip link show up
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(ip link show up &>/dev/null; echo $?) -eq 0 ] || result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.2.1() {
    result=Fail
    echo "3.2.1 Ensure IP forwarding is disabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.ip_forward :"
    echo "---------------------------------------------------"
    sysctl net.ipv4.ip_forward
    grep -E -s "^\s*net\.ipv4\.ip_forward\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf
    echo "---------------------------------------------------"
    echo "      COMMAND #  sysctl net.ipv4.ip_forward :"
    echo "---------------------------------------------------"
    sysctl net.ipv6.conf.all.forwarding
    grep -E -s "^\s*net\.ipv6\.conf\.all\.forwarding\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.ip_forward)" == "net.ipv4.ip_forward = 0" ] || state=1
    [ $(grep -E -s "^\s*net\.ipv4\.ip_forward\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf &>/dev/null; echo $?) -ne 0 ] || state=2
    
    [ "$(sysctl net.ipv6.conf.all.forwarding)" == "net.ipv6.conf.all.forwarding = 0" ] || state=4
    [ $(grep -E -s "^\s*net\.ipv6\.conf\.all\.forwarding\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf &>/dev/null; echo $?) -ne 0 ] || state=8
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.2.2() {
    result=Fail
    echo "3.2.2 Ensure packet redirect sending is disabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.conf.all.send_redirects :"
    sysctl net.ipv4.conf.all.send_redirects
    echo ""
    grep "net\.ipv4\.conf\.all\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*
    echo "---------------------------------------------------"
    echo "      COMMAND #  sysctl net.ipv4.conf.all.send_redirects :"
    sysctl net.ipv4.conf.default.send_redirects
    echo ""
    grep "net\.ipv4\.conf\.default\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.conf.all.send_redirects)" == "net.ipv4.conf.all.send_redirects = 0" ] || state=1
    [ "$(sysctl net.ipv4.conf.default.send_redirects)" == "net.ipv4.conf.default.send_redirects = 0" ] || state=2
    [ "$(grep "net\.ipv4\.conf\.all\.send_redirects" /etc/sysctl.conf)" == "net.ipv4.conf.all.send_redirects = 0" ] || state=4
    [ "$(grep "net\.ipv4\.conf\.all\.send_redirects" /etc/sysctl.conf)" == "net.ipv4.conf.all.send_redirects = 0" ] || state=4
    [ "$(grep "net\.ipv4\.conf\.default\.send_redirects" /etc/sysctl.d/*)" == "net.ipv4.conf.default.send_redirects = 0" ] || state=8
    [ "$(grep "net\.ipv4\.conf\.default\.send_redirects" /etc/sysctl.d/*)" == "net.ipv4.conf.default.send_redirects = 0" ] || state=8
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.1() {
    result=Fail
    echo "3.3.1 Ensure source routed packets are not accepted"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.conf.all.accept_source_route
                grep ""net.ipv4.conf.all.accept_source_route"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                           --------
                sysctl net.ipv4.conf.default.accept_source_route
                grep ""net.ipv4.conf.default.accept_source_route"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
    echo "---------------------------------------------------"
    sysctl net.ipv4.conf.all.accept_source_route
    grep "net.ipv4.conf.all.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv4.conf.default.accept_source_route
    grep "net.ipv4.conf.default.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    echo "      COMMAND #  sysctl net.ipv6.conf.all.accept_source_route
                grep ""net.ipv6.conf.all.accept_source_route"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                            ---------
                sysctl net.ipv6.conf.default.accept_source_route
                grep ""net.ipv6.conf.default.accept_source_route"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
                            
    echo "---------------------------------------------------"
    sysctl net.ipv6.conf.all.accept_source_route
    grep "net.ipv6.conf.all.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv6.conf.default.accept_source_route
    grep "net.ipv6.conf.default.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.conf.all.accept_source_route)" == "net.ipv4.conf.all.accept_source_route = 0" ] || state=1
    [ "$(grep "net.ipv4.conf.all.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.all.accept_source_route=0" ] || state=2
    
    [ "$(sysctl net.ipv4.conf.default.accept_source_route)" == "net.ipv4.conf.default.accept_source_route = 0" ] || state=4
    [ "$(grep "net.ipv4.conf.default.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.default.accept_source_route=0" ] || state=8
    
    [ "$(sysctl net.ipv6.conf.all.accept_source_route)" == "net.ipv6.conf.all.accept_source_route = 0" ] || state=1
    [ "$(grep "net.ipv6.conf.all.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv6.conf.all.accept_source_route=0" ] || state=2
    
    [ "$(sysctl net.ipv6.conf.default.accept_source_route)" == "net.ipv6.conf.default.accept_source_route = 0" ] || state=4
    [ "$(grep "net.ipv6.conf.default.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv6.conf.default.accept_source_route=0" ] || state=8
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.2() {
    result=Fail
    echo "3.3.2 Ensure ICMP redirects are not accepted"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.conf.all.send_redirects
                grep ""net\.ipv4\.conf\.all\.send_redirects"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                           --------
                sysctl net.ipv4.conf.default.send_redirects
                grep ""net\.ipv4\.conf\.default\.send_redirects"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
    echo "---------------------------------------------------"
    sysctl net.ipv4.conf.all.send_redirects
    grep "net\.ipv4\.conf\.all\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv4.conf.default.send_redirects
    grep "net\.ipv4\.conf\.default\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    echo "      COMMAND #   sysctl net.ipv6.conf.all.accept_redirects
                grep ""net\.ipv6\.conf\.all\.accept_redirects"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                            ---------
                sysctl net.ipv6.conf.default.accept_redirects
                grep ""net\.ipv6\.conf\.default\.accept_redirects"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
                            
    echo "---------------------------------------------------"
    sysctl net.ipv6.conf.all.accept_redirects
    grep "net\.ipv6\.conf\.all\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv6.conf.default.accept_redirects
    grep "net\.ipv6\.conf\.default\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.conf.all.accept_redirects)" == "net.ipv4.conf.all.accept_redirects = 0" ] || state=1
    [ "$(grep "net\.ipv4\.conf\.all\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.all.accept_redirects=0" ] || state=2
    
    [ "$(sysctl net.ipv4.conf.default.accept_redirects)" == "net.ipv4.conf.default.accept_redirects = 0" ] || state=4
    [ "$(grep "net\.ipv4\.conf\.default\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.default.accept_redirects=0" ] || state=8
    
    [ "$(sysctl net.ipv6.conf.all.accept_redirects)" == "net.ipv6.conf.all.accept_redirects = 0" ] || state=1
    [ "$(grep "net\.ipv6\.conf\.all\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv6.conf.all.accept_redirects=0" ] || state=2
    
    [ "$(sysctl net.ipv6.conf.default.accept_redirects)" == "net.ipv6.conf.default.accept_redirects = 0" ] || state=4
    [ "$(grep "net\.ipv6\.conf\.default\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv6.conf.default.accept_redirects=0" ] || state=8
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.3() {
    result=Fail
    echo "3.3.3 Ensure secure ICMP redirects are not accepted"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.conf.all.secure_redirects
                grep ""net\.ipv4\.conf\.all\.secure_redirects"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                           --------
                sysctl net.ipv4.conf.default.secure_redirects
                grep ""net\.ipv4\.conf\.default\.secure_redirects"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
    echo "---------------------------------------------------"
    sysctl net.ipv4.conf.all.secure_redirects
    grep "net\.ipv4\.conf\.all\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv4.conf.default.secure_redirects
    grep "net\.ipv4\.conf\.default\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.conf.all.secure_redirects)" == "net.ipv4.conf.all.secure_redirects = 0" ] || state=1
    [ "$(grep "net\.ipv4\.conf\.all\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.all.secure_redirects=0" ] || state=2
    
    [ "$(sysctl net.ipv4.conf.default.secure_redirects)" == "net.ipv4.conf.default.secure_redirects = 0" ] || state=4
    [ "$(grep "net\.ipv4\.conf\.default\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.default.secure_redirects=0" ] || state=8
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.4() {
    result=Fail
    echo "3.3.4 Ensure suspicious packets are logged"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.conf.all.log_martians
                grep ""net\.ipv4\.conf\.all\.log_martians"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                           --------
                sysctl net.ipv4.conf.default.log_martians
                grep ""net\.ipv4\.conf\.default\.log_martians"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
    echo "---------------------------------------------------"
    sysctl net.ipv4.conf.all.log_martians
    grep "net\.ipv4\.conf\.all\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv4.conf.default.log_martians
    grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.conf.all.log_martians)" == "net.ipv4.conf.all.log_martians = 1" ] || state=1
    [ "$(grep "net\.ipv4\.conf\.all\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.all.log_martians=1" ] || state=2
    
    [ "$(sysctl net.ipv4.conf.default.log_martians)" == "net.ipv4.conf.default.log_martians = 1" ] || state=4
    [ "$(grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.default.log_martians=1" ] || state=8
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.5() {
    result=Fail
    echo "3.3.5 Ensure broadcast ICMP requests are ignored"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.icmp_echo_ignore_broadcasts
                grep ""net\.ipv4\.icmp_echo_ignore_broadcasts"" /etc/sysctl.conf /etc/sysctl.d/*.conf :"
    echo "---------------------------------------------------"
    sysctl net.ipv4.icmp_echo_ignore_broadcasts
    grep "net\.ipv4\.icmp_echo_ignore_broadcasts" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.icmp_echo_ignore_broadcasts)" == "net.ipv4.icmp_echo_ignore_broadcasts = 1" ] || state=1
    [ "$(grep "net\.ipv4\.icmp_echo_ignore_broadcasts" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.icmp_echo_ignore_broadcasts=1" ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.6() {
    result=Fail
    echo "3.3.6 Ensure bogus ICMP responses are ignored"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.icmp_ignore_bogus_error_responses
                grep ""net.ipv4.icmp_ignore_bogus_error_responses"" /etc/sysctl.conf /etc/sysctl.d/*.conf :"
    echo "---------------------------------------------------"
    sysctl net.ipv4.icmp_ignore_bogus_error_responses
    grep "net.ipv4.icmp_ignore_bogus_error_responses" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.icmp_ignore_bogus_error_responses)" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ] || state=1
    [ "$(grep "net.ipv4.icmp_ignore_bogus_error_responses" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.icmp_ignore_bogus_error_responses=1" ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.7() {
    result=Fail
    echo "3.3.7 Ensure Reverse Path Filtering is enabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.conf.all.rp_filter
                grep ""net\.ipv4\.conf\.all\.rp_filter"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                           --------
                sysctl net.ipv4.conf.default.rp_filter
                grep ""net\.ipv4\.conf\.default\.rp_filter"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
    echo "---------------------------------------------------"
    sysctl net.ipv4.conf.all.rp_filter
    grep "net\.ipv4\.conf\.all\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv4.conf.default.rp_filter
    grep "net\.ipv4\.conf\.default\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.conf.all.rp_filter)" == "net.ipv4.conf.all.rp_filter = 1" ] || state=1
    [ "$(grep "net\.ipv4\.conf\.all\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.all.rp_filter=1" ] || state=2
    
    [ "$(sysctl net.ipv4.conf.default.rp_filter)" == "net.ipv4.conf.default.rp_filter = 1" ] || state=4
    [ "$(grep "net\.ipv4\.conf\.default\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.conf.default.rp_filter=1" ] || state=8
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.8() {
    result=Fail
    echo "3.3.8 Ensure TCP SYN Cookies is enabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv4.tcp_syncookies
                grep ""net\.ipv4\.tcp_syncookies"" /etc/sysctl.conf /etc/sysctl.d/*.conf :"
    echo "---------------------------------------------------"
    sysctl net.ipv4.tcp_syncookies
    grep "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv4.tcp_syncookies)" == "net.ipv4.tcp_syncookies = 1" ] || state=1
    [ "$(grep "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv4.tcp_syncookies=1" ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.3.9() {
    result=Fail
    echo "3.3.9 Ensure IPv6 router advertisements are not accepted"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND #  sysctl net.ipv6.conf.all.accept_ra
                grep ""net\.ipv6\.conf\.all\.accept_ra"" /etc/sysctl.conf /etc/sysctl.d/*.conf
                           --------
                sysctl net.ipv6.conf.default.accept_ra
                grep ""net\.ipv6\.conf\.default\.accept_ra"" /etc/sysctl.conf /etc/sysctl.d/*.conf:"
    echo "---------------------------------------------------"
    sysctl net.ipv6.conf.all.accept_ra
    grep "net\.ipv6\.conf\.all\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo ""
    sysctl net.ipv6.conf.default.accept_ra
    grep "net\.ipv6\.conf\.default\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(sysctl net.ipv6.conf.all.accept_ra)" == "net.ipv6.conf.all.accept_ra = 0" ] || state=1
    [ "$(grep "net\.ipv6\.conf\.all\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv6.conf.all.accept_ra=0" ] || state=2
    
    [ "$(sysctl net.ipv6.conf.default.accept_ra)" == "net.ipv6.conf.default.accept_ra = 0" ] || state=4
    [ "$(grep "net\.ipv6\.conf\.default\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*.conf | sed -e 's/^.*://' -e 's/\s//g' | uniq)" == "net.ipv6.conf.default.accept_ra=0" ] || state=8
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

## FirewallD
test_3.5.1.1() {
    result=Fail
    echo "3.5.1.1 Ensure FirewallD is installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q firewalld iptables :"
    echo "---------------------------------------------------"
    rpm -q firewalld iptables
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q firewalld iptables &>/dev/null; echo $?) -eq 0 ] &&  result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.1.2() {
    result=Fail
    echo "3.5.1.2 Ensure iptables-services package is not installed "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q iptables-services :"
    echo "---------------------------------------------------"
    rpm -q iptables-services
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q iptables-services &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.1.3() {
    result=Fail
    echo "3.5.1.3 Ensure nftables is not installed or stopped and masked "
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q nftables :"
    echo "---------------------------------------------------"
    rpm -q nftables
    if [ $(rpm -q nftables &>/dev/null; echo $?) -eq 0 ]; then
        systemctl status nftables | grep "Active: " | grep -v "active (running) " 
        systemctl is-enabled nftables
    fi
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(rpm -q nftables &>/dev/null; echo $?) -eq 0 ]; then
        [ $(systemctl status nftables | grep "Active: " | grep -v "active (running) " | wc -l) -eq 0 ] || state=1
        [ $(systemctl is-enabled nftables) == "masked" ] || state=2
    fi
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.1.4() {
    result=Fail
    echo "3.5.1.4 Ensure firewalld service is enabled and running"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # systemctl is-enabled firewalld :"
    systemctl is-enabled firewalld
    echo "---------------------------------------------------"
    echo "      COMMAND # firewall-cmd --state :"
    firewall-cmd --state
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(systemctl is-enabled firewalld) == "enabled" ] || state=1
    [ $(firewall-cmd --state) == "running" ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.1.5() {
    result=Fail
    echo "3.5.1.5 Ensure default zone is set"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # firewall-cmd --get-default-zone :"
    echo "---------------------------------------------------"
    firewall-cmd --get-default-zone
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(firewall-cmd --get-default-zone) == "public" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.1.6() {
    result=Fail
    echo "3.5.1.6 Ensure network interfaces are assigned to appropriate zone"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # nmcli -t connection show | awk -F: '{if($4){print $4}}' | while read INT; do firewall-cmd --get-active-zones | grep -B1 $INT; done :"
    echo "---------------------------------------------------"
    nmcli -t connection show | awk -F: '{if($4){print $4}}' | while read INT; do firewall-cmd --get-active-zones | grep -B1 $INT; done
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.1.7() {
    result=Fail
    echo "3.5.1.7 Ensure unnecessary services and ports are not accepted"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # firewall-cmd --get-active-zones | awk '!/:/ {print $1}' | while read ZN; do firewall-cmd --list-all --zone=$ZN; done :"
    echo "---------------------------------------------------"
    firewall-cmd --get-active-zones | awk '!/:/ {print $1}' | while read ZN; do firewall-cmd --list-all --zone=$ZN; done
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

## Nftables
test_3.5.2.1() {
    result=Fail
    echo "3.5.2.1 Ensure nftables is installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q nftables :"
    echo "---------------------------------------------------"
    rpm -q nftables
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q nftables &>/dev/null; echo $?) -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.2() {
    result=Fail
    echo "3.5.2.2 Ensure firewalld is not installed or stopped and masked"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q firewalld :"
    echo "---------------------------------------------------"
    rpm -q firewalld
    if [ $(rpm -q firewalld &>/dev/null; echo $?) -eq 0 ]; then
        systemctl status firewalld | grep "Active: " | grep -v "active (running) " 
        systemctl is-enabled firewalld
    fi
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(rpm -q firewalld &>/dev/null; echo $?) -eq 0 ]; then
        [ $(systemctl status firewalld | grep "Active: " | grep -v "active (running) " | wc -l) -eq 0 ] || state=1
        [ $(systemctl is-enabled firewalld) == "masked" ] || state=2
    fi
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.3() {
    result=Fail
    echo "3.5.2.3 Ensure iptables-services package is not installed"
     ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q iptables-services :"
    echo "---------------------------------------------------"
    rpm -q iptables-services
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q iptables-services &>/dev/null; echo $?) -eq 0 ] && state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.4() {
    result=Fail
    echo "3.5.2.4 Ensure iptables are flushed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # iptables -L :"
    echo "---------------------------------------------------"
    iptables -L
    echo "---------------------------------------------------"
    echo "      COMMAND # ip6tables -L :"
    echo "---------------------------------------------------"
    ip6tables -L
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(iptables -L | grep anywhere | wc -l) -eq 0 ] || state=1
    [ $(ip6tables -L | grep anywhere | wc -l) -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.5() {
    result=Fail
    echo "3.5.2.5 Ensure a table exists"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # nft list tables :"
    echo "---------------------------------------------------"
    nft list tables
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(nft list tables &>/dev/null; echo $?) -eq 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.6() {
    result=Fail
    echo "3.5.2.6 Ensure base chains exist"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # nft list ruleset | grep 'hook input' 
                nft list ruleset | grep 'hook forward'
                nft list ruleset | grep 'hook output':"
    echo "---------------------------------------------------"
    nft list ruleset | grep 'hook input'
    echo "---------------------------------------------------"
    nft list ruleset | grep 'hook forward'
    echo "---------------------------------------------------"
    nft list ruleset | grep 'hook output'
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(nft list ruleset | grep 'hook input')" == "type filter hook input priority 0;" ] || state=1
    [ "$(nft list ruleset | grep 'hook forward')" == "type filter hook forward priority 0;" ] || state=2
    [ "$(nft list ruleset | grep 'hook output')" == "type filter hook output priority 0;" ] || state=4
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.7() {
    result=Fail
    echo "3.5.2.7 Ensure loopback traffic is configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # nft list ruleset | awk '/hook input/,/}/' | grep 'iif "lo" accept' 
                nft list ruleset | awk '/hook input/,/}/' | grep 'ip saddr'
                nft list ruleset | awk '/hook input/,/}/' | grep 'ip6 saddr':"
    echo "---------------------------------------------------"
    nft list ruleset | awk '/hook input/,/}/' | grep 'iif "lo" accept'
    echo "---------------------------------------------------"
    nft list ruleset | awk '/hook input/,/}/' | grep 'ip saddr'
    echo "---------------------------------------------------"
    nft list ruleset | awk '/hook input/,/}/' | grep 'ip6 saddr'
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    str=$(iptables -S -w60)
    [ $(nft list ruleset | awk '/hook input/,/}/' | grep 'iif "lo" accept') != 0 ] || state=$(( $state + 1 ))
    [ $(nft list ruleset | awk '/hook input/,/}/' | grep 'ip saddr') != 0 ] || state=$(( $state + 2 ))
    [ $(nft list ruleset | awk '/hook input/,/}/' | grep 'ip6 saddr') != 0 ] || state=$(( $state + 4 ))
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.8() {
    result=Fail
    echo "3.5.2.8 Ensure outbound and established connections are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # nft list ruleset | awk '/hook input/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state' 
                nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state':"
    echo "---------------------------------------------------"
    nft list ruleset | awk '/hook input/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state'
    echo "---------------------------------------------------"
    nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state'
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.9() {
    result=Fail
    echo "3.5.2.9 Ensure default deny firewall policy"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # nft list ruleset | grep 'hook input'
                nft list ruleset | grep 'hook forward'
                nft list ruleset | grep 'hook output' :"
    echo "---------------------------------------------------"
    nft list ruleset | grep 'hook input'
    echo "---------------------------------------------------"
    nft list ruleset | grep 'hook forward'
    echo "---------------------------------------------------"
    nft list ruleset | grep 'hook output'
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(nft list ruleset | grep 'hook input')" == "type filter hook input priority 0; policy drop;" ] || state=1
    [ "$(nft list ruleset | grep 'hook forward')" == "type filter hook forward priority 0; policy drop;" ] || state=2
    [ "$(nft list ruleset | grep 'hook output')" == "type filter hook output priority 0; policy drop;" ] || state=4
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.10() {
    result=Fail
    echo "3.5.2.10 Ensure nftables service is enabled"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # systemctl is-enabled nftables :"
    echo "---------------------------------------------------"
    systemctl is-enabled nftables
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(systemctl is-enabled nftables)" == "enabled" ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.2.11() {
    result=Fail
    echo "3.5.2.11 Ensure nftables rules are permanent"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # awk '/hook input/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/sysconfig/nftables.conf)
                awk '/hook forward/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/sysconfig/nftables.conf)
                awk '/hook output/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/sysconfig/nftables.conf) :"
    echo "---------------------------------------------------"
    awk '/hook input/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/sysconfig/nftables.conf)
    echo "---------------------------------------------------"
    awk '/hook forward/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/sysconfig/nftables.conf)
    echo "---------------------------------------------------"
    awk '/hook output/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/sysconfig/nftables.conf)
    echo "---------------------------------------------------"
    ## Check State ##
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

##3.5.3.1 Configure software iptables
test_3.5.3.1.1() {
    result=Fail
    echo "3.5.3.1.1 Ensure iptables packages are installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q iptables iptables-services :"
    echo "---------------------------------------------------"
    rpm -q iptables iptables-services
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(rpm -q iptables &>/dev/null; echo $?) -eq 0 ] || state=1
    [ $(rpm -q iptables-services &>/dev/null; echo $?) -eq 0 ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.1.2() {
    result=Fail
    echo "3.5.3.1.2 Ensure nftables is not installed"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q nftables :"
    echo "---------------------------------------------------"
    rpm -q nftables
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q nftables &>/dev/null; echo $?) -eq 0 ] || result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.1.3() {
    result=Fail
    echo "3.5.3.1.3 Ensure firewalld is not installed or stopped and masked"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # rpm -q firewalld :"
    echo "---------------------------------------------------"
    rpm -q firewalld
    if [ $(rpm -q firewalld &>/dev/null; echo $?) -eq 0 ]; then
        systemctl status firewalld | grep "Active: " | grep -v "active (running) " 
        systemctl is-enabled firewalld
    fi
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(rpm -q firewalld &>/dev/null; echo $?) -eq 0 ]; then
        [ $(systemctl status firewalld | grep "Active: " | grep -v "active (running) " | wc -l) -eq 0 ] || state=1
        [ $(systemctl is-enabled firewalld) == "masked" ] || state=2
    fi
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.2.1() {
    result=Fail
    echo "3.5.3.2.1 Ensure default deny firewall policy"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # iptables -L :"
    echo "---------------------------------------------------"
    iptables -L
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    str=$(iptables -L)
    [ $(echo "$str" | grep -c -- "Chain INPUT (policy DROP)") != 0 ] || state=1
    [ $(echo "$str" | grep -c -- "Chain FORWARD (policy DROP)") != 0 ] || state=2
    [ $(echo "$str" | grep -c -- "Chain OUTPUT (policy DROP)") != 0 ] || state=4
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.2.2() {
    result=Fail
    echo "3.5.3.2.2 Ensure loopback traffic is configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # iptables -L INPUT -v -n
                iptables -L OUTPUT -v -n :"
    echo "---------------------------------------------------"
    iptables -L INPUT -v -n
    echo "---------------------------------------------------"
    iptables -L OUTPUT -v -n
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.2.3() {
    result=Fail
    echo "3.5.3.2.3 Ensure outbound and established connections are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # iptables -L -v -n :"
    echo "---------------------------------------------------"
    iptables -L -v -n
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.2.4() {
    result=Fail
    echo "3.5.3.2.4 Ensure firewall rules exist for all open ports"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # ss -4tuln 
                iptables -L INPUT -v -n:"
    echo "---------------------------------------------------"
    ss -4tuln
    echo "---------------------------------------------------"
    iptables -L INPUT -v -n
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.2.5() {
    result=Fail
    echo "3.5.3.2.5 Ensure iptables rules are saved"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # cat /etc/sysconfig/iptables :"
    echo "---------------------------------------------------"
    cat /etc/sysconfig/iptables
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(cat /etc/sysconfig/iptables | grep -c -- "-A") != 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.2.6() {
    result=Fail
    echo "3.5.3.2.6 Ensure iptables is enabled and running"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # systemctl is-enabled iptables 
                systemctl status iptables | grep "" Active: active (running) "":"
    echo "---------------------------------------------------"
    systemctl is-enabled iptables
    echo "---------------------------------------------------"
    systemctl status iptables | grep " Active: active (running) "
    echo "---------------------------------------------------"
    ## Check State ##
    if [ "$(systemctl is-enabled iptables)" == "enabled" ]; then
       [ $(systemctl status iptables | grep " Active: active (running) " | wc -l) -eq 0 ] || result=Pass
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.3.1() {
    result=Fail
    echo "3.5.3.3.1 Ensure IPv6 default deny firewall policy"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # ip6tables -L :"
    echo "---------------------------------------------------"
    ip6tables -L
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    str=$(ip6tables -L)
    [ $(echo "$str" | grep -c -- "Chain INPUT (policy DROP)") != 0 ] || state=1
    [ $(echo "$str" | grep -c -- "Chain FORWARD (policy DROP)") != 0 ] || state=2
    [ $(echo "$str" | grep -c -- "Chain OUTPUT (policy DROP)") != 0 ] || state=4
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.3.2() {
    result=Fail
    echo "3.5.3.3.2 Ensure IPv6 loopback traffic is configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # ip6tables -L INPUT -v -n :"
    echo "---------------------------------------------------"
    ip6tables -L INPUT -v -n
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.3.3() {
    result=Fail
    echo "3.5.3.3.3 Ensure IPv6 outbound and established connections are configured"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # ip6tables -L -v -n :"
    echo "---------------------------------------------------"
    ip6tables -L -v -n
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.3.4() {
    result=Fail
    echo "3.5.3.3.4 Ensure IPv6 firewall rules exist for all open ports"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # ss -6tuln 
                ip6tables -L INPUT -v -n:"
    echo "---------------------------------------------------"
    ss -6tuln
    echo "---------------------------------------------------"
    ip6tables -L INPUT -v -n
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.3.5() {
    result=Fail
    echo "3.5.3.3.5 Ensure ip6tables rules are saved"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # cat /etc/sysconfig/ip6tables :"
    echo "---------------------------------------------------"
    cat //etc/sysconfig/ip6tables
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(cat /etc/sysconfig/ip6tables | grep -c -- "-A") != 0 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_3.5.3.3.6() {
    result=Fail
    echo "3.5.3.3.6 Ensure ip6tables is enabled and running"
    ## Tests Start ##
    echo "      Result:"
    echo "      COMMAND # systemctl is-enabled ip6tables 
                systemctl status ip6tables | grep "" Active: active (running) "":"
    echo "---------------------------------------------------"
    systemctl is-enabled ip6tables
    echo "---------------------------------------------------"
    systemctl status ip6tables | grep " Active: active (running) "
    echo "---------------------------------------------------"
    ## Check State ##
    if [ "$(systemctl is-enabled ip6tables)" == "enabled" ]; then
       [ $(systemctl status ip6tables | grep " Active: active (running) " | wc -l) -eq 0 ] || result=Pass
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

## Section 4 - 
test_4.2.1.1() {
    result=Fail
    echo "4.2.1.1 Ensure rsyslog is installed"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  rpm -q rsyslog :"
    echo "---------------------------------------------------"
    rpm -q rsyslog
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(rpm -q rsyslog &>/dev/null; echo $?) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.1.2() {
    result=Fail
    echo "4.2.1.2 Ensure rsyslog Service is enabled and running"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  systemctl is-enabled rsyslog
                systemctl status rsyslog | grep 'active (running) ' :"
    echo "---------------------------------------------------"
    systemctl is-enabled rsyslog
    systemctl status rsyslog | grep 'active (running) '
    echo "---------------------------------------------------"
    ## Check State ##
    if [ "$(systemctl is-enabled rsyslog)" == "enabled" ]; then
       [ $(systemctl status rsyslog | grep 'active (running) ' | wc -l) -eq 0 ] || result=Pass
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.1.3() {
    result=Fail
    echo "4.2.1.3 Ensure rsyslog default file permissions configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ^\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf :"
    echo "---------------------------------------------------"
    grep ^\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    included_files="$(awk '/^\$IncludeConfig / {print $2}' /etc/rsyslog.conf | paste -sd\ )"
    [ $(egrep -hc '^\$FileCreateMode\s+0?640' /etc/rsyslog.conf $included_files 2>/dev/null | paste -sd+ | bc ) -gt 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.1.4() {
    result=Fail
    echo "4.2.1.4 Ensure logging is configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  ls -l /var/log/ :"
    echo "---------------------------------------------------"
    ls -l /var/log/
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.1.5() {
    result=Fail
    echo "4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ""^*.*[^I][^I]*@"" /etc/rsyslog.conf /etc/rsyslog.d/*.conf :"
    echo "---------------------------------------------------"
    grep "^*.*[^I][^I]*@" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c '^*.*[^I][^I]*@' /etc/rsyslog.conf) -gt 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.1.6() {
    result=Fail
    echo "4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts."
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep 'ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 
                grep 'InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf:"
    echo "---------------------------------------------------"
    grep '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
    grep '$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep "#" | wc -l) -eq 0 ] || state=1
    [ $(grep '$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep "#" | wc -l) -eq 0 ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.2.1() {
    result=Fail
    echo "4.2.2.1 Ensure journald is configured to send logs to rsyslog"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -E ^\s*ForwardToSyslog /etc/systemd/journald.conf :"
    echo "---------------------------------------------------"
    grep -E ^\s*ForwardToSyslog /etc/systemd/journald.conf
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -E ^\s*ForwardToSyslog /etc/systemd/journald.conf | wc -l) -eq 0 ] || result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.2.2() {
    result=Fail
    echo "4.2.2.2 Ensure journald is configured to compress large log files"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -E ^\s*Compress /etc/systemd/journald.conf :"
    echo "---------------------------------------------------"
    grep -E ^\s*Compress /etc/systemd/journald.conf
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -E ^\s*Compress /etc/systemd/journald.conf | wc -l) -eq 0 ] || result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.2.3() {
    result=Fail
    echo "4.2.2.3 Ensure journald is configured to write logfiles to persistent disk"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -E ^\s*Storage /etc/systemd/journald.conf :"
    echo "---------------------------------------------------"
    grep -E ^\s*Storage /etc/systemd/journald.conf
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -E ^\s*Storage /etc/systemd/journald.conf | wc -l) -eq 0 ] || result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.3() {
    result=Fail
    echo "4.2.3 Ensure permissions on all logfiles are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  find /var/log -type f -perm /g+wx,o+rwx -exec ls -l {} \; :"
    echo "---------------------------------------------------"
    find /var/log -type f -perm /g+wx,o+rwx -exec ls -l {} \;
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(find /var/log -type f -perm /g+wx,o+rwx -exec ls -l {} \; | wc -l) -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_4.2.4() {
    result=Fail
    echo "4.2.4 Ensure logrotate is configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  cat /etc/logrotate.conf && cat /etc/logrotate.d/* :"
    echo "---------------------------------------------------"
    cat /etc/logrotate.conf && cat /etc/logrotate.d/*
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

## Section 5 Access, Authentication and Authorization
test_5.1.1() {
    result=Fail
    echo "5.1.1 Ensure cron daemon is enabled and running"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  systemctl is-enabled crond 
                systemctl status crond | grep 'Active: active (running) ':"
    echo "---------------------------------------------------"
    systemctl is-enabled crond
    echo "---------------------------------------------------"
    systemctl status crond | grep 'Active: active (running) '
    echo "---------------------------------------------------"
    ## Check State ##
    if [ "$(systemctl is-enabled crond)" == "enabled" ]; then
       [ $(systemctl status crond | grep 'Active: active (running) ' | wc -l) -eq 0 ] || result=Pass
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.2() {
    result=Fail
    echo "5.1.2 Ensure permissions on /etc/crontab are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/crontab :"
    echo "---------------------------------------------------"
    stat /etc/crontab
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=600
    file=/etc/crontab
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.3() {
    result=Fail
    echo "5.1.3 Ensure permissions on /etc/cron.hourly are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/cron.hourly/ :"
    echo "---------------------------------------------------"
    stat /etc/cron.hourly/
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=700
    file=/etc/cron.hourly/
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.4() {
    result=Fail
    echo "5.1.4 Ensure permissions on /etc/cron.daily are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/cron.daily/ :"
    echo "---------------------------------------------------"
    stat /etc/cron.daily/
    echo "---------------------------------------------------"
   ## Check State ##
    state=0
    perms=700
    file=/etc/cron.daily/
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.5() {
    result=Fail
    echo "5.1.5 Ensure permissions on /etc/cron.weekly are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/cron.weekly :"
    echo "---------------------------------------------------"
    stat /etc/cron.weekly
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=700
    file=/etc/cron.weekly
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.6() {
    result=Fail
    echo "5.1.6 Ensure permissions on /etc/cron.monthly are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/cron.monthly/ :"
    echo "---------------------------------------------------"
    stat /etc/cron.monthly/
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=700
    file=/etc/cron.monthly/
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.7() {
    result=Fail
    echo "5.1.7 Ensure permissions on /etc/cron.d are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/cron.d :"
    echo "---------------------------------------------------"
    stat /etc/cron.d
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=700
    file=/etc/cron.d
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.8() {
    result=Fail
    echo "5.1.8 Ensure cron is restricted to authorized users"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/cron.deny
                stat /etc/cron.allow :"
    echo "---------------------------------------------------"
    stat /etc/cron.deny
    echo "---------------------------------------------------"
    stat /etc/cron.allow
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ -f /etc/cron.deny ] && state=$(( $state + 1 ))
    if [ -f /etc/cron.allow ]; then
        [ "$(stat /etc/cron.allow 2>/dev/null| grep -m1 ^Access:)" == 'Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)' ] || state=$(( $state + 2 ))
    fi
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.1.9() {
    result=Fail
    echo "5.1.9 Ensure at is restricted to authorized users"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/at.deny
                stat /etc/at.allow :"
    echo "---------------------------------------------------"
    stat /etc/at.deny
    echo "---------------------------------------------------"
    stat /etc/at.allow
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ -f /etc/at.deny ] && state=$(( $state + 1 ))
    if [ -f /etc/at.allow ]; then
        [ "$(stat /etc/at.allow 2>/dev/null| grep -m1 ^Access:)" == 'Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)' ] || state=$(( $state + 2 ))
    fi
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
##SSH
test_5.2.1() {
    result=Fail
    echo "5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  stat /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    stat /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=600
    file=/etc/ssh/sshd_config
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.2() {
    result=Fail
    echo "5.2.2 Ensure permissions on SSH private host key files are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat {} \; :"
    echo "---------------------------------------------------"
    find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat {} \;
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.3() {
    result=Fail
    echo "5.2.3 Ensure permissions on SSH public host key files are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \; :"
    echo "---------------------------------------------------"
    find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \;
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.4() {
    result=Fail
    echo "5.2.4 Ensure SSH access is limited"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  sshd -T | grep -E '^\s*(allow|deny)(users|groups)\s+\S+' :"
    echo "---------------------------------------------------"
    sshd -T | grep -E '^\s*(allow|deny)(users|groups)\s+\S+'
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(sshd -T | grep -E '^\s*(allow|deny)(users|groups)\s+\S+' | wc -l) -eq 0 ] || result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.5() {
    result=Fail
    echo "5.2.5 Ensure SSH LogLevel is appropriate"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -c ""^LogLevel\sINFO"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^LogLevel\sINFO" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^LogLevel\sINFO" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    [ $(grep -c "^LogLevel\sVERBOSE" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.7() {
    result=Fail
    echo "5.2.7 Ensure SSH MaxAuthTries is set to 4 or less"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  egrep -c ""^MaxAuthTries\s[0-4]$"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    egrep "^MaxAuthTries\s[0-4]$" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(egrep -c "^MaxAuthTries\s[0-4]$" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.8() {
    result=Fail
    echo "5.2.8 Ensure SSH IgnoreRhosts is enabled"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -c "^IgnoreRhosts\syes" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^IgnoreRhosts\syes" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^IgnoreRhosts\syes" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.9() {
    result=Fail
    echo "5.2.9 Ensure SSH HostbasedAuthentication is disabled"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -c ""^HostbasedAuthentication\sno"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^HostbasedAuthentication\sno" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^HostbasedAuthentication\sno" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.10() {
    result=Fail
    echo "5.2.10 Ensure SSH root login is disabled"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -c ""^PermitRootLogin\sno"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^PermitRootLogin\sno" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^PermitRootLogin\sno" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.11() {
    result=Fail
    echo "5.2.11 Ensure SSH PermitEmptyPasswords is disabled"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -c ""^PermitEmptyPasswords\sno"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^PermitEmptyPasswords\sno" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^PermitEmptyPasswords\sno" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.12() {
    result=Fail
    echo "5.2.12 Ensure SSH PermitUserEnvironment is disabled"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -c ""^PermitUserEnvironment\sno"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^PermitUserEnvironment\sno" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^PermitUserEnvironment\sno" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.13() {
    result=Fail
    echo "5.2.13 Ensure only strong Ciphers are used"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   sshd -T | grep ciphers :"
    echo "---------------------------------------------------"
    sshd -T | grep ciphers
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.14() {
    result=Fail
    echo "5.2.14 Ensure only strong MAC algorithms are used"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  sshd -T | grep -i ""MACs"" :"
    echo "---------------------------------------------------"
    sshd -T | grep -i "MACs"
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.15() {
    result=Fail
    echo "5.2.15 Ensure only strong Key Exchange algorithms are used"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  sshd -T | grep kexalgorithms :"
    echo "---------------------------------------------------"
    sshd -T | grep kexalgorithms
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.16() {
    result=Fail
    echo "5.2.16 Ensure SSH Idle Timeout Interval is configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ""^ClientAlive"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^ClientAlive" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(grep -c "^ClientAlive" /etc/ssh/sshd_config) -eq 2 ]; then
        [ $(grep "^ClientAliveInterval" /etc/ssh/sshd_config | awk '{print $2}') -le 300 ] || state=1
        [ $(grep "^ClientAliveCountMax" /etc/ssh/sshd_config | awk '{print $2}') -eq 3 ] || state=1
    else
        state=1
    fi
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.17() {
    result=Fail
    echo "5.2.17 Ensure SSH LoginGraceTime is set to one minute or less"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -c ""^LoginGraceTime"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^LoginGraceTime" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(grep -c "^LoginGraceTime" /etc/ssh/sshd_config) -eq 1 ]; then
        [ $(grep "^LoginGraceTime" /etc/ssh/sshd_config | awk '{print $2}') -le 60 ] && result="Pass"
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.18() {
    result=Fail
    echo "5.2.18 Ensure SSH warning banner is configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  sshd -T | grep banner :"
    echo "---------------------------------------------------"
    sshd -T | grep banner
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^Banner\s/etc/issue.net$" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.19() {
    result=Fail
    echo "5.2.19 Ensure SSH PAM is enabled"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ""^UsePAM\syes"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^UsePAM\syes" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    [ $(grep -c "^UsePAM\syes" /etc/ssh/sshd_config) -eq 1 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.21() {
    result=Fail
    echo "5.2.21 Ensure SSH MaxStartups is configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ""^MaxStartups"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^MaxStartups" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    if [ $(grep -c "^MaxStartups" /etc/ssh/sshd_config) -eq 1 ]; then
        [ "$(grep "^MaxStartups" /etc/ssh/sshd_config | awk '{print $2}')" == "10:30:60" ] && result="Pass"
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.2.22() {
    result=Fail
    echo "5.2.22 Ensure SSH MaxSessions is limited"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ""^MaxSessions"" /etc/ssh/sshd_config :"
    echo "---------------------------------------------------"
    grep "^MaxSessions" /etc/ssh/sshd_config
    echo "---------------------------------------------------"
    ## Check State ##
    if [ $(grep -c "^MaxSessions" /etc/ssh/sshd_config) -eq 1 ]; then
        [ $(grep "^MaxSessions" /etc/ssh/sshd_config | awk '{print $2}') -le 10 ] && result="Pass"
    fi
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
## Password
test_5.3.1() {
    result=Fail
    echo "5.3.1 Ensure password creation requirements are configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:   grep '^\s*minlen\s*' /etc/security/pwquality.conf
                grep '^\s*minclass\s*' /etc/security/pwquality.conf :"
    echo "---------------------------------------------------"
    grep '^\s*minlen\s*' /etc/security/pwquality.conf
    echo "---------------------------------------------------"
    grep '^\s*minclass\s*' /etc/security/pwquality.conf
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ "$(egrep -c "^password\s+requisite\s+pam_pwquality.so.*try_first_pass.*retry=3" /etc/pam.d/password-auth)" -eq 1 ] || state=$(( $state + 1 ))
    [ "$(egrep -c "^password\s+requisite\s+pam_pwquality.so.*try_first_pass.*retry=3" /etc/pam.d/system-auth)" -eq 1 ] || state=$(( $state + 2 ))

    minlen="$(awk '/^(\s+)?minlen = / {print $3}' /etc/security/pwquality.conf)"
    minlen=${minlen:=0}
    [ "$minlen" -ge 14 ] || state=$(( $state + 4 ))
    minclass="$(awk '/^(\s+)?minclass = / {print $3}' /etc/security/pwquality.conf)"
    minclass=${minclass:=0}
    [ "$minclass" -ge 4 ] || state=$(( $state + 8 ))

    [ $state -eq 0 ]&& result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.3.2() {
    result=Fail
    echo "5.3.2 Ensure lockout for failed password attempts is configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -E '^\s*auth\s+\S+\s+pam_(faillock|unix)\.so' /etc/pam.d/system-auth  /etc/pam.d/password-auth 
                grep -E '^\s*auth\s+\S+\s+pam_(tally2|unix)\.so' /etc/pam.d/system-auth /etc/pam.d/password-auth :"
    echo "---------------------------------------------------"
    grep -E '^\s*auth\s+\S+\s+pam_(faillock|unix)\.so' /etc/pam.d/system-auth  /etc/pam.d/password-auth
    echo "---------------------------------------------------"
    grep -E '^\s*auth\s+\S+\s+pam_(tally2|unix)\.so' /etc/pam.d/system-auth /etc/pam.d/password-auth
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
     ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.3.3() {
    result=Fail
    echo "5.3.3 Ensure password hashing algorithm is SHA-512"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  --- :"
    echo "---------------------------------------------------"
    grep -E '^\s*password\s+(\S+\s+)+pam_unix\.so\s+(\S+\s+)*sha512\s*(\S+\s*)*(\s+#.*)?$' /etc/pam.d/system-auth /etc/pam.d/password-auth
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(egrep -c "^password\s+sufficient\s+pam_unix.so.*sha512" /etc/pam.d/system-auth) -eq 1 ] || state=1
    [ $(egrep -c "^password\s+sufficient\s+pam_unix.so.*sha512" /etc/pam.d/password-auth) -eq 1 ] || state=1
    
    [ $state -eq 0 ]&& result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.3.4() {
    result=Fail
    echo "5.3.4 Ensure password reuse is limited"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep -P '^\s*password\s+(requisite|required)\s+pam_pwhistory\.so\s+([^#]+\s+)*remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth
                grep -P '^\s*password\s+(sufficient|requisite|required)\s+pam_unix\.so\s+([^#]+\s+)*remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password_auth :"
    echo "---------------------------------------------------"
    grep -P '^\s*password\s+(requisite|required)\s+pam_pwhistory\.so\s+([^#]+\s+)*remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth
    echo "---------------------------------------------------"
    grep -P '^\s*password\s+(sufficient|requisite|required)\s+pam_unix\.so\s+([^#]+\s+)*remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password_auth
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.1.1() {
    result=Fail
    echo "5.4.1.1 Ensure password expiration is 365 days or less "
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ^\s*PASS_MAX_DAYS /etc/login.defs
                grep -E '^[^:]+:[^!*]' /etc/shadow | cut -d: -f1,5 :"
    echo "---------------------------------------------------"
    grep ^\s*PASS_MAX_DAYS /etc/login.defs
    echo "---------------------------------------------------"
    grep -E '^[^:]+:[^!*]' /etc/shadow | cut -d: -f1,5
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    file="/etc/login.defs"
    days=365
    if [ -s $file ]; then
        if [ $(grep -c "^PASS_MAX_DAYS" $file) -eq 1 ]; then
            [ $(awk '/^PASS_MAX_DAYS/ {print $2}' $file) -le $days ] || state=1
        fi
    fi
    
    for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1); do 
        [ $(chage --list $i 2>/dev/null | awk '/Maximum/ {print $9}') -le $days ] || state=1
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.1.2() {
    result=Fail
    echo "5.4.1.2 Ensure minimum days between password changes is configured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND: grep ^\s*PASS_MIN_DAYS /etc/login.defs 
                grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1,4:"
    echo "---------------------------------------------------"
    grep ^\s*PASS_MIN_DAYS /etc/login.defs
    grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1,4
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    file="/etc/login.defs"
    days=1
    if [ -s $file ]; then
        if [ $(grep -c "^PASS_MAX_DAYS" $file) -eq 1 ]; then
            [ $(awk '/^PASS_MAX_DAYS/ {print $2}' $file) -ge $days ] || state=$(( $state + 1))
        fi
    fi
    
    for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1); do 
        [ $(chage --list $i 2>/dev/null | awk '/Minimum/ {print $9}') -ge $days ] || state=$(( $state + 2 ))
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.1.3() {
    result=Fail
    echo "5.4.1.3 Ensure password expiration warning days is 7 or more"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  grep ^\s*PASS_WARN_AGE /etc/login.defs 
                grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1,6 :"
    echo "---------------------------------------------------"
    grep ^\s*PASS_WARN_AGE /etc/login.defs
    echo "---------------------------------------------------"
    grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1,6
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    file="/etc/login.defs"
    days=7
    if [ -s $file ]; then
        if [ $(grep -c "^PASS_WARN_AGE" $file) -eq 1 ]; then
            [ $(awk '/^PASS_WARN_AGE/ {print $2}' $file) -ge $days ] || state=1
        fi
    fi
    
    for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1); do 
        [ $(chage --list $i 2>/dev/null | awk '/warning/ {print $10}') -ge $days ] || state=1
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.1.4() {
    result=Fail
    echo "5.4.1.4 Ensure inactive password lock is 30 days or less"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  useradd -D | grep INACTIVE
                grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1,7 :"
    echo "---------------------------------------------------"
    useradd -D | grep INACTIVE
    echo "---------------------------------------------------"
    grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1,7
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    max_days=30
    max_seconds=$(( $max_days * 24 * 60 * 60 ))
    
    [ $(useradd -D | grep INACTIVE | sed 's/^.*=//') -gt 0 -a $(useradd -D | grep INACTIVE | sed 's/^.*=//') -le $max_days ] || state=1
    
    for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1); do 
        [ $(chage --list $i 2>/dev/null | awk '/Password expires/ {print $4}') != "never" ] && does_password_expire=True || does_password_expire=False
        [ $(chage --list $i 2>/dev/null | awk '/Password inactive/ {print $4}') != "never" ] && does_password_inactive=True || does_password_inactive=False

        if [ "$does_password_expire" == 'True' -a "$does_password_inactive" == 'True' ]; then
            password_expires=$(chage --list $i | sed -n '/Password expires/ s/^.*: //p')
            password_inactive=$(chage --list $i | sed -n '/Password inactive/ s/^.*: //p')
            
            expires_time=$(date +%s -d "$password_expires")
            inactive_time=$(date +%s -d "$password_inactive")
            
            time_difference=$(( $inactive_time - $expires_time ))
            
            [ $time_difference -gt $max_seconds ] && state=1
            
        else
            state=1
        fi
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.1.5() {
    result=Fail
    echo "5.4.1.5 Ensure all users last password change date is in the past"
   ## Tests Start ##
    echo "      Result:"
    #echo "      COMAND:  for usr in $(cut -d: -f1 /etc/shadow); do [[ $(chage --list $usr | grep '^Last password change' | cut -d: -f2) > $(date) ]] && echo "$usr :$(chage --list $usr | grep '^Last password change' | cut -d: -f2)"; done :"
    echo "---------------------------------------------------"
    for usr in $(cut -d: -f1 /etc/shadow); do [[ $(chage --list $usr | grep '^Last password change' | cut -d: -f2) > $(date) ]] && echo "$usr$usr:---$(chage --list $usr | grep '^Last password change' | cut -d: -f2)"; done
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    
    for user in $(cat /etc/shadow | cut -d: -f1); do 
        change_date=$(chage --list $user | sed -n '/Last password change/ s/^.*: //p') &>/dev/null
        
        if [ "$change_date" != 'never' ]; then
            [ $(date +%s) -gt $(date -d "$change_date" +%s) ] || state=1
        fi
    done

    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.2() {
    result=Fail
    echo "5.4.2 Ensure system accounts are secured"
   ## Tests Start ##
    echo "      Result:"
    echo "      COMAND:  awk -F: '($1!=""root"" && $1!=""sync"" && $1!=""shutdown"" && $1!=""halt"" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!=""/bin/false"") {print}' /etc/passwd
                awk -F: '($1!=""root"" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!=""LK"") {print $1}' :"
    echo "---------------------------------------------------"
    awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print}' /etc/passwd
    echo "---------------------------------------------------"
    awk -F: '($1!="root" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}'
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print}' /etc/passwd | wc -l) -eq 0 ] || state=1
    [ $(awk -F: '($1!="root" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}' | wc -l) -eq 0 ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

test_5.4.3() {
    result=Fail
    echo "5.4.3 Ensure default group for the root account is GID 0"
   ## Tests Start ##
    echo "      Result:# grep "^root:" /etc/passwd | cut -f4 -d: "
    echo "---------------------------------------------------"
    grep "^root:" /etc/passwd | cut -f4 -d:
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(grep "^root:" /etc/passwd | cut -f4 -d:) -eq 0 ] && result="Pass"
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.4() {
    result=Fail
    echo "5.4.4 Ensure default user shell timeout is configured"
   ## Tests Start ##
    echo "      Result:# grep -P '^\s*([^$#;]+\s+)*TMOUT=(9[0-9][1-9]|0+|[1-9]\d{3,})\b\s*(\S+\s*)*(\s+#.*)?$' /etc/profile /etc/profile.d/*.sh /etc/bashrc :"
    echo "---------------------------------------------------"
    for f in /etc/bashrc /etc/profile /etc/profile.d/*.sh ; do grep -Eq '(^|^[^#]*;)\s*(readonly|export(\s+[^$#;]+\s*)*)?\s*TMOUT=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9])\b' $f && grep -Eq '(^|^[^#]*;)\s*readonly\s+TMOUT\b' $f && grep -Eq '(^|^[^#]*;)\s*export\s+([^$#;]+\s+)*TMOUT\b' $f && echo "TMOUT correctly configured in file: $f"; done
    echo "---------------------------------------------------"  
    grep -P '^\s*([^$#;]+\s+)*TMOUT=(9[0-9][1-9]|0+|[1-9]\d{3,})\b\s*(\S+\s*)*(\s+#.*)?$' /etc/profile /etc/profile.d/*.sh /etc/bashrc
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(for f in /etc/bashrc /etc/profile /etc/profile.d/*.sh ; do grep -Eq '(^|^[^#]*;)\s*(readonly|export(\s+[^$#;]+\s*)*)?\s*TMOUT=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9])\b' $f && grep -Eq '(^|^[^#]*;)\s*readonly\s+TMOUT\b' $f && grep -Eq '(^|^[^#]*;)\s*export\s+([^$#;]+\s+)*TMOUT\b' $f && echo "TMOUT correctly configured in file: $f"; done | wc -l ) -ne 0 ] || state=1
    [ $(grep -P '^\s*([^$#;]+\s+)*TMOUT=(9[0-9][1-9]|0+|[1-9]\d{3,})\b\s*(\S+\s*)*(\s+#.*)?$' /etc/profile /etc/profile.d/*.sh /etc/bashrc | wc -l ) -eq 0 ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.4.5() {
    result=Fail
    echo "5.4.5 Ensure default user umask is configured"
   ## Tests Start ##
    echo "      Result:# grep -Ev '^\s*umask\s+\s*(0[0-7][2-7]7|[0-7][2-7]7|u=(r?|w?|x?)(r?|w?|x?)(r?|w?|x?),g=(r?x?|x?r?),o=)\s*(\s*#.*)?$' /etc/profile /etc/profile.d/*.sh /etc/bashrc | grep -E '(^|^[^#]*)umask'
                grep -E '^\s*umask\s+\s*(0[0-7][2-7]7|[0-7][2-7]7|u=(r?|w?|x?)(r?|w?|x?)(r?|w?|x?),g=(r?x?|x?r?),o=)\s*(\s*#.*)?$' /etc/profile /etc/profile.d/*.sh /etc/bashrc "
    echo "---------------------------------------------------"
    grep -Ev '^\s*umask\s+\s*(0[0-7][2-7]7|[0-7][2-7]7|u=(r?|w?|x?)(r?|w?|x?)(r?|w?|x?),g=(r?x?|x?r?),o=)\s*(\s*#.*)?$' /etc/profile /etc/profile.d/*.sh /etc/bashrc | grep -E '(^|^[^#]*)umask'
    echo "---------------------------------------------------"
    grep -E '^\s*umask\s+\s*(0[0-7][2-7]7|[0-7][2-7]7|u=(r?|w?|x?)(r?|w?|x?)(r?|w?|x?),g=(r?x?|x?r?),o=)\s*(\s*#.*)?$' /etc/profile /etc/profile.d/*.sh /etc/bashrc
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    masks=$(awk '/^(\s+)?umask\s+[027]{3}/ {print $2}' /etc/bashrc /etc/profile)
    [ -z "$masks" ] && state=1

    for mask in $masks; do
        bits=($(echo $mask | grep -o .))
        
        [ ${bits[0]} -lt 0 ] && state=2
        [ ${bits[1]} -lt 2 ] && state=2
        [ ${bits[2]} -lt 7 ] && state=2
    done

    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.5() {
    result=Fail
    echo "5.5 Ensure root login is restricted to system console"
   ## Tests Start ##
    echo "      Result:# cat /etc/securetty "
    echo "---------------------------------------------------"
    cat /etc/securetty | { tr -d '\n'; echo; }
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_5.6() {
    result=Fail
    echo "5.6 Ensure access to the su command is restricted"
   ## Tests Start ##
    echo "      Result:# grep -E '^\s*auth\s+required\s+pam_wheel\.so\s+(\S+\s+)*use_uid\s+(\S+\s+)*group=\S+\s*(\S+\s*)*(\s+#.*)?$' /etc/pam.d/su "
    echo "---------------------------------------------------"
    grep -E '^\s*auth\s+required\s+pam_wheel\.so\s+(\S+\s+)*use_uid\s+(\S+\s+)*group=\S+\s*(\S+\s*)*(\s+#.*)?$' /etc/pam.d/su
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    [ $(egrep -c "^auth\s+required\s+pam_wheel.so\s+use_uid" /etc/pam.d/su) -eq 1 ] || state=1
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

## Section 6 - 
test_6.1.2() {
    result=Fail
    echo "6.1.2 Ensure permissions on /etc/passwd are configured"
   ## Tests Start ##
    echo "      Result:# stat /etc/passwd "
    echo "---------------------------------------------------"
    stat /etc/passwd
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=644
    file=/etc/passwd
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.3() {
    result=Fail
    echo "6.1.3 Ensure permissions on /etc/shadow are configured"
   ## Tests Start ##
    echo "      Result:# stat /etc/shadow "
    echo "---------------------------------------------------"
    stat /etc/shadow
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=000
    file=/etc/shadow
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.4() {
    result=Fail
    echo "6.1.4 Ensure permissions on /etc/group are configured"
   ## Tests Start ##
    echo "      Result:# stat /etc/group "
    echo "---------------------------------------------------"
    stat /etc/group
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=644
    file=/etc/group
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.5() {
    result=Fail
    echo "6.1.5 Ensure permissions on /etc/gshadow are configured"
   ## Tests Start ##
    echo "      Result:# stat /etc/gshadow "
    echo "---------------------------------------------------"
    stat /etc/gshadow
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    perms=000
    file=/etc/gshadow
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.6() {
    result=Fail
    echo "6.1.6 Ensure permissions on /etc/passwd- are configured"
   ## Tests Start ##
    echo "      Result:#  stat /etc/passwd- "
    echo "---------------------------------------------------"
    stat /etc/passwd-
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    perms=644
    file=/etc/passwd-
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.7() {
    result=Fail
    echo "6.1.7 Ensure permissions on /etc/shadow- are configured"
   ## Tests Start ##
    echo "      Result:#  stat /etc/shadow- "
    echo "---------------------------------------------------"
    stat /etc/shadow-
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    perms=000
    file=/etc/shadow-
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.8() {
    result=Fail
    echo "6.1.8 Ensure permissions on /etc/group- are configured"
   ## Tests Start ##
    echo "      Result:#  stat /etc/group- "
    echo "---------------------------------------------------"
    stat /etc/group-
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    perms=644
    file=/etc/group-
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.9() {
    result=Fail
    echo "6.1.9 Ensure permissions on /etc/gshadow- are configured"
   ## Tests Start ##
    echo "      Result:#  stat /etc/gshadow- "
    echo "---------------------------------------------------"
    stat /etc/gshadow-
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    perms=000
    file=/etc/gshadow-
    u=$(echo $perms | cut -c1)
    g=$(echo $perms | cut -c2)
    o=$(echo $perms | cut -c3)
    file_perms="$(stat -L $file | awk '/Access: \(/ {print $2}')"
    file_u=$(echo $file_perms | cut -c3)
    file_g=$(echo $file_perms | cut -c4)
    file_o=$(echo $file_perms | cut -c5)
    
    [ "$(ls -ld $file | awk '{ print $3" "$4 }')" == "root root" ] || state=1
    [ $file_u -le $u ] || state=1
    [ $file_g -le $g ] || state=1
    [ $file_o -le $o ] || state=1
    
    [ $state -eq 0 ] && result=Pass
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.10() {
    result=Fail
    echo "6.1.10 Ensure no world writable files exist"
    ## Tests Start ##
    echo "      Result:#  df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002 "
    echo "---------------------------------------------------"
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(df --local -P | awk 'NR!=1 {print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002 | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.11() {
    result=Fail
    echo "6.1.11 Ensure no unowned files or directories exist"
    ## Tests Start ##
    echo "      Result:#  df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser "
    echo "---------------------------------------------------"
    df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(df --local -P | awk 'NR!=1 {print $6}' | xargs -I '{}' find '{}' -xdev -nouser 2>/dev/null | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.12() {
    result=Fail
    echo "6.1.12 Ensure no ungrouped files or directories exist"
    ## Tests Start ##
    echo "      Result:#  df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup "
    echo "---------------------------------------------------"
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(df --local -P | awk 'NR!=1 {print $6}' | xargs -I '{}' find '{}' -xdev -nogroup 2>/dev/null | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.13() {
    result=Fail
    echo "6.1.13 Audit SUID executables"
    ## Tests Start ##
    echo "      Result:#  df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 "
    echo "---------------------------------------------------"
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.1.14() {
    result=Fail
    echo "6.1.14 Audit SGID executables"
    ## Tests Start ##
    echo "      Result:#  df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 "
    echo "---------------------------------------------------"
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000
    echo "---------------------------------------------------"
    ## Check State ##
    result="Mann"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.1() {
    result=Fail
    echo "6.2.1 Ensure accounts in /etc/passwd use shadowed passwords"
    ## Tests Start ##
    echo "      Result:#  awk -F: '($2 != ""x"" ) { print $1 "" is not set to shadowed passwords ""}' /etc/passwd "
    echo "---------------------------------------------------"
    awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.2() {
    result=Fail
    echo "6.2.2 Ensure /etc/shadow password fields are not empty"
    ## Tests Start ##
    echo "      Result:#   awk -F: '($2 == "" ) { print $1 "" does not have a password ""}' /etc/shadow "
    echo "---------------------------------------------------"
     awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(awk -F: '($2 == "" )' /etc/shadow | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.3() {
    result=Fail
    echo "6.2.3 Ensure root is the only UID 0 account"
    ## Tests Start ##
    echo "      Result:#  awk -F: '($3 == 0) { print $1 }' /etc/passwd "
    echo "---------------------------------------------------"
    c=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)
    echo "$c-$c"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(awk -F: '$3 == 0' /etc/passwd | wc -l) -eq 1 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.4() {
    result=Fail
    echo "6.2.4 Ensure root PATH Integrity"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"

    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(echo $PATH | grep -c '::') -eq 0 ] || state=$(( $state + 1 ))
    [ $(echo $PATH | grep -c ':$') -eq 0 ] || state=$(( $state + 2 ))
    
    if [ $state -eq 0 ]; then
        for p in $(echo $PATH | sed -e 's/::/:/' -e 's/:$//' -e 's/:/ /g'); do 
            if [ -d $p ]; then
                if [ "$p" != "." ]; then
                    perms=$(ls -hald "$p/")
                    [ "$(echo $perms | cut -c6)" == '-' ] || state=$(( $state + 4 ))
                    [ "$(echo $perms | cut -c9)" == '-' ] || state=$(( $state + 8 ))
                    [ "$(echo $perms | awk '{print $3}')" == "root" ] || state=$(( $state + 16 ))
                else
                    state=$(( $state + 32 ))
                fi
            fi
        done
    fi
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.5() {
    result=Fail
    echo "6.2.5 Ensure all users' home directories exist"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read -r user dir; do
	if [ ! -d "$dir" ]; then
		echo "The home directory ($dir) of user $user does not exist."
	fi
    done
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    awk -F: '{ print $1" "$3" "$6 }' /etc/passwd |\
        while read user uid dir; do
            [ $uid -ge 1000 -a ! -d "$dir" -a $user != "nfsnobody" ] && state=1
        done 
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.6() {
    result=Fail
    echo "6.2.6 Ensure users' home directories permissions are 750 or more restrictive"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    for dir in $(egrep -v '(halt|sync|shutdown|/sbin/nologin|vboxadd)' /etc/passwd | awk -F: '{print $6}'); do
        perms=$(stat $dir | awk 'NR==4 {print $2}' )

        [ $(echo $perms | cut -c12) == "-" ] || state=$(( $state + 1 ))
        [ $(echo $perms | cut -c14) == "-" ] || state=$(( $state + 2 ))
        [ $(echo $perms | cut -c15) == "-" ] || state=$(( $state + 4 ))
        [ $(echo $perms | cut -c16) == "-" ] || state=$(( $state + 8 ))
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.7() {
    result=Fail
    echo "6.2.7 Ensure users own their home directories"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    awk -F: '{ print $1 " " $3 " " $6 }' /etc/passwd | while read user uid dir; do
        if [ $uid -ge 1000 -a -d "$dir" -a $user != "nfsnobody" ]; then 
            owner=$(stat -L -c "%U" "$dir")
            [ "$owner" == "$user" ] || state=1
        fi
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.8() {
    result=Fail
    echo "6.2.8 Ensure users' dot files are not group or world writable"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    for dir in `cat /etc/passwd | egrep -v '(sync|halt|shutdown)' | awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
        for file in $dir/.[A-Za-z0-9]*; do
            if [ ! -h "$file" -a -f "$file" ]; then
                fileperm=`ls -ld $file | cut -f1 -d" "`
                
                [ `echo $fileperm | cut -c6` == "-" ] || state=1
                [ `echo $fileperm | cut -c9`  == "-" ] || state=1
            fi
        done
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.9() {
    result=Fail
    echo "6.2.9 Ensure no users have .forward files"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    for dir in $(awk -F: '{ print $6 }' /etc/passwd); do
        [ -e "$dir/.forward" ] && state=1
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.10() {
    result=Fail
    echo "6.2.10 Ensure no users have .netrc files"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    for dir in $(awk -F: '{ print $6 }' /etc/passwd); do
        [ -e "$dir/.netrc" ] && state=1
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.11() {
    result=Fail
    echo "6.2.11 Ensure users' .netrc Files are not group or world accessible"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    for dir in $(egrep -v '(root|sync|halt|shutdown|/sbin/nologin)' /etc/passwd | awk -F: '{print $6}'); do
        file=$dir/.netrc
        if [ ! -h "$file" -a -f "$file" ]; then
            fileperm=`ls -ld $file | cut -f1 -d" "`
            [ `echo $fileperm | cut -c5`  != "-" ] || state=1
            [ `echo $fileperm | cut -c6`  != "-" ] || state=1
            [ `echo $fileperm | cut -c7`  != "-" ] || state=1
            [ `echo $fileperm | cut -c8`  != "-" ] || state=1
            [ `echo $fileperm | cut -c9`  != "-" ] || state=1
            [ `echo $fileperm | cut -c10`  != "-" ] || state=1
        fi
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.12() {
    result=Fail
    echo "6.2.12 Ensure no users have .rhosts files"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
    ## Check State ##
    state=0
    for dir in $(awk -F: '{ print $6 }' /etc/passwd); do
        [ -e "$dir/.rhosts" ] && state=1
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.13() {
    result=Fail
    echo "6.2.13 Ensure all groups in /etc/passwd exist in /etc/group"
    ## Tests Start ##
    echo "      Result:#  ScripT! "
    echo "---------------------------------------------------"
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do 
        grep -q -P "^.*?:[^:]*:$i:" /etc/group
        [ $? -eq 0 ] || state=1
    done
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.14() {
    result=Fail
    echo "6.2.14 Ensure no duplicate UIDs exist"
    ## Tests Start ##
    echo "      Result:#  cut -f3 -d: /etc/passwd | sort | uniq -c | awk '$1 > 1' "
    echo "---------------------------------------------------"
    cut -f3 -d: /etc/passwd | sort | uniq -c | awk '$1 > 1'
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(cut -f3 -d: /etc/passwd | sort | uniq -c | awk '$1 > 1' | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.15() {
    result=Fail
    echo "6.2.15 Ensure no duplicate GIDs exist"
    ## Tests Start ##
    echo "      Result:#  cut -f3 -d: /etc/group | sort | uniq -c | awk '$1 > 1' "
    echo "---------------------------------------------------"
    cut -f3 -d: /etc/group | sort | uniq -c | awk '$1 > 1'
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(cut -f3 -d: /etc/group | sort | uniq -c | awk '$1 > 1' | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.16() {
    result=Fail
    echo "6.2.16 Ensure no duplicate user names exist"
    ## Tests Start ##
    echo "      Result:#  cut -f1 -d: /etc/passwd | sort | uniq -c | awk '$1 > 1' "
    echo "---------------------------------------------------"
    cut -f1 -d: /etc/passwd | sort | uniq -c | awk '$1 > 1'
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(cut -f1 -d: /etc/passwd | sort | uniq -c | awk '$1 > 1' | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.17() {
    result=Fail
    echo "6.2.17 Ensure no duplicate group names exist"
    ## Tests Start ##
    echo "      Result:#  cut -f1 -d: /etc/group | sort | uniq -c | awk '$1 > 1' "
    echo "---------------------------------------------------"
    cut -f1 -d: /etc/group | sort | uniq -c | awk '$1 > 1'
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(cut -f1 -d: /etc/group | sort | uniq -c | awk '$1 > 1' | wc -l) -eq 0 ] || state=1
    
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}
test_6.2.18() {
    result=Fail
    echo "6.2.18 Ensure shadow group is empty"
    ## Tests Start ##
    echo "      Result:#   grep ^shadow:[^:]*:[^:]*:[^:]+ /etc/group 
                awk -F: '($4 == ""<shadow-gid>"") { print }' /etc/passwd :"
    echo "---------------------------------------------------"
    grep ^shadow:[^:]*:[^:]*:[^:]+ /etc/group
    echo "---------------------------------------------------"
    awk -F: '($4 == "<shadow-gid>") { print }' /etc/passwd
    echo "---------------------------------------------------"
     ## Check State ##
    state=0
    [ $(grep ^shadow:[^:]*:[^:]*:[^:]+ /etc/group | wc -l) -eq 0 ] || state=1
    [ $(awk -F: '($4 == "<shadow-gid>") { print }' /etc/passwd | wc -l) -eq 0 ] || state=2
    [ $state -eq 0 ] && result="Pass"
    ## Check State End ##
    echo $result
    echo "####################################################"
    ## Tests End ##
}

### Main ###
## Main script execution starts here

## Parse arguments passed in to the script
parse_args $@
test_1.1.1.1
test_1.1.1.3
test_1.1.2
test_1.1.3
test_1.1.4
test_1.1.5
test_1.1.7
test_1.1.8
test_1.1.9
test_1.1.12
test_1.1.13
test_1.1.14
test_1.1.18
test_1.1.19
test_1.1.20
test_1.1.21
test_1.1.22
test_1.1.23
test_1.1.24
test_1.2.1
test_1.2.2
test_1.2.3
test_1.3.1
test_1.3.2
test_1.3.3
test_1.4.1
test_1.4.2
test_1.5.1
test_1.5.2
test_1.5.3
test_1.6.1
test_1.6.2
test_1.6.3
test_1.6.4
test_1.7.1.1
test_1.7.1.2
test_1.7.1.3
test_1.7.1.4
test_1.7.1.6
test_1.7.1.7
test_1.7.1.8
test_1.8.1.1
test_1.8.1.2
test_1.8.1.3
test_1.8.1.4
test_1.8.1.5
test_1.8.1.6
test_1.9
test_1.10
test_2.1.1
test_2.2.1.1
test_2.2.1.2
test_2.2.1.3
test_2.2.2
test_2.2.3
test_2.2.4
test_2.2.5
test_2.2.6
test_2.2.7
test_2.2.8
test_2.2.9
test_2.2.10
test_2.2.11
test_2.2.12
test_2.2.13
test_2.2.14
test_2.2.15
test_2.2.16
test_2.2.17
test_2.2.18
test_2.2.19
test_2.2.10
test_2.3.1
test_2.3.2
test_2.3.3
test_2.3.4
test_2.3.5
test_3.1.2
test_3.2.1
test_3.2.2
test_3.3.1
test_3.3.2
test_3.3.3
test_3.3.4
test_3.3.5
test_3.3.6
test_3.3.7
test_3.3.8
test_3.3.9
##3.5.1 Configure firewalld
if [ $(rpm -q firewalld &>/dev/null; echo $?) -eq 0 ]; then
    test_3.5.1.1
    test_3.5.1.2
    test_3.5.1.3
    test_3.5.1.4
    test_3.5.1.5
    test_3.5.1.6
    test_3.5.1.7      
fi
##3.5.2 Configure nftables
if [ $(rpm -q nftables &>/dev/null; echo $?) -eq 0 ]; then
    test_3.5.2.1
    test_3.5.2.2
    test_3.5.2.4 
    test_3.5.2.5
    test_3.5.2.6
    test_3.5.2.7
    test_3.5.2.8
    test_3.5.2.9
    test_3.5.2.10
    #test_3.5.2.11 #din cauza acestei functie poate sa se blocheze rularea     
fi
##3.5.3 Configure iptables
if [ $(rpm -q iptables &>/dev/null; echo $?) -eq 0 ]; then
    test_3.5.3.1.1 
    test_3.5.3.1.2
    test_3.5.3.2.1
    test_3.5.3.2.2
    test_3.5.3.2.3
    test_3.5.3.2.4
    test_3.5.3.2.5
    test_3.5.3.2.6  
    test_3.5.3.3.1
    test_3.5.3.3.2
    test_3.5.3.3.3
    test_3.5.3.3.4
    test_3.5.3.3.5
    test_3.5.3.3.6   
fi
if [ $(rpm -q rsyslog &>/dev/null; echo $?) -eq 0 ]; then
    test_4.2.1.1
    test_4.2.1.2
    test_4.2.1.3
    test_4.2.1.4
    test_4.2.1.5
    test_4.2.1.6
    test_4.2.2.1
    test_4.2.2.2
    test_4.2.2.3
    test_4.2.3
    test_4.2.4
fi
##cron
test_5.1.1
test_5.1.2
test_5.1.3
test_5.1.4
test_5.1.5
test_5.1.6
test_5.1.7
test_5.1.8
test_5.1.9
#SSH
test_5.2.1
test_5.2.2
test_5.2.3
test_5.2.4
test_5.2.5
test_5.2.7
test_5.2.8
test_5.2.9
test_5.2.10
test_5.2.11
test_5.2.12
test_5.2.13
test_5.2.14
test_5.2.15
test_5.2.16
test_5.2.17
test_5.2.18
test_5.2.19
test_5.2.21
test_5.2.22
#Pass
test_5.3.1
test_5.3.2
test_5.3.3
test_5.3.4
test_5.4.1.1
test_5.4.1.2
test_5.4.1.3
test_5.4.1.4
test_5.4.1.5 #problem
test_5.4.2
test_5.4.3
test_5.4.4
test_5.4.5
test_5.5
test_5.6
test_6.1.2
test_6.1.3
test_6.1.4
test_6.1.5
test_6.1.6
test_6.1.7
test_6.1.8
test_6.1.9
test_6.1.10
test_6.1.11
test_6.1.12
test_6.1.13
test_6.1.14
test_6.2.1
test_6.2.2
test_6.2.3
test_6.2.4
test_6.2.5
test_6.2.6
test_6.2.7
test_6.2.8
test_6.2.9
test_6.2.10
test_6.2.11
test_6.2.12
test_6.2.13
test_6.2.14
test_6.2.15
test_6.2.16
test_6.2.17
test_6.2.18