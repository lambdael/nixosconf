#!/usr/bin/env sh



# ${0} の dirname を取得
cwd=`dirname "${0}"`

# ${0} が 相対パスの場合は cd して pwd を取得
expr "${0}" : "/.*" > /dev/null || cwd=`(cd "${cwd}" && pwd)`

sourcePath="${cwd}/nixos/"

echo "copy"
echo $sourcePath
sudo cp -r $sourcePath /etc/


sudo nixos-rebuild switch --show-trace


