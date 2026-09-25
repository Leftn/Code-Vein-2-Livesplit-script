state("CodeVein2-Win64-Shipping")
{
}

state("CodeVein2-Win64-Shipping", "1.0.2.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09E70870, 0x8, 0x8, 0x1E8, 0xE0, 0x148, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "1.0.3.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09E6C870, 0x8, 0x8, 0x1E8, 0xE0, 0x148, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "1.0.5.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09E84CA8, 0x8, 0x8, 0x1E8, 0xE0, 0x148, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "1.0.6.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09E8CDC0, 0x8, 0x8, 0x1E8, 0xE0, 0x148, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "1.0.7.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09EAC048, 0x8, 0x8, 0x218, 0xE0, 0x148, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "1.0.9.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x09EAC1C0, 0x8, 0x8, 0x218, 0xE0, 0x148, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "2.0.1.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x0A1B6C98, 0x8, 0x8, 0x260, 0xE0, 0x160, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "2.0.2.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x0A1B9CA0, 0x8, 0x8, 0x260, 0xE0, 0x160, 0x68, 0x41;
}

state("CodeVein2-Win64-Shipping", "2.0.3.0")
{
	byte inGameLoading : "CodeVein2-Win64-Shipping.exe", 0x0A1C9CA0, 0x8, 0x8, 0x260, 0xE0, 0x160, 0x68, 0x41;
}

exit
{
	// Pause Game Time if the game closes or crashes.
	timer.IsGameTimePaused = true;
}

init
{
	version = "";

	using (var md5 = System.Security.Cryptography.MD5.Create())
	using (var fs = System.IO.File.OpenRead(modules.First().FileName)) {
		var hash = string.Concat(md5.ComputeHash(fs).Select(b => b.ToString("X2")));

		if (hash == "AED1E2455C9978BC986DC8DD2FB8FDF6") {
			version = "1.0.2.0";
		} else if (hash == "F55ABDC919FCC87208674C5E78F33E02") {
			version = "1.0.3.0";
		} else if (hash == "A68382E1A308443C9B807FB3E803DF93") {
			version = "1.0.5.0";
		} else if (hash == "24F801822281A01AE7634C8D21128B1E") {
			version = "1.0.6.0";
		} else if (hash == "C01534CEE9E893CA1237FB24E95A55F4") {
			version = "1.0.7.0";
		} else if (hash == "A3C395779465AC4009796ED0964942D7") {
			version = "1.0.9.0";
		} else if (hash == "E9BC16005E960B49EDF82C88853F4C75") {
			version = "2.0.1.0";
		} else if (hash == "2E8999C26D26F1B7B9FFCDA0986F44CB") {
			version = "2.0.2.0";
		} else if (hash == "C904F7B7F771AE6C14AD5288EDACBFD5")
		{
			version = "2.0.3.0";
		}
	}

	vars.isLoading = false;
}

update
{
	if (version == "")
	{
		return false;
	}

	vars.isLoading = current.inGameLoading == 1;
}

isLoading
{
	return vars.isLoading;
}
