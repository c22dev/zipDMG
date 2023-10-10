# zipDMG
ZIP your DMG if you're not able to mount it on your local machine.

## Automatic build
https://zipdmg.c22code.repl.co

## How to make this work on my side? Experimental
1. Fork this repo using your own github account (public).
2. Go to Actions tab
3. Create new blank action
4. Copy the content from [this page](https://raw.githubusercontent.com/c22dev/zipDMG/main/.github/workflows/blank.yml) and paste it in your blank file
5. Save (commit)
6. Go into mount.sh file and edit it
7. Replace the template URL with your dmg link (you can self host it on DropBox and replace the 0 by a 1 at the end of the share link).
8. Commit with the name of your choice (keep it in mind)
9. Go in actions tab
10. Click on the section contanining the name of your choice
11. Wait for it to complete (refresh it to the point it's a green tick)
12. Download the zipped file on your computer and enjoy the .app

If you had a red cross, check the DMG link/file or/and try self hosting it.

If you have an issue, open the issue on this github (not your fork)

Feel free to delete your fork after work, and star the repo !
