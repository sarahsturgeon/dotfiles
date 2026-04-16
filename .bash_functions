## BEGIN CUSTOM FUNCTIONS ##

# Easy Ubuntu Launcher position controls

# Tree
function tree {
    ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}

# Update all scripts in script directory
function update_scripts {
    for script in $SCRIPTS; do
        git -C $SCRIPTS_DIR/$script pull origin master;
    done
}

# convert $1 -sampling-factor 4:2:0 -strip -interlace JPEG discord2.jpg
function jpg_convert {
    convert $1 -sampling-factor 4:2:0 -strip -interlace JPEG $(python -c "print '$1'.split('.')[0]+'2.jpg'");
}

#function dim_screen {
#    for i in `seq 1 $1`;  osascript $SCRIPTS_DIR/dim-screen.script
#}
#
#function brighten_screen {
#    for i in `seq 1 $1`;  osascript $SCRIPTS_DIR/brighten-screen.script
#}

# Uses python's json library to load, then re-dump the json from a file in a formatted style
function python_pp {
    python3 -c "import json;
with open('$1', 'r') as json_file: print(json.dumps(json.load(json_file), indent=4, sort_keys=True))"
}

# Uses the python_pp command with less wrapped around it
function pp {
    python_pp $1 | less -R
}

# Uses the python_pp command with grep wrapped around it
function ppgrep {
    python_pp $1 | grep --color=auto -n -A 3 -B 2 --color=always $2 | less -R
}

function f {
    if command -v fd >/dev/null 2>&1; then
        fd "$1"
    ele
        find . -iname "*$1*"
    fi
}

if [[ "$IS_MAC" == true ]]; then
    function copy {
        pbcopy < $1
    }

    function dump {
        pbpaste > $1
    }
fi

## END CUSTOM FUNCTIONS ##

