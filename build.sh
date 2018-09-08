#!/usr/bin/env sh



# ${0} の dirname を取得
cwd=`dirname "${0}"`

# ${0} が 相対パスの場合は cd して pwd を取得
expr "${0}" : "/.*" > /dev/null || cwd=`(cd "${cwd}" && pwd)`

sourceDir="${cwd}/nixos/"
targetDir="/etc/"
cfgSrcPath="${sourceDir}${HOSTNAME}.nix"
cfgTgtPath="/etc/nixos/configuration.nix"

echo "copy"
echo "FROM $sourceDir"
echo "TO   /etc/"
sudo cp -r $sourceDir /etc/

echo "HOSTNAME $HOSTNAME"

if [ ! -e $cfgSrcPath ]; then
  cfgSrcPath="${sourceDir}configuration.nix"
fi
echo "copy"
echo "FROM $cfgSrcPath"
echo "TO   $cfgTgtPath"

sudo cp -r $cfgSrcPath $cfgTgtPath 


echo "rebuild"
sudo nixos-rebuild switch --upgrade --show-trace


