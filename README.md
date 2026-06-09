# GI-Ebook | 原神游戏文本电子书化

一个致力于收集《原神》游戏内文本，整理成 Markdown 格式，并可转换为 EPUB 电子书的项目。提升阅读体验。

## 下载EPUB

请到[release](https://github.com/MIN-121/GI-Ebook/releases)页面

进度:  

- [X] 游戏内书籍(至月之七版本)
- [X] 角色故事(至月之七版本)
- [X] 圣遗物文本(至月之七版本)
- [X] 武器文本(至月之七版本)
- [ ] 也许还有其他值得收集的文本吧

## 如果你想自己生成

### 环境要求

- PowerShell（Windows）
- [Pandoc](https://pandoc.org/installing.html) - 用于将 Markdown 转换为 EPUB

### 生成 EPUB

运行构建脚本：

```powershell
.\build-epub.ps1
```

完成后，EPUB 文件将生成在 `output/` 目录下。

## 注意

本项目所包含的游戏内容版权属于 [HoYoverse](https://www.hoyoverse.com/)（米哈游）。本项目仅供学习和个人使用，不可用于商业目的。
