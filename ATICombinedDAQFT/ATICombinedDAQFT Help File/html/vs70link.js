// version 8952

writeCSS(scriptPath());

function scriptPath()
{
	var col = document.scripts;
	return col[col.length - 1].src;
}

function writeCSS(spath)
{
	var css = "";
	var hxlinkPath = "";
	var hxlink = "";
	var hxlinkdefault = "";
	// Get a CSS name based on the browser.
	if (navigator.appName == "Microsoft Internet Explorer") {
		var sVer = navigator.appVersion;
		sVer = sVer.substring(0, sVer.indexOf("."));
		if (sVer >= 4) {
			document.writeln('<SCRIPT FOR="reftip" EVENT=onclick>window.event.cancelBubble = true;</SCRIPT>');
			document.writeln('<SCRIPT FOR="cmd_lang" EVENT=onclick>langClick(this);</SCRIPT>');
			document.writeln('<SCRIPT FOR="cmd_filter" EVENT=onclick>filterClick(this);</SCRIPT>');

			css = "vs70_5.css";
			hxlinkPath = "ms-help://Hx/HxRuntime/"
			hxlink = "HxLink.css";
			hxlinkdefault = "HxLinkDefault.css";
		}
		else
			css = "vs70_5.css";
			hxlinkPath = "ms-help://Hx/HxRuntime/"
			hxlink = "HxLink.css";
			hxlinkdefault = "HxLinkDefault.css";
	}

	// Insert CSS calls
	spath = spath.toLowerCase();
	spath = spath.replace(/vs70link.js/, "");
	// Insert the Alink CSS
	document.writeln('<LINK REL="stylesheet" HREF="' + hxlinkPath + hxlink + '">');
	// The CSS is in the same directory as the script.
	document.writeln('<LINK REL="stylesheet" HREF="' + spath + css + '">');
	document.writeln('<LINK REL="stylesheet" HREF="' + spath + hxlinkdefault + '">');
}

