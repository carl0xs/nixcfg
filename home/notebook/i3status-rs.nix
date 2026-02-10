{ ... }:

{
  home.file.".config/i3status-rust/config.toml".text = ''
    			icons_format = "{icon}"

    			[theme]
    			theme = "gruvbox-dark"
    			[theme.overrides]

    			[icons]
    			icons = "material-nf"
    			[icons.overrides]
    			bat = ["|E|", "|_|", "|=|", "|F|"]
    			bat_charging = "|^| "

    			[[block]]
    			block = "custom"
    			command = "cat /etc/hostname"
    			interval = "once"

    			[[block]]
    			block = "custom"
    			command = "whoami"
    			interval = "once"

    			[[block]]
    			block = "custom"
    			command = "hostname -I | awk '{print $1}'"
    			interval = "once"

    			[[block]]
    			block = "cpu"
    			info_cpu = 20
    			warning_cpu = 50
    			critical_cpu = 90

    			[[block]]
    			block = "custom"
    			command = "curl -s 'https://wttr.in/?format=1' | grep -oE '.+ [+-]?[0-9]+°C' | sed 's/ +/ /'"
    			interval = 600

    			[[block]]
    			block = "disk_space"
    			path = "/"
    			info_type = "available"
    			alert_unit = "GB"
    			interval = 20
    			warning = 20.0
    			alert = 10.0
    			format = " $icon root: $available.eng(w:2) "

    			[[block]]
    			block = "memory"
    			format = " $icon $mem_total_used_percents.eng(w:2) "
    			format_alt = " $icon_swap $swap_used_percents.eng(w:2) "

    			[[block]]
    			block = "sound"
    			[[block.click]]
    			button = "left"
    			cmd = "pavucontrol"

    			[[block]]
    			block = "time"
    			interval = 5
    			format = " $timestamp.datetime(f:'%a %d/%m %R') "
  '';
}
