alias g="grep -ri"

#SOURCE COMPLETION FUNCTIONS
source ~/.bash_completion.d/*

# GIT
alias gs="git status"
alias gb="git branch"
alias sc="aa; gc 'style change'"
alias scd="aa; gc 'style change [d:staging]'; pm;"
alias tc="dh-push 'text change'"
alias tcd="dh-push 'text change [d:staging]'"
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias pm="git push origin master"
alias gpm="gp master"
alias aa="git add -A ."

p() {
    git push origin "$1"
}
gp() {
    git pull origin "$1"
}
gc() {
	git commit -m "$1"
}

#DRUPAL
alias hm="cd ~/sites"
alias c="clear"
alias cc="drush cc all"
alias ccc="cc; c"
alias dm=dm
dm(){
	drush dl $1; 
	drush en -y $1;
}

cwatch(){
	compass watch ~/sites/$1/sites/default/themes/$2/
}

#NAVIGATION

#home of site or your home
h() {
	match=`pwd | grep "sites"`
	if [ -z $match ]; then
		echo "change back to home"
	else
		#IFS='/' read -ra path <<< "$match"
		path=(${match//\// })
		count=${#path[@]}
		index=0
		while [ "$index" -lt "$count" ]; do
			if [ ${path[$index]} = "sites" ]; then
				cd ~/sites/${path[$index+1]}
				break
			fi	
			let "index++"
		done
	fi
	
}


#change to any site folder
s() {
	cd ~/sites/$1
}

# go back x directories
b() {
	str=""
	count=0
	while [ "$count" -lt "$1" ];
	do
		str=$str"../"
		let count=count+1
	done
	cd $str
}

#SASS FUNCS
# Clean and compile sass - looks for any compass rb in child folders

function cb() {
        MATCHES=`find -name config.rb | grep '/sites/default' | sed 's/\/config.rb//'`
        echo "Found ${#MATCHES[*]} theme(s)."
        for THEME in "${MATCHES[@]}"
        do
                echo "Theme: $THEME"
                if [ "$1" == "c" ]
                then
                        compass clean $THEME
                fi
                compass compile $THEME
        done
}

#GREP
#find text in any file
#usage ft "my string" *.txt
ft() {
	find . -name "$2" -exec grep -il "$1" {} \;
}

alias mcc="rm -rf var/cache/*; rm -rf var/full_page_cache/*"

#Drupal

function dmod {
        mkdir $1;
        cd $1;
        echo "<?php" > $1.module;
        echo -e "name = \ndescription = \nversion = 7.x-1.x\ncore = 7.x\npackage =" > $1.info;
}

#Count css
function csscount {
    cnt=0
    depth=0
    while read -n 1 char; do
            case $char in
                    "{")
                            ((depth++))
                            ;;
                    "}")
                            ((depth--))
                            if [ "$depth" -eq "0" ]; then
                                    ((cnt++))
                            fi
                            ;;
                    ",")
                            ((cnt++))
                            ;;
            esac
    done
 
    echo $cnt
}
alias cc='drush cc'
alias en='drush en'
alias dl='drush dl'
alias dis='drush dis'

csscount() {
    cnt=0
    depth=0
    while read -n 1 char; do
            case $char in
                    "{")
                            ((depth++))
                            ;;
                    "}")
                            ((depth--))
                            if [ "$depth" -eq "0" ]; then
                                    ((cnt++))
                            fi
                            ;;
                    ",")
                            ((cnt++))
                            ;;
            esac
    done

    echo $cnt
}


# node

alias npm-exec='PATH=$(npm bin):$PATH'
