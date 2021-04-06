if [ "$1" = uninstall ]; then
    echo Running uninstall script...
    rm -rf $HOME/.jkcmd;
    sed -i '/^source $HOME\/.jkcmd\/jkcmd.sh/d' $HOME/.bashrc;
else
    echo Running install script...
    if [ ! -d $HOME/.jkcmd ]; then
        mkdir $HOME/.jkcmd
    fi
    python3 ./gen_script.py
    cp ./jkgen.sh $HOME/.jkcmd/jkcmd.sh
    touch $HOME/.jkcmd/jkdb.txt
    if [ -z "$(grep 'source $HOME/.jkcmd/jkcmd.sh' $HOME/.bashrc)" ]; then
        echo 'source $HOME/.jkcmd/jkcmd.sh' >> $HOME/.bashrc
    fi
    . $HOME/.bashrc
fi
