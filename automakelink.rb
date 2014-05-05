#!/usr/bin/env ruby
#-*- encoding:utf-8 -*-
=begin
カレントディレクトリにある .から始まるdotfile(ディレクトリも可)をHOME以下にシンボリックリンクします。
Dropboxにdotfile用のdirectoryを作りその中にこのスクリプトを入れておけば、OS(のユーザー)のセットアップ時に実行すればリンクを作ってくれます。

Ruby1.9用 (JRuby --1.9 でも動作可能)
=end

Dir::chdir(File.dirname($0))

puts "このスクリプトはホームディレクトリにシンボリックリンクを貼ります。"
print "実行しますか？[y/n]:"
a = STDIN.gets().chomp
unless a == "y" or a == "yes" then
puts "exit."
exit 0
end

dirfiles = `find . -maxdepth 1 -name ".*" ! -name "." ! -name ".git*" | sed 's!^./!!'`
dotfiles = Array.new

dirfiles.each_line do |line|
dotfiles << line if line =~ /^\..+$/ and line !~ /^\.\..*/
end

print "以下のファイルとディレクトリをHOME以下にリンクします\n\n"
dotfiles.each do |f|
puts f
end
print "\nOK?[y/n]:"
a = STDIN.gets().chomp
unless a == "y" or a == "yes" then
puts "exit."
exit 0
end

dotfiles.each do |fd|
begin
c = File.symlink(File.expand_path(fd.chomp),File.expand_path("~/#{fd.chomp}"))
rescue Errno::EEXIST => e
                puts "#{fd.chomp} is already exists. [SKIP]"
next
end
puts "Create #{fd} " if c == 0
end

puts "Finished."
