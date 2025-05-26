# 精装 - 牛津高阶双解第10版完美版（OALDPE）苹果系统词典版本

## 说明

本项目基于 https://forum.freemdict.com/t/topic/30466 分享的OALDPE词典, 转换为苹果系统词典格式并有少量适配性修改. 转换过程参考https://github.com/tisfeng/Easydict/blob/main/docs/How-to-use-macOS-system-dictionary-in-Easydict-zh.md

请支持原分享者和原书作者.

## 环境搭建

1. 安装 Xcode 的命令行工具 [Command Line Tools for Xcode](https://developer.apple.com/downloads).
1. 确认Xcode版本: `/usr/bin/xcodebuild -version`.
1. 下载对应版本的[Additional Tools for Xcode](https://developer.apple.com/downloads). 下载后，需要将dmg文件中的 `Dictionary Development Kit` 移动到 `/Applications/Utilities/Dictionary Development Kit` 位置.
1. 安装Python 3.12，建议使用[mise](https://mise.jdx.dev/lang/python.html)安装和管理Python环境.
1. 克隆本项目并进入项目文件夹
1. 创建一个Python venv: `python -m venv ./.venv`
1. 安装依赖包: `source .venv/bin/activate && pip install -r ./requirements.txt`
1. 下载原词典，解压后放在项目文件夹下的mdict目录中. 此时mdict目录结构应该如下所示:
    ```text
     mdict
    ├──  oaldpe-jquery.js
    ├──  oaldpe.1.mdd
    ├──  oaldpe.2.mdd
    ├──  oaldpe.3-001.mdd
    ├──  oaldpe.css
    ├──  oaldpe.js
    ├──  oaldpe.mdd
    ├──  oaldpe.mdx
    ├──  oaldpe.png
    └──  中文例句释义反查
        ├──  oaldzh.css
        ├──  oaldZhEn.mdd
        └──  oaldZhEn.mdx
    ```

## 构建

```sh
source .venv/bin/activate
./make.sh
```

## 其他工具

(使用前记得激活venv `source .venv/bin/activate`)

```sh
# 把构建好的字典安装到用户字典目录
./install.sh

# 卸载用户字典目录中的字典
./uninstall.sh
```

## 适配

- 增加了文件夹图标,图标来自原词典文件
- 修改css文件使所有段落都默认展开. 原因是原词典使用js控制段落的动态展开和折叠, 但目前没在苹果自带词典中找到对应的js支持.

## 其他

- 暂不支持中文例句释义反查
