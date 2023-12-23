# gsh

Gambas 3.18 is now available as a backport for debian and ubuntu, even available for Raspberry OS!
```
  for pi os:
  Add this line to the beginning of /etc/apt/sources.list
  deb http://deb.debian.org/debian/ bullseye-backports main contrib non-free

  install like this debian all os and pi os :
  apt -t bullseye-backports install gambas3
```
## Update - Ubuntu/Debian installation packages available to add to apt source list

```
sudo -i
curl -s --compressed "https://raw.githubusercontent.com/justlostintime/ppa/main/ubuntu/KEY.gpg" | gpg --dearmor > /etc/apt/trusted.gpg.d/westwood-archive-key.gpg
sudo curl -s --compressed -o /etc/apt/sources.list.d/gsh.list "https://raw.githubusercontent.com/justlostintime/ppa/main/ubuntu/gsh.list"
sudo apt update
```

### NOTE GSH UPDATE FOR GAMBAS 3.18 and above 03/30/2023
Current gsh version is now 1.4.2
Updated to new byte code for gambas3
Many bug fixes and extensions

### NOTE GSH UPDATE FOR GAMBAS 3.17 and above 04/10/2022
Version 1.3.106 or above is required for correct functionallity in 
Gambas version 3.17 or above.

### Documentation
[Gambas Shell Documentation](https://github.com/justlostintime/GambasShell/wiki)

### Whats New
[What new with this release](https://github.com/justlostintime/GambasShell/wiki/What's-New)

### Moved to version 1.3 Many bug fixes and enhancements

### Note the release dated 12-27-2020 was a complete mess as far as redirections went. Please update as soon as possible
