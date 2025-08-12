#!/bin/bash

set -e

inputVersion=""
commit=""

while [ $# -gt 0 ];
do
    case $1 in
    -v)
        inputVersion=$2
        echo
        shift
        ;;
    -m)
        commit=$2
        echo
        shift
        ;;
    esac
    shift
done

echo $inputVersion
echo $commit

if [ -z "$inputVersion" ]; then
    echo "请输入需要提交的版本号如：1.00.000， 需要比当前版本高。"
    read -p "请输入版本号：" value
    inputVersion=$value
else
    echo "输入的版本号为：$inputVersion"
fi

if [ -z "$commit" ]; then
    commit="【Auto】自动化打包提交版本：$inputVersion"
    echo "未输入提交日志，默认提交日志为：【Auto】自动化打包提交版本：$inputVersion"
else
    echo "提交日志：$commit"
fi

VERSION=$inputVersion

CUR_DIR=$PWD
PODSPEC_FILE=$CUR_DIR/*.podspec
INFO_FILE=$CUR_DIR/TopDonDiag/Classes/Diagnosis/Tools/TDD_DiagnosisManage.mm
CURRENT_VERSION=$(grep -E "s.version          = '([0-9.]*)'" $PODSPEC_FILE | sed -E "s/.*s.version          = '([0-9.]*)'.*/\1/")
echo "当前版本号为：$CURRENT_VERSION"

if [ -n "$inputVersion" ]; then
    # 使用 -v 指定的版本号
    VERSION="$inputVersion"
    echo "使用 -v 指定的版本号为：$VERSION"
else
    # 没有 -v 参数时提示用户输入版本号
    IFS='.' read -r major minor patch <<< "$CURRENT_VERSION"
    patch=$(printf "%03d" $((10#$patch + 1)))
    AUTO_VERSION="$major.$minor.$patch"
    echo "请输入版本号（或按 Enter 使用 $AUTO_VERSION 作为版本号）"
    read -p "版本号: " userVersion

    if [ -z "$userVersion" ]; then
        # 用户直接回车，自动增加补丁号
        VERSION="$AUTO_VERSION"
        echo "自动生成的新版本号为：$VERSION"
    else
        # 用户输入了版本号，使用输入的版本号
        VERSION="$userVersion"
        echo "输入的版本号为：$VERSION"
    fi
fi

if [ -z "$commit" ]; then
    commit="【Auto】自动化打包提交版本：$inputVersion"
    echo "未输入提交日志，默认提交日志为：【Auto】自动化打包提交版本：$inputVersion"
else
    echo "提交日志：$commit"
fi

echo "检查本地 Pod 仓库列表..."
POD_REPO_LIST=$(pod repo list)

if [[ ! $POD_REPO_LIST == *"topdon"* ]]; then
    echo "本地没有 topdon 仓库，添加仓库..."
    pod repo add topdon http://172.16.50.23:8081/topdon-app/ios/specs.git
    echo "仓库 topdon 添加成功。"
else
    echo "本地已存在 topdon 仓库。"
fi

echo ">>>>>>>>>>>>>>>>>>>>"
echo "开始执行打包脚本>>>>>>>"
echo "修改版本号：$VERSION"

echo "修改 podspec 版本号"
sed -i '' "s/s.version          = \'[0-9.]*\'/s.version          = \'$VERSION\'/" $PODSPEC_FILE
echo "podspec 中版本号修改成功>>>>>"

echo "修改 LMSAppInfo 版本号"
sed -i '' "s/return @\"[0-9.]*\";\/\/与podspec版本号保持一致/return @\"$VERSION\";\/\/与podspec版本号保持一致/" $INFO_FILE
echo "TopdonDiagnosis 中版本号已修改>>>>>"

echo "pod lib lint >>>>>>>>"
pod lib lint --allow-warnings --verbose  --skip-tests --skip-import-validation --sources="https://github.com/CocoaPods/Specs.git,http://172.16.50.23:8081/topdon-app/ios/specs.git"
echo "pod lib lint success ✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔"

echo "提交代码 + tag >>>>>>>>"
git add .
git commit -m "$commit"
git tag $VERSION
git push origin $VERSION
git push

echo "推送到 cocoapods 仓库>>>>>>>"
pod repo push topdon *.podspec --allow-warnings --verbose  --skip-tests --skip-import-validation --sources="https://github.com/CocoaPods/Specs.git,http://172.16.50.23:8081/topdon-app/ios/specs.git"
