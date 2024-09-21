## 收集字体

- 放到 docker 容器里面

```bash
# 构建镜像
sudo docker build -t windows-font:v1 .
# 进入容器
sudo  docker run -it myfont:v1 bash

sudo  docker run -it myfont:v2 bash

## 字体大小为: 1.18GB
365M    font
685M    windows/
```
```python
move_fonts('popular-fonts','myfont/popular')  #华文字体
move_fonts('source-han-serif','myfont/source-han-serif') #思源宋
move_fonts('source-han-sans','myfont/source-han-sans') #思源黑
move_fonts('times-new-roman','myfont/times-new-roman') #times new roman
move_fonts('free-font/assets/font/中文/方正字体系列','myfont/fangzheng') #方正
move_fonts('monaspace/fonts/otf','myfont/monaspace') #monaspace
# ./myfont/windows  # windows字体
```