if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init --cmd j fish | source
end

# opam configuration
source /home/ntpt/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
