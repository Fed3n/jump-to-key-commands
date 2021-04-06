script=open("./jkcmd.script", "r").read()
cmds=filter(None, open("./commands.list", "r").read().split("\n"))

functions=""
completions=""
for cmd in cmds:
    functions+=f"jk{cmd}(){{ jkcmd {cmd} $@; }}\n"
    completions+=f"complete -W \"$(echo `awk '{{print $1}}' $JKCMDPATH/jkdb.txt | uniq`)\" jk{cmd}\n"
script=script.replace("#FUNCTIONS#", functions)
script=script.replace("#COMPLETIONS#", completions)

target=open("./jkgen.sh", "w")
target.write(script)
