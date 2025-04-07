{ flake, ... }:

let
  me = flake.config.me;
in
{
  users.users.${me.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKxVfeh+zYTcMfUbzTHaFyqorD0ODcdKehTJpUH5eQr bakugo-20210502"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7U1kF0BA+5OOe8Xw2E9aEK+UVfxloLjRLQhh69uKsf lain-20210502"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQhKRLdPbO7wXpUKkskEoeZMxjcv3STbTU5RARaSBsA notnotlinux-20240206"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICwGdcQPc0hojenC3ZQW+4sLALGpJpw91F/h1bv/r3hi fern-20250203"

    # Inactive keys that I might use again
    #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEkQY+0M/FaMRqOlilm/YrjFNqskJ5umtRhrBVKB5MuO samsung-sm-x200-connectbot-20240613"
    #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXYe9Zo078ay3wTyfJDAfvYt6ut6cHRj7UykZRoaGWw samsung-sm-x200-termius20240613"
    #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPpAOnlrWsvVjeDXjC0WzOgGHu5h7n0dAYE5I/gm835M nick@minion22"
    #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMBMuY5XC1n85RDO4huZEMdAyV0Cihy+qRJB/oOLo5UN nick@minion18"
  ];
}
