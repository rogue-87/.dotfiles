alias vim nvim
alias virk "NVIM_APPNAME=virk nvim"
alias viweb "NVIM_APPNAME=viweb nvim"

function vims
   set items nvim virk viweb
   set config $(printf "%s\n" $items | fzf --prompt=" Neovim Config >> " --height=~50% --layout=reverse --border --exit-0)
   if test (count $config) -eq 0
      printf "Nothing selected"
      return 0
   else if test $config = "nvim"
      set config ""
   end
   env NVIM_APPNAME=$config nvim $argv
end
