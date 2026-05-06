state("CodeVein2-Win64-Shipping")
{
}

state("CodeVein2-Win64-Shipping", "1.0.3.0")
{
	bool inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09E45C58, 0x8, 0x7DC;
	bool menuLoading : "CodeVein2-Win64-Shipping.exe", 0x0A062530, 0x70, 0x340, 0x58, 0xC0, 0x8, 0x2BC;
}

state("CodeVein2-Win64-Shipping", "1.0.9.0")
{
	bool inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x9EAC1C0, 0x8, 0x8, 0x20, 0x88;
	bool menuLoading : "CodeVein2-Win64-Shipping.exe", 0x09FFB918, 0xA0, 0x2B8, 0x18, 0x0, 0x18;
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
	
	using (var md5 = System.Security.Cryptography.MD5.Create())
	    using (var fs = System.IO.File.OpenRead(modules.First().FileName)) {
        var hash = string.Concat(md5.ComputeHash(fs).Select(b => b.ToString("X2")));
        if (hash == "A3C395779465AC4009796ED0964942D7") version = "1.0.9.0";
        if (hash == "F55ABDC919FCC87208674C5E78F33E02") version = "1.0.3.0";
        else version = "1.0.3.0";
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
 
