﻿##########################################
# CleanTV - Cleans TV shows directory v1.0
# Author: BK
# Date: 12/21/2016
##########################################

# Deletes all videos in directory recursively
get-childitem "C:\Users\Public\Recorded TV" -include *.mkv -recurse | foreach ($_) {remove-item $_.fullname}
get-childitem "C:\Users\Public\Recorded TV" -include *.mp4 -recurse | foreach ($_) {remove-item $_.fullname}
get-childitem "C:\Users\Public\Recorded TV" -include *.avi -recurse | foreach ($_) {remove-item $_.fullname}
get-childitem "C:\Users\Public\Recorded TV" -include *.mov -recurse | foreach ($_) {remove-item $_.fullname}
get-childitem "C:\Users\Public\Recorded TV" -include *.wmv -recurse | foreach ($_) {remove-item $_.fullname}

# Get rid of any possible executables
get-childitem "C:\Users\Public\Recorded TV" -include *.exe -recurse | foreach ($_) {remove-item $_.fullname}

# Deletes all video .nfo's in directory recursively
get-childitem "C:\Users\Public\Recorded TV" -include *.nfo -exclude tvshow.nfo -recurse | foreach ($_) {remove-item $_.fullname}

# Deletes all video .jpg's in directory recursively
get-childitem "C:\Users\Public\Recorded TV" -include *.jpg -exclude banner.jpg,fanart.jpg,folder.jpg,poster.jpg,season*poster.jpg,season-specials-poster.jpg,season*banner.jpg -recurse | foreach ($_) {remove-item $_.fullname}

