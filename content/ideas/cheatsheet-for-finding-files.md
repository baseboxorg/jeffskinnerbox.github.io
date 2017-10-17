# find
https://www.computerhope.com/unix/ufind.htm

```bash
# find files with name under current directory
find . -name file

# find file with the string "step" in them
find . -type f -name "*step*"

# find all exwecutable files under current directory
find . -perm /a=x
```

```bash
# recursively search a directory, looking for a "pattern" within files which have .c or .h extensions
grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"

grep -Ril "text-to-find-here" .
```

# locate
https://www.computerhope.com/unix/ulocate.htm

# whereis
https://www.computerhope.com/unix/uwhereis.htm

# which
https://www.computerhope.com/unix/uwhich.htm


# Change Owner or Group

```bash
# change owner and group of all files in current directory and sub-directory
find . -user old-user -exec chown new-user:new-group {} \;

# change owner and group of all files with specifc name in current directory and sub-directory
find . -iname '*.html' -user www-data -exec chown www-data:www-data {} \;
```




* [35 Practical Examples of Linux Find Command](http://www.tecmint.com/35-practical-examples-of-linux-find-command/)
* [A Unix/Linux “find” Command Tutorial](http://content.hccfl.edu/pollock/Unix/FindCmd.htm)
* [Linux locate command: Find Files and Directories Quickly and Efficiently](http://www.if-not-true-then-false.com/2010/linux-locate-command-find-files-and-directories-quickly-and-efficiently/)
* []()
