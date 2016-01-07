# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }
