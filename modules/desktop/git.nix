{
  programs.git = {
    enable = true;
    settings = {
      user.email = "ch.henriquevinha@gmail.com";
      user.name = "Carlos Henrique"; 

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        st = "status --short";
      };

      color.ui = true;
      core.editor = "nvim";
      pull.rebase = true;
      push.default = "current";
      rerere.enabled = true;
    };
  };
}
