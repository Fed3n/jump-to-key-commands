# Jump-To-Key Commands

Sorry bad name but needed an easy-to-write and hopefully mostly conflict-free prefix :))

Simple bash shell commands wrapper to make file system navigation easier. Assign a keyword to a filepath and execute commands towards that filepath using that keyword.

Basic usage looks like:

    jkcmd add mykey ./maybe/pretty/long/directory/filepath
    jkcmd ls mykey
    jkcmd cd mykey
    jkcmd del oldkey

Keys can be added with `jkcmd add somekey somepath`, existing key-value pairs can be deleted with `jkcmd del somekey`.
`jkcmd cmd key` syntax by itself can execute any arbitrary command but is tedious.
jkcmd can be wrapped itself with any command to look like:

    jkls mykey
    jkcd mykey

Jump-To-Key commands can also take options like their ordinary counterpart:

    jkls -l mykey

The program is not a real executable, it is a set of functions sourced from the user's .bashrc file, so it does not exist outside of your own shell.
Keys will be showed as possible autocompletions when tabbing.

## Installation

The script uses the *realpath* command, it should probably be installed on your distro but not being so ancient you never know.

### install.sh
Easiest way to install the wrapper, simply run `sh install.sh` as user and files will be put inside your home directory under ~/.jkcmd/ and the sourcing line will be appended to your ~/.bashrc file.
You can customize your needed set of wrapped commands in the commands.list file before running the install script or leave it as is (default will create the *jkcd* *jkcat* *jkls* wrappers).
Running `sh install.sh uninstall` simply removes the ~/.jkcmd/ directory and the appended sourcing lines.
By running the install script restarting the shell should not be needed, but in case you cannot seem to be able to run the commands right after installation, try starting a new shell.

### Manual installation
Manual installation is not difficult either, first of all create a ~/.jkcmd directory (or modify the **JKCMDPATH** variable in the script and pick your own default directory) with a jkdb.txt file where the key-value pairs will be memorized.
Then source from your shell (append `source path/to/script`) either the basic jkcmd.sh script or generate a jkgen.sh script with customized wrappers (chosen by modifying commands.list file) running `python3 gen_script.py`.

## WIP

* jkcmd and wrappers being shell functions, they cannot be executed with `sudo jkcmd`. I might think of a workaround someday, but that would probably be quite hacky. As for now, if all you need is editing a file with admin rights (e.g. a configuration file with some obscure path) you could try wrapping *sudoedit*:
    
    `jksudoedit filekey`

* I do not think every kind of file path format is still supported, but basic ones at least should (special symbols could probably break the parsing?). There is no hard checking on keys and paths as of now so this is easily breakable for sure if you try (you should probably stick with single word, no special characters keys).

* Autocompletion for the add directive should eventually show file navigation instead of keys.
