on AppleScriptDateToString(b)
	set Y to year of b
	set M to Twodigits(month of b as integer)
	set D to Twodigits(day of b)
	set hh to Twodigits(hours of b)
	set mm to Twodigits(minutes of b)
	set ss to Twodigits(seconds of b)
	return Y & "-" & M & "-" & D & " " & hh & ":" & mm & ":" & ss as text
end AppleScriptDateToString

on Twodigits(a)
	return (characters -2 thru -1 of (("0" & a) as text)) as text
end Twodigits

on run
	set theFile to open for access (choose file name) with write permission
	tell application "Photos"
		set theDates to date of media items
		set theoutputString to ""
		repeat with theDate in theDates
			set t to my AppleScriptDateToString(theDate) & "
"
			--log t
			set theoutputString to theoutputString & t
		end repeat
		write theoutputString to theFile
	end tell
	close access theFile
end run
on open dateien
	set datei to item 1 of dateien
	set alredyThereDates to paragraphs of (read file datei)
	tell application "Photos"
		set exAlbum to item 1 of (albums whose name is "Nicht teilen")
		set excludeIds to id of (media items of exAlbum)
		set theDates to date of media items
		set theIds to id of media items
		set theCounter to 0
		set theAlbum to make new album named "Evtl. teilen"
		repeat with theId in theIds
			set theCounter to theCounter + 1
			if excludeIds does not contain theId then
				set theDate to item theCounter of theDates
				set t to my AppleScriptDateToString(theDate)
				if alredyThereDates does not contain t then
					add {item theCounter of media items} to theAlbum
					log "add"
				else
					log "already there"
				end if
			else
				log "excluded"
			end if
		end repeat
	end tell
end open
