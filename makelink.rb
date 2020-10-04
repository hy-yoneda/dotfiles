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

dotfiles = `sh ./makelink.common.sh dot-files`.split(" ")
directories = `sh ./makelink.common.sh dot-directories`.split(" ")
targets = dotfiles + directories

print "以下のファイルとディレクトリをHOME以下にリンクします\n\n"

targets.each do |f|
  puts f
end

print "\nOK?[y/n]:"
a = STDIN.gets().chomp
unless a == "y" or a == "yes" then
puts "exit."
exit 0
end

backup_directory = File.expand_path("~/dotfiles_backup_#{Time.now.strftime("%Y%m%d")}")
targets.each do |fd|
  dst_path = File.expand_path("~/#{fd.chomp}")
  if File.exist?(dst_path) and ! File.symlink?(dst_path) then
    Dir.mkdir(backup_directory) unless File.exists?(backup_directory)
    File.rename(dst_path, "#{backup_directory}/#{fd.chomp}")
    puts "既存のファイル: ~/#{fd.chomp} を #{backup_directory}/#{fd.chomp}に移しました"
  end
  begin
    c = File.symlink(File.expand_path(fd.chomp),dst_path)
  rescue Errno::EEXIST => e
    puts "#{fd.chomp} is already exists. [SKIP]"
  next
  end
  puts "Create #{fd} " if c == 0
end

puts "Finished."
