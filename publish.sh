#!/bin/bash

set -e

inputVersion=""
commit=""
ignore_lint=false
force_push=false

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
    --ignore-lint)
        ignore_lint=true
        ;;
    --force-push)
        force_push=true
        ;;
    esac
    shift
done

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
    DEFAULT_COMMIT="[Auto] 自动化打包提交版本：$VERSION"
    echo "请输入提交日志（或按 Enter 使用 \"$DEFAULT_COMMIT\" 作为提交文案）"
    read -p "提交文案：" userCommit
    commit="${userCommit:-$DEFAULT_COMMIT}"
    echo "提交日志已设置为：$commit"
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
# 条件执行 pod lib lint
if [ "$ignore_lint" = false ]; then
echo "pod lib lint >>>>>>>>"
pod lib lint --allow-warnings --verbose  --skip-tests --skip-import-validation --sources="https://github.com/CocoaPods/Specs.git,http://172.16.50.23:8081/topdon-app/ios/specs.git"
echo "pod lib lint success ✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔"
else
    echo "已跳过 pod lib lint 步骤"
fi

# Git 操作
echo "提交代码 + tag >>>>>>>>"
git add .

# 确保 commit 只有在有变更时才执行
if ! git diff --cached --quiet; then
    git commit -m "$commit"
else
    echo "没有文件变更，跳过 commit"
fi

# 检查远程是否已有本地分支
REMOTE_BRANCHES=$(git ls-remote --heads origin | awk '{print $2}')
LOCAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ ! " ${REMOTE_BRANCHES} " =~ " refs/heads/${LOCAL_BRANCH} " ]]; then
    echo "远程仓库没有 ${LOCAL_BRANCH} 分支，正在创建..."
    git push --set-upstream origin "$LOCAL_BRANCH"
else
    echo "远程已存在 ${LOCAL_BRANCH} 分支，直接 push"
    git push
fi

# 处理 tag
if git rev-parse "$VERSION" >/dev/null 2>&1; then
    echo "Tag $VERSION 已存在，跳过创建"
    git tag -d "$VERSION" || true
    git push origin --delete "$VERSION" || true
fi

echo "创建新标签 $VERSION"
git tag "$VERSION"
git push origin "$VERSION"

echo "推送到 cocoapods 仓库>>>>>>>"
if [ "$force_push" = true ]; then
    echo "使用强制推送模式"
    pod force repo push topdon *.podspec
else
    pod repo push topdon *.podspec --allow-warnings --verbose  --skip-tests --skip-import-validation --sources="https://github.com/CocoaPods/Specs.git,http://172.16.50.23:8081/topdon-app/ios/specs.git"
fi

echo "======================================"
echo "所有步骤已完成！"
echo "版本号: $VERSION"
echo "Tag: $VERSION 已推送"
echo "Pod 已发布到仓库"
