# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

## http://www.tldp.org/LDP/abs/html/intandnonint.html
if [ "$PS1" ]; then
    # echo We are in an interactive shell
    for FILE in ~/.bashrc_config \
                ~/.bashrc_prompt \
                ~/.bashrc_functions \
                ~/.bashrc_alias
    do
        if [ -f $FILE ]; then . $FILE; fi;
    done;

    for FILE in \
        /etc/bash_completion \
        ~/.bash_completion \
        /etc/bash_completion.d/git-completion.bash \
        /usr/local/etc/bash_completion.d/git-completion.bash;
    do
        if [ -f $FILE ]; then . $FILE; fi;
    done;

	if [ -x /usr/bin/fortune ]; then
        echo; /usr/bin/fortune; echo
	fi
    if [ -x /usr/bin/ddate ]; then
        echo; /usr/bin/ddate; echo
    fi
    #if [ "$TERM" != "screen" ]; then
    #    #updatedb > /dev/null &
    #    /usr/bin/screen development
    #fi
fi
