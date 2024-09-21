# 第一阶段：下载和解压字体文件
FROM ubuntu:jammy AS downloader
ENV DEBIAN_FRONTEND=noninteractive
# 安装必要的工具和中文字体，并清理 apt 缓存
RUN  apt update \
    && apt install -y wget unzip git bash language-pack-zh-hans python3 python3-pip  \
    && pip3 install pypinyin

SHELL ["/bin/bash", "-c"]
# 创建临时字体存放目录
RUN mkdir -p /tmp/font
WORKDIR /tmp
# 下载并解压 Source Han Sans 字体包
RUN wget https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansSC.zip \
    && unzip SourceHanSansSC.zip -d /tmp/source-han-sans 
# 下载并解压 Source Han Serif 字体包
RUN wget https://github.com/adobe-fonts/source-han-serif/releases/download/2.003R/09_SourceHanSerifSC.zip \
    && unzip 09_SourceHanSerifSC.zip -d /tmp/source-han-serif 

# 下载 popular-fonts 仓库，并筛选字体文件
RUN git clone https://github.com/zoushucai/popular-fonts.git /tmp/popular-fonts 
RUN git clone https://github.com/zoushucai/font-times-new-roman.git /tmp/times-new-roman
RUN git clone https://github.com/zoushucai/free-font.git /tmp/free-font

# 
RUN wget https://github.com/githubnext/monaspace/releases/download/v1.101/monaspace-v1.101.zip \
    && unzip monaspace-v1.101.zip -d /tmp/monaspace
COPY main.py main.py
RUN python3 ./main.py 

# 第二阶段：使用 windows-font 镜像
FROM qqzsc/windows-font:0.0.1 AS builder
# FROM ccr.ccs.tencentyun.com/zscgoweb/windows-font:0.0.1 AS builder
# 这个镜像是自己建的, 把 window 上的字体放到了/myfont/windows下面

# 第三阶段:
FROM alpine:3.14
WORKDIR /myfont
# 从第一阶段复制字体文件到最终镜像
COPY --from=downloader /tmp/myfont /myfont
# COPY --from=builder /myfont/windows /myfont/windows
