#!/bin/sh

cd `dirname $0`

echo "このスクリプトはホームディレクトリにシンボリックリンクを貼ります。"
echo -n "実行しますか?[y/n]:"
read ANS

if [ ! $ANS ]; then
	echo "exit"
	exit 0
fi
if [ ! $ANS -o $ANS != 'y' -a $ANS != 'yes' ]; then
	echo "exit"
	exit 0
fi

source ./automakelink_common.sh

dotfiles=`dot_files`
directories=`dot_directories`

echo "以下のファイルとディレクトリをHOME以下にリンクします"

for arg in $dotfiles
do
	echo "$HOME $arg"
done

for arg in $directories
do
	echo "$HOME $arg"
done

echo -n "OK?[y/n]:"
read ANS

if [ ! $ANS ]; then
	echo "exit"
	exit 0
fi
if [ $ANS != 'y' -a $ANS != 'yes' ]; then
	echo "exit"
	exit 0
fi

for arg in $dotfiles
do
	cmd //c makelink.bat "$HOME" "$arg"
done

for arg in $directories
do
	arg=`echo $arg | sed -e 's/\///g'`
	cmd //c makelink.bat "$HOME" "$arg" //D
done
