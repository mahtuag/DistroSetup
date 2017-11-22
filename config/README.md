# Config Files

These are global config files I need to recreate with each install.

## mimeapps.list

To install, run:

```bash
mkdir -p $HOME/.local/share/applications
cp mimeapps.list $HOME/.local/share/applications
```

This would make sure that only Leafpad is used to view all text files (otherwise
a bulky editor/viewer like Atom, VSCode or Calibre may open the file.

This would also make sure that vlc is used to play all media files.

### How this was generated

https://lkubaski.wordpress.com/2012/10/29/understanding-file-associations-in-lxde-and-pcmanfm/
has been a super useful resource in understanding how file associations work.

If all you need is to change the default application used to open media files
when you double click them, and do that on a user level, the file you need to
edit is `$HOME/.local/share/applications/mimeapps.list`.

https://askubuntu.com/questions/289686/change-xubuntus-default-text-editor-globally
was useful to give me mimeapps.list associations for text files.

For audio/video files to be opened by VLC, I generated this file using the
global version located at `/usr/share/applications/mimeapps.list`.

```bash
printf "[Default Applications]\n" > $HOME/.local/share/applications/mimeapps.list
cat /usr/share/applications/mimeapps.list \
| grep -P "(audio|video)" \
| cut -d "=" -f1 \
| sed -e 's/$/=vlc.desktop;/' \
>> $HOME/.local/share/applications/mimeapps.list
```

#### Steps explained (for reference)

1. Create the `[Default Applications]` section in the first line of the local
   `$HOME/.local/share/applications/mimeapps.list` after erasing the file's
   contents (I can do this safely because I have a blank file; if you don't,
   alter the steps accordingly).
2. Output contents of `/usr/share/applications/mimeapps.list`
3. Send previous output through grep and look for lines containing audio or
   video (since these are the mime associations we'll set to VLC).
4. Take output of grep and cut lines with `=` as the delimiter and print the
   first word (which is only the mime type).
5. Send the output of cut through stream editor (sed) and append `=vlc.desktop;`
   to each line to complete the entry.
6. Take the final output from sed and append to the newly created
   `$HOME/.local/share/applications/mimeapps.list`.

## 51-android.rules

Used for connecting to Android. Copy to `/etc/udev/rules.d/51-android.rules`.

