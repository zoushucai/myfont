
from pypinyin import lazy_pinyin
from pathlib import Path
import os
import re
import shutil


def move_fonts(src_dir,dst_dir):
    if not Path(src_dir).exists():
        print("src_dir is not exists")
        return
    font_files = [i for i in Path(src_dir).rglob('*') if i.is_file() and i.suffix.lower() in ['.ttf', '.otf']]
    Path(dst_dir).mkdir(parents=True, exist_ok=True)
    for font_file in font_files:
        font_file_name = font_file.name
        # 如果有汉字 则用拼音重命名
        if re.search(r'[\u4e00-\u9fa5]', font_file_name):
            font_file_name_pinyin = ''.join(lazy_pinyin(font_file_name))
            font_file_name_pinyin = font_file_name_pinyin.replace(' ','')
            font_file.rename(os.path.join(dst_dir, font_file_name_pinyin))
            continue
        else:
            shutil.copyfile(str(font_file),  os.path.join(dst_dir, font_file_name))

move_fonts('popular-fonts','myfont/popular')
move_fonts('source-han-serif','myfont/source-han-serif')
move_fonts('source-han-sans','myfont/source-han-sans')
move_fonts('times-new-roman','myfont/times-new-roman')
move_fonts('free-font/assets/font/中文/方正字体系列','myfont/fangzheng')
move_fonts('monaspace/fonts/otf','myfont/monaspace')
