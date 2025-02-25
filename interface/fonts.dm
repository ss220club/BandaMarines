/// A font datum, it exists to define a custom font to use in a span style later.
/datum/font
	/// Font name, just so people know what to put in their span style.
	var/name
	/// The font file we link to.
	var/font_family

/datum/font/vcr_osd_mono
	name = "VCR OSD Mono"
	font_family = 'interface/Grand9K_Pixel_Rus.ttf' // VCR_OSD_Mono.ttf' // SS220 EDIT - Cyrillic fixes

// SS220 ADDITION - new fonts
/datum/font/pixcyrillic
	name = "Pix Cyrillic"
	font_family = 'interface/PixCyrillic.ttf'

/datum/font/spessfont
	name = "Spess Font"
	font_family = 'interface/SpessFontRus.ttf'

/datum/font/tiny_unicode
	name = "TinyUnicode"
	font_family = 'interface/TinyUnicodeRus.ttf'
