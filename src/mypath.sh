__silent_echo() {
    if [ -z "$__xana_silent" ]; then
        echo "$@"
    fi
}

__export_path() {
  if [ -z "$1" ]; then 
    __silent_echo "no path";
    return
  fi

  if ! [ -d "$1" ]; then
    # missing, do nothing
    return
  fi

  case ":${PATH}:" in
    *:"$1":*)
        __silent_echo "already supports $1"
        ;;
    *)
        __silent_echo "supports $1"
        export PATH="$PATH:$1"
        ;;
  esac
}

# tmsu?
# export PATH="$PATH:/mnt/bin/linux/bin"

__export_path "/opt/AMDuProf_5.0-1479/bin/"
__export_path "$HOME/bin/go/bin"

if [ -f "$HOME/.cargo/env" ]; then
  __silent_echo "adding cargo"
  . "$HOME/.cargo/env"
fi

unset __export_path
unset __silent_echo
