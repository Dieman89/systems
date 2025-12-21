_:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      # Apply 1Password SSH agent to all hosts
      "*" = {
        extraOptions = {
          IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
          AddKeysToAgent = "yes";
        };
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };

      # GitHub
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
      };

      # GitLab
      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identitiesOnly = true;
      };
    };
  };
}
