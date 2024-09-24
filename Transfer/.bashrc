# 필요하다면 전역 정의를 source
#-----------------------------------

if [ -f /etc/bashrc ]; then
        . /etc/bashrc   # --> 있다면 /etc/bashrc 를 읽음.
fi

PATH=$PATH:/opt/local/bin:$HOME/bin
export PATH
export LANG=ko_KR.UTF-8
export TMOUT=0
export VVDN_TOP_DIR=~/ORAN/vvdn-oran/smjk_lshd

#-------------------------------------------------------------
# 아직 세트되지 않았다면 $DISPLAY 를 자동으로 세팅
#-------------------------------------------------------------

# Does not working scp and rsync because the below function...
#if [ -z ${DISPLAY:=""} ]; then
#    DISPLAY=$(who am i)
#    DISPLAY=${DISPLAY%%\!*}
#    if [ -n "$DISPLAY" ]; then
#        export DISPLAY=$DISPLAY:0.0
#    else
#        export DISPLAY=":0.0"  # 실패할 경우를 대비(fallback)
#    fi
#fi

#---------------
# 몇 가지 세팅
#---------------

set -o notify
set -o noclobber
set -o ignoreeof
set -o nounset
#set -o xtrace          # 디버깅용

shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s histappend histreedit
shopt -s extglob        # programmable completion에 유용

#-----------------------
# 인사말, motd 등등...
#-----------------------

# 먼저 색깔을 몇 개 정의:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color
# --> 좋군요. 도스에서 "ansi.sys"를 쓰는 것과 똑같은 효과가 있네요.

# 검정색 백그라운드에서 가장 좋게 보입니다.....
#echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}\n"
#date
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s     # 하루를 즐겁게.... :-)
fi

#function _exit()        # 쉘에서 종료시 실행할 함수
#{
#    echo -e "${RED}see you next time....${NC}"
#}
#trap _exit 0

#---------------
# 쉘 프롬프트
#---------------

function fastprompt()
{
    unset PROMPT_COMMAND
    case $TERM in
        *term | rxvt )
            PS1="[\h] \W > \[\033]0;[\u@\h] \w\007\]" ;;
        *)
            PS1="[\h] \W > " ;;
    esac
}

function powerprompt()
{
    _powerprompt()
    {
        LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
        TIME=$(date +%H:%M)
    }

    PROMPT_COMMAND=_powerprompt
    case $TERM in
        *term | rxvt  )
                        #PS1="${cyan}[\$TIME \$LOAD]$NC [\h \#] \w > \[\033]0;[\u@\h] \w\007\] $ " ;;
            PS1="${cyan}[\$TIME \$LOAD]$NC \u@\H:\W $ " ;;
        linux )
                        #PS1="${cyan}[\$TIME - \$LOAD]$NC [\h \#] \w $ " ;;
            PS1="${cyan}[\$TIME \$LOAD]$NC \u@\H:\W $ " ;;
        * )
                        #PS1="[\$TIME - \$LOAD] [\h \#] \w $ " ;;
            PS1="${cyan}[\$TIME \$LOAD]$NC \u@\H:\W $ " ;;
    esac
}

powerprompt     # 좀 느릴지도 모를 기본 프롬프트입니다.
#fastprompt       # 너무 느리면 fastprompt 를 쓰세요....

#===============================================================
#
# 별칭(alias)과 함수들
#
# 논쟁의 여지가 있지만 몇몇 함수들은 조금 덩치가 큰데(즉, 'lowercase')
# 제 워크스테이션은 램이 512메가거든요...
# 이 파일 크기를 줄이고 싶다면 이런 함수들은 스크립트로 빼도 됩니다.
#
# 많은 함수들은 bash-2.04 예제에서 거의 그대로 갖다 썼습니다.
#
#===============================================================

#-------------------------
# 개인적인 별칭들(Aliases)
#-------------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> 파일에 실수로 타격을 입히지 않게.

alias h='history'
alias j='jobs -l'
alias r='rlogin'
alias which='type -all'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'   # LPDEST 가 정의되어 있다고 가정
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'  # enscript 로 예쁜 출력하기(Pretty-print)
alias background='xv -root -quit -max -rmode 5' # 백그라운드 배경 그림
alias vi='vim'
alias du='du -h'
alias df='df -kh'
alias p='pwd'

# 'ls' 그룹(여러분이 GNU ls 를 쓴다고 가정)
#alias ls='ls -hF --color'      # 파일타입 인식을 위해 색깔을 추가
alias lx='ls -lXB'              # 확장자별로 정렬
alias lk='ls -lSr'              # 크기별로 정렬
alias la='ls -Al'               # 숨겨진 파일 보기
alias lr='ls -lR'               # 재귀적 ls
alias lt='ls -ltr'              # 날짜별로 정렬
alias lm='ls -al |more'         # 'more'로 파이프 걸기
alias tree='tree -Cs'           # 'ls'의 멋진 대용품


# 맞춤 'less'
#alias more='less'
#export PAGER=less
#export JLESSCHARSET='euc-kr'
#export LESSCHARSET='latin1'
#export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-' # lesspipe.sh 이 있다면 이걸 쓰세요
#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# 스펠링 오타용 - 아주 개인적임 :-)
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'

#----------------
# 재밌는 거 몇 개
#----------------

function xtitle ()
{
    case $TERM in
        *term | rxvt)
            echo -n -e "\033]0;$*\007" ;;
        *)  ;;
    esac
}

# 별칭들(aliases)...
alias top='xtitle Processes on $HOST && top'
alias make='xtitle Making $(basename $PWD) ; make'
alias ncftp="xtitle ncFTP ; ncftp"

# .. 과 함수들
#function man ()
#{
#xtitle The $(basename $1|tr -d .[:digit:]) manual
#       man -a "$*"
#       man $1
#}

function ll(){ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| egrep -v "^d|total "; }
function xemacs() { { command xemacs -private $* 2>&- & } && disown ;}
function te()  # xemacs/gnuserv 래퍼
{
    if [ "$(gnuclient -batch -eval t 2>&-)" == "t" ]; then
        gnuclient -q "$@";
    else
        ( xemacs "$@" & );
    fi
}

#-----------------------------------
# 파일 & 문자열 관련 함수들:
#-----------------------------------

function ff() # 파일 찾기
{
    if [ "$#" -gt 2 -o "$#" -eq 0 ]; then
        echo "Usage: ff \"filename\""
        return;
    fi

        find . -name '*'$1'*' ;
}

function fe()  # 파일을 찾아서 $2 의 인자로 실행
{
    if [ "$#" -gt 2 -o "$#" -eq 0 ]; then
        echo "Usage: fe \"filename\" [exec-cmd] argument"
        return;
    fi

        find . -name '*'$1'*' -exec $2 {} \; ;
}

function fstr() # 여러 파일중에서 문자열 찾기
{
    if [ "$#" -gt 2 -o "$#" -eq 0 ]; then
        echo "Usage: fstr \"pattern\" [files] "
        return;
    fi
    SMSO=$(tput smso)
    RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print | xargs grep -sin "$1" | \
sed "s/$1/$SMSO$1$RMSO/gI"
}

function cuttail() # 파일에서 끝의 n 줄을 잘라냄. 기본값은 10
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

function lowercase()  # 파일이름을 소문자로 변경
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function swap()         # 파일이름 두개를 서로 바꿈
{
    local TMPFILE=tmp.$$
    mv $1 $TMPFILE
    mv $2 $1
    mv $TMPFILE $2
}

#-----------------------------------
# 프로세스/시스템 관련 함수들:
#-----------------------------------

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# 이 함수는 리눅스의 'killall' 스크립트와 거의 비슷하지만
# 솔라리스에는, 제가 아는 한, 이와 비슷한 것이 없습니다.
function killps()   # 프로세스 이름으로 kill
{
    local pid pname sig="-TERM"   # 기본 시그널
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function my_ip() # IP 주소 알아내기
{
#    MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
#    MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig eth0 | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
}

function ii()   # 현재 호스트 관련 정보들 알아내기
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo
}

# 기타 유틸리티:

function repeat()       # 명령어를 n 번 반복
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C 형태의 문법
        eval "$@";
    done
}


function ask()
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

#=========================================================================
#
# PROGRAMMABLE COMPLETION - 오직 BASH 2.04 이후에서만 동작
# (거의 대부분은 bash 2.05 문서에서 가져왔습니다)
# 몇 가지 기능들을 쓰려면 bash-2.05 가 필요할 겁니다.
#
#=========================================================================

if [ "${BASH_VERSION%.*}" \< "2.05" ]; then
    echo "programmable completion 을 쓰려면 bash 2.05 이상으로 업그레이드가 필요합니다."
    return
fi

PATH=$PATH:/opt/arm-2014.05/bin:/opt/local/bin:$HOME/bin:/opt/aarch64/lin/aarch64-linux/bin:
export PATH
export LANG=ko_KR.UTF-8
export TMOUT=0
shopt -s extglob        # 꼭 필요함
set +o nounset          # 이렇게 안 하면 programmable completion 몇 가지는 실패

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# 옮긴이: 이 이후는 잘 모르겠네요. :(

complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
complete -A command    nohup exec eval trace gdb
complete -A command    command type which
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help     # currently same as builtins
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd

complete -f -d -X '*.gz'  gzip
complete -f -d -X '*.bz2' bzip2
complete -f -o default -X '!*.gz'  gunzip
complete -f -o default -X '!*.bz2' bunzip2
complete -f -o default -X '!*.pl'  perl perl5
complete -f -o default -X '!*.ps'  gs ghostview ps2pdf ps2ascii
complete -f -o default -X '!*.dvi' dvips dvipdf xdvi dviselect dvitype
complete -f -o default -X '!*.pdf' acroread pdf2ps
complete -f -o default -X '!*.+(pdf|ps)' gv
complete -f -o default -X '!*.texi*' makeinfo texi2dvi texi2html texi2pdf
complete -f -o default -X '!*.tex' tex latex slitex
complete -f -o default -X '!*.lyx' lyx
complete -f -o default -X '!*.+(jpg|gif|xpm|png|bmp)' xv gimp
complete -f -o default -X '!*.mp3' mpg123
complete -f -o default -X '!*.ogg' ogg123

# This is a 'universal' completion function - it works when commands have
# a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'
_universal_func ()
{
    case "$2" in
        -*)     ;;
        *)      return ;;
    esac

    case "$1" in
        \~*)    eval cmd=$1 ;;
        *)      cmd="$1" ;;
    esac
    COMPREPLY=( $("$cmd" --help | sed  -e '/--/!d' -e 's/.*--\([^ ]*\).*/--\1/'| \
grep ^"$2" |sort -u) )
}
complete  -o default -F _universal_func ldd wget bash id info

_make_targets ()
{
    local mdef makef gcmd cur prev i

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    # if prev argument is -f, return possible filename completions.
    # we could be a little smarter here and return matches against
    # `makefile Makefile *.mk', whatever exists
    case "$prev" in
        -*f)    COMPREPLY=( $(compgen -f $cur ) ); return 0;;
    esac

    # if we want an option, return the possible posix options
    case "$cur" in
        -)      COMPREPLY=(-e -f -i -k -n -p -q -r -S -s -t); return 0;;
    esac

    # make reads `makefile' before `Makefile'
    if [ -f makefile ]; then
        mdef=makefile
    elif [ -f Makefile ]; then
        mdef=Makefile
    else
        mdef=*.mk               # local convention
    fi

    # before we scan for targets, see if a makefile name was specified
    # with -f
    for (( i=0; i < ${#COMP_WORDS[@]}; i++ )); do
        if [[ ${COMP_WORDS[i]} == -*f ]]; then
            eval makef=${COMP_WORDS[i+1]}       # eval for tilde expansion
            break
        fi
    done

        [ -z "$makef" ] && makef=$mdef

    # if we have a partial word to complete, restrict completions to
    # matches of that word
    if [ -n "$2" ]; then gcmd='grep "^$2"' ; else gcmd=cat ; fi

    # if we don't want to use *.mk, we can take out the cat and use
    # test -f $makef and input redirection
    COMPREPLY=( $(cat $makef 2>/dev/null | awk 'BEGIN {FS=":"} /^[^.#   ][^=]*:/ {print $1}' | tr -s ' ' '\012' | sort -u | eval $gcmd ) )
}

complete -F _make_targets -X '+($*|*.[cho])' make gmake pmake

_configure_func ()
{
    case "$2" in
        -*)     ;;
        *)      return ;;
    esac

    case "$1" in
        \~*)    eval cmd=$1 ;;
        *)      cmd="$1" ;;
    esac

    COMPREPLY=( $("$cmd" --help | awk '{if ($1 ~ /--.*/) print $1}' | grep ^"$2" | sort -u) )
}

complete -F _configure_func configure

# cvs(1) completion
_cvs ()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    if [ $COMP_CWORD -eq 1 ] || [ "${prev:0:1}" = "-" ]; then
        COMPREPLY=( $( compgen -W 'add admin checkout commit diff \
        export history import log rdiff release remove rtag status \
        tag update' $cur ))
    else
        COMPREPLY=( $( compgen -f $cur ))
    fi
    return 0
}
complete -F _cvs cvs

_killall ()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    # get a list of processes (the first sed evaluation
    # takes care of swapped out processes, the second
    # takes care of getting the basename of the process)
    COMPREPLY=( $( /usr/bin/ps -u $USER -o comm  | \
        sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
        awk '{if ($0 ~ /^'$cur'/) print $0}' ))

    return 0
}

complete -F _killall killall killps

_sel(){
    echo "1. arm-none-linux-gnueabi ( 4.3.2 2008q3-72 ) - ( T2200          ) "
    echo "2. aarch64-xilinx-linux   ( 8.2.0  - 2019.1 ) - ( DKK NOKIA LGE  ) "
    echo "3. aarch64-xilinx-linux   ( 11.2.0 - 2022.2 ) - ( UQ             ) "
    echo "4. arm-none-linux-gnueabi ( 4.8.3           ) - ( JTower MU, HU  ) "
    echo "5. arm-linux-gnueabi-gcc  ( 7.5.0           ) - ( N-DAS HU       ) "
    echo "6. aarch64-xilinx-linux   ( 12.2.0 - 2023.1 ) - ( UQ[DPD], N-DAS MU-RU, J-TOWER R1 ) "
    echo "7. aarch64-linux-gnu-gcc  ( 8.2.0  - 2019.1 ) - ( DKK(old) ) "
    echo "8. aarch64-xilinx-linux   ( 8.2.0  - 2019.1 ) - ( O-RAN(SSHv3)   ) "

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
            CROSS_COMPILE=arm-linux-gnueabi-gcc
            $CROSS_COMPILE -v
            ;;
        6)
            PATH_HEADER=/opt/petalinux/2023.1
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
        7)
             PATH_HEADER=/opt/petalinux/2019_A2K
             P=$PATH_HEADER/sysroots/aarch64/lin/aarch64-linux/bin
             CROSS_COMPILE=aarch64-linux-gnu-gcc
            echo ". $PATH_HEADER/settings.sh"
            . $PATH_HEADER/settings.sh
             export PATH="$P:$PATH"
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
        *)
            echo "select compiler number"
            ;;
    esac

}

export LS_COLORS="no=00":"fi=00":"di=01;34":"ln=01;36":"pi=40;33":"so=01;35":"bd=40;33;01":"cd=40;33;01":"or=01;05;37;41":"mi=01;05;37;41":"ex=01;32":"*.cmd=01;32":"*.exe=01;32":"*.com=01;32":"*.btm=01;32":"*.bat=01;32":"*.sh=01;32":"*.csh=01;32":"*.tar=01;31":"*.tgz=01;31":"*.arj=01;31":"*.taz=01;31":"*.lzh=01;31":"*.zip=01;31":"*.z=01;31":"*.Z=01;31":"*.gz=01;31":"*.bz2=01;31":"*.bz=01;31":"*.tz=01;31":"*.rpm=01;31":"*.cpio=01;31":"*.jpg=01;35":"*.gif=01;35":"*.bmp=01;35":"*.xbm=01;35":"*.xpm=01;35":"*.png=01;35":"*.tif=01;35"
export LANG=ko_KR.UTF-8
export TERM=xterm

alias 1='fg %1'
alias 2='fg %2'
alias 3='fg %3'
alias 4='fg %4'
alias 5='fg %5'
alias 6='fg %6'
alias 7='fg %7'
alias 8='fg %8'
alias 9='fg %9'

alias cgrep='find -name "*.c" | xargs grep -n $1'
alias hgrep='find -name "*.h" | xargs grep -n $1'
alias xgrep='find -name "*.x" | xargs grep -n $1'
alias agrep='find . -iname "*" |xargs grep -n $1'
alias ctags1='find . -name "*.[cshSx]" | xargs ctags -a -R'
alias ctags2='find ./eNB ./Kernel -name "*.[cshSx]" | xargs ctags -a -R'
alias rm="rm -i"
alias ll="ls -la"
alias tag="ctags -R"
alias j='jobs'
alias c='clear'
alias m='more'
alias devenv='~/bin/devenv'
alias dev='~/bin/devenv'
alias devenv='~/bin/devenv'
alias dev='~/bin/devenv'
alias nnud='cd ~/work/NNU;devenv'
alias nnu='cd ~/work/NNU/app'
alias nnur='cd ~/work/NNU/webgui_rfu'
alias nnum='cd ~/work/NNU/webgui'
alias mnnu='screen -S nnu' # mask nnu screen
alias annu='screen -r nnu' # attach nnu screen
alias annu2='screen -r nnu2' # attach nnu screen
alias annu3='screen -r nnu3' # attach nnu screen
alias annu4='screen -r nnu4' # attach nnu screen
alias annu5='screen -r nnu5' # attach nnu screen
alias dnnu='screen -d nnu' # detach nnu screen
alias msnnu='screen -x nnu' # multi screen nnu
alias slist='screen -list'
alias cpap='cp ~/NNU/out/app-mu/root/rpt_app /tftpboot/'
alias cppkg='cp ~/NNU/out/mu_ap.pkg /tftpboot/mu'
alias cpsru='cp -f ~/work/ORAN/d-oran/out/sru_ap.pkg /tftpboot/sru/'
alias cpsru2='cp -f ~/work/ORAN/d-oran2/out/sru_ap.pkg /tftpboot/sru/'
alias cprru='cp -f ~/work/ORAN/d-oran/out/rru_ap.pkg /tftpboot/rru/'
alias cprru2='cp -f ~/work/ORAN/d-oran2/out/rru_ap.pkg /tftpboot/rru/'
alias cpoiu='cp -f ~/work/ORAN/d-oran/out/oiu_ap.pkg /tftpboot/oiu/'
alias cpoiu2='cp -f ~/work/ORAN/d-oran2/out/oiu_ap.pkg /tftpboot/oiu/'
alias cpos='cp ~/NNU/out/mu_os.pkg /tftpboot/mu'
alias oran='cd ~/work/ORAN/d-oran'
alias oran2='cd ~/work/ORAN/d-oran2'
alias mp='cd ~/work/ORAN/sru_bsp/m-plane'

alias _cdp='cd /kang39/project'
alias _cdo='cd /home/kang39/work/ORAN/d-oran/app'
alias _cdv='cd /kang39/work/ORAN/vvdn-oran/smjk_lshd/yang-models/ORAN-WG4.MP-YANGs-v02.00'
alias _cdob='cd /home/kang39/work/ORAN/sru_bsp'
alias cdaarch='cd /opt/tools/Xilinx/Vitis/2019.2/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/usr/include/bits'
alias cprepo='cd ~/work/ORAN/d-oran/libs/m-plane;cp -f ~/work/ORAN/sru_bsp/m-plane/out/mplane-lib.tar.gz .; tar -zxvf mplane-lib.tar.gz;rm -f ./mplane-lib.tar.gz;cd -'
alias getslab='scp kang39@192.168.30.123:~/work_kang39/d-oran/slab/output/binaries/* ~/ORAN/d-oran/slab_timing_driver/rootfs/usr/bin'
alias cdmp='cd /home/kang39/work/ORAN/sru_bsp/m-plane'
alias cdsysroot='cd /home/kang39/work/ORAN/sru_bsp/images/linux/sdk/sysroots/aarch64-xilinx-linux'
alias cdbsp='cd /home/kang39/work/ORAN/sru_bsp'
alias cdopt='cd libs/m-plane/aarch64/rootfs/opt'

alias gitdiff='git diff --color-words'          # move to femto
alias gitst='git status'
alias gitco='git checkout'
alias gitcp='git cherry-pick'
alias gg='git grep -n'
alias gl='git log --oneline --graph'
alias gclean='git clean -xdf'
#cd ../libs/m-plane;tar -zxvf mplane-lib.tar.gz;\
alias cm='rm -f \
../libs/m-plane/mplane-lib.tar.gz;\
cp out/mplane-lib.tar.gz  ../libs/m-plane; \
cd ../libs/m-plane;./update.sh ; cd -'
alias cpslab='rm -f ../slab_timing_driver/rootfs/usr/bin/*; \
cp -f output/binaries/* \
../slab_timing_driver/rootfs/usr/bin/'
alias cpsync='rm -f ../sync_timing_driver/rootfs/usr/bin/*; \
cp -f output/binaries/* \
../sync_timing_driver/rootfs/usr/bin/'
alias slab='cd ~/work/ORAN/sru_bsp/slab'

alias fn='find . -name'
alias gitb='git branch -a'
alias gitst='git status'
alias gitlo='git log --stat'
alias gitloa='git log --stat --author=kang39'
alias gitdi='git diff'
#alias g='grep -rnH --exclude=cscope.out --exclude=tags --exclude=*.cgi'
alias gbrm='git remote prune origin'
alias makeslab='SLAB_TIMING_PETALINUX_BUILD=yes .
slab_timing_driver_env.sh;/home/kang39/work/ORAN/sru_bsp/images/linux/sdk/environment-setup-aarch64-xilinx-linux'

#NNU CRF-6002(MU)
alias _nnud='cd ~/project/NNU;devenv'
alias _cdn='cd ~/project/NNU/app'
alias _cdnwr='cd ~/project/NNU/webgui_rfu'
alias _cdnwm='cd ~/project/NNU/webgui'

#NNU CRF-6002(RFU)
alias nnurd='cd ~/project/NNU_RFU;devenv'

#DKK O-RAN
alias _cdo='cd ~/project/ORAN/d-oran/app'
alias _cdv='cd ~/project/ORAN/vvdn-oran/smjk_lshd/yang-models/ORAN-WG4.MP-YANGs-v02.00'
alias _cdob='cd ~/project/ORAN/sru_bsp'
alias _cdow='cd ~/project/ORAN/oran_webui'

#UQ DAS
alias _uqd='cd ~/project/UQ_DAS/uq_das_app;devenv'
alias _cdu='cd ~/project/UQ_DAS/uq_das_app/app'
alias _cduw='cd ~/project/UQ_DAS/uq_das_webui'
alias _cdub='cd ~/project/UQ_DAS/uq_das_bsp'

#JTOWER
alias _cdj='cd ~/project/JTOWER/app'

#N-DAS
alias _cdnd='cd ~/project/N_DAS/n_das_app/app'
alias _cdndw='cd ~/project/N_DAS/n_das_webui'
alias _cdndb='cd ~/project/N_DAS/n_das_bsp'

#Nokia Global
alias _cdngw='cd ~/project/Nokia_Global/nokia_global_webui'

alias _cds='cd ~/project/S_CAD/app'
alias 2019.1='. /opt/petalinux/2019.1/settings.sh'
alias mksync='make all SYNC_TIMING_PKG_FILE=sj.mk'
alias cleansync='make clean SYNC_TIMING_PKG_FILE=sj.mk'

alias fn='find . -name'
alias gitb='git branch -a'
alias gitst='git status'
alias gitlo='git log --stat --graph'
alias gitloa='git log --stat --author=yulgom'
alias gitdi='git diff'
alias gitde='git describe --tags --dirty --long'
alias gitlog='git log --graph --all -n20 --oneline'
alias g='grep -rnH --exclude=cscope.out --exclude=tags --exclude=*.cgi --exclude=*.js --exclude=*.map --exclude=*.php --exclude=rpt_app --exclude="*.o" --exclude-dir=out'
# Local Variables:
# mode:shell-script
# sh-shell:bash
# End:













