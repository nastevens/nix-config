{ ... }:

{
  programs.cmus = {
    enable = true;
    extraConfig = ''
      set follow=true
      set format_trackwin=%4n. %t%= %d 
      set format_trackwin_va=%4n. %t (%a)%= %d 
      set resume=true
    '';
  };
}
