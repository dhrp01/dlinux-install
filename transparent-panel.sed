/"tooltip": "Only for supported themes. Let the theme style the panels instead of using the extension presets. Use this in case the panels transparency is icorrectly set.",/ {
	p;n;
	/"value": false/ {
		s/"value": false/"value": true/1;
		p;d;
		}
}
/"tooltip": "View applications as list or grid",/ {
	p;n;
	/"value": 0/ {
		s/"value": 0/"value": 1/1;
		p;d;
		}
}
/"tooltip": "Use a custom icon in the panel",/{
	p;n;
	/"value": false/ {
	s/"value": false/"value": true/1;
	p;d;
	}
}
/"tooltip": "Panel icon",/{
	p;n;
	/"value": .*/ {
		s/"value": .*/"value": "start-here-debian"/1;
	p;d;
	}
}
/"tooltip": "Choose where to show the sidebar",/{
	p;n;
	/"value": .*/ {
		s/"value": .*/"value": 0/1;
	p;d;
	}
}
/"tooltip": "Check this to define a custom format for the date in the calendar applet.",/{
	p;n;
	/"value": false/ {
		s/"value": false/"value": true/1;
	p;d;
	}
}
/"tooltip": "Set your custom format here.",/{
	p;n;
	/"value": .*/ {
		s/"value": .*/"value": "%B %e, %H:%M"/1;
	p;d;
	}
}
p;
