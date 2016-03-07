# 検索
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }

# svn cleanup
cleanup-svn () {
    find $@ -type d -name ".svn" -print | xargs -i sh -cx "svn cleanup {}/.."
}
