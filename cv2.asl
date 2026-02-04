state("CodeVein2-Win64-Shipping")
{
}

state("CodeVein2-Win64-Shipping", "5.4.4.0")
{
	bool inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09E45C58, 0x8, 0x7DC;
	bool menuLoading : "CodeVein2-Win64-Shipping.exe", 0x0A062530, 0x70, 0x340, 0x58, 0xC0, 0x8, 0x2BC;
}


init
{
	string[] versions = {"5.4.4.0"};

	FileVersionInfo fvi = modules.First().FileVersionInfo;
	string fileVersion = String.Format("{0}.{1}.{2}.{3}",
		fvi.FileMajorPart,
		fvi.FileMinorPart,
		fvi.FileBuildPart,
		fvi.FilePrivatePart);

	if (Array.IndexOf(versions, fileVersion) >= 0) {
		version = fileVersion;
	} else {
		version = "";
	}

	vars.isLoading = false;
}

update
{

	if (version == "") {
		return false;
	}

	// Load Time Removal ---
	vars.isLoading = current.inGameLoading || current.menuLoading;

}

isLoading
{
	return vars.isLoading;
}
