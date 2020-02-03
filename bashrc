# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

export HADOOP_HOME=/opt/hadoop/hadoop-3.1.2
export HIVE_HOME=/opt/hadoop/hive-3.1.2
export TEZ_HOME=/opt/hadoop/tez-0.9.2
export PATH=$HIVE_HOME/bin:$HADOOP_HOME/bin:$PATH

alias hdfs="hadoop dfs"
alias hs2="hive --hiveserver"
