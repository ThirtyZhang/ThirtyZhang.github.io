# 运行python3 watermark.py postname添加水印，如果第一次运行要给所有文章添加水印，可以运行python3 watermark.py all

python3 watermark.py postname

:'
图片添加水印
为了防止别人抄袭你文章，可以把所有的图片都加上水印，方法很简单。

首先在博客根目录下新建一个watermark.py，代码如下：

# -*- coding: utf-8 -*- 
import sys
import glob
from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont


def watermark(post_name):
    if post_name == 'all':
        post_name = '*'
    dir_name = 'source/_posts/' + post_name + '/*'
    for files in glob.glob(dir_name):
        im = Image.open(files)
        if len(im.getbands()) < 3:
            im = im.convert('RGB')
            print(files)
        font = ImageFont.truetype('STSONG.TTF', max(30, int(im.size[1] / 20)))
        draw = ImageDraw.Draw(im)
        draw.text((im.size[0] / 2, im.size[1] / 2),
                  u'@yourname', fill=(0, 0, 0), font=font)
        im.save(files)


if __name__ == '__main__':
    if len(sys.argv) == 2:
        watermark(sys.argv[1])
    else:
        print('[usage] <input>')
字体也放根目录下，自己找字体。然后每次写完一篇文章可以运行python3 watermark.py postname添加水印，如果第一次运行要给所有文章添加水印，可以运行python3 watermark.py all
'



:'
PIL其实只是python2的专利，它并没有跟随python的进化而进化。有大师为此，专门写了一个针对python3的pillow模块。

所以，如果需要安装python3对应的PIL，应该选择安装pillow
'