import "pe"

rule pe32{
    meta:
        description = "PE File"
        date = "2019-01-05"
	strings:
		$mz = "MZ"
	condition:
		pe.characteristics and $mz at 0 and uint32(uint32(0x3C)) == 0x00004550

}

rule upx{
    meta:
        description = "UPX packed file"
        date = "2019-01-05"
	strings:
		$upx = "upX" wide ascii
		$upx0 = "UPX0" wide ascii
		$upx1 = "UPX1" wide ascii
		$upx2 = "UPX2" wide ascii
		$upxx = "UPX!" wide ascii

	condition:
		pe32 and (1 of ($upx0, $upx1, $upx2)) or ($upxx or $upx)
}

rule aspack{
    meta:
        description = "ASPack packed file"
        date = "2019-01-22"
    strings:
        $aspack = ".aspack"
        $asdata = ".adata"
    condition:
        pe32 and $aspack and $asdata
}

rule fsg{
    meta:
        description = "FSG packed file"
        date = "2019-01-22"
    strings:
        $ep1 = { BB D0 01 40 ?? BF ?? 10 40 ?? BE }
        $ep2 = { EB 01 ?? EB 02 ?? ?? ?? 80 ?? ?? 00 }
        $ep3 = { BB D0 01 40 ?? BF ?? 10 40 ?? BE }
        $ep4 = { EB 01 ?? EB 02 ?? ?? ?? 80 ?? ?? 00 }
        $ep5 = { BE ?? ?? ?? 00 BF ?? ?? ?? 00 BB ?? ?? ?? 00 53 BB ?? ?? ?? 00 B2 80 }
        $ep6 = { EB 02 CD 20 03 ?? 8D ?? 80 ?? ?? 00 ?? ?? ?? ?? ?? ?? ?? ?? ?? EB 02 }
        $ep7 = { EB 02 CD 20 ?? CF ?? ?? 80 ?? ?? 00 ?? ?? ?? ?? ?? ?? ?? ?? 00 }
        $ep8 = { 87 25 ?? ?? ?? ?? 61 94 55 A4 B6 80 FF 13 }
        $ep9 = { 01 00 4E 33 01 10 02 00 00 60 01 00 00 04 00 00 00 32 01 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 40}

    condition:
        pe32 and (any of ($ep*))
}

rule pecompact{
    meta:
        description = "PECompact packed file"
        date = "2019-01-22"
    strings:
        $pec1 = {70656331}
        $pec2 = {70656332}
    condition:
        pe32 and $pec1 at 0x01c8 and $pec2 at 0x01f0
}

rule upack{
    meta:
        description = "Upack packed file"
        date = "2019-01-22"
    strings:
        $ep = {0B 01 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? 18 10 00 00 10 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? 00 10 00 00 00 02 00 00}
	condition:
	    pe32 and $ep
}

rule petite{
    meta:
        description = "PEtite packed file"
        date = "2019-01-16"
    strings:
        $petite = ".petite"
    condition:
        pe32 and $petite
}

rule mew{
    meta:
        description = "MEW packed file"
        date = "2019-01-25"
    strings:
        $mew = "MEW"
    condition:
        pe32 and $mew
}


rule yzpack{
    meta:
        description = "YZPack packed file"
        date = "2019-02-28"
    strings:
        $yz = ".yzpack"
    condition:
        pe32 and $yz
}