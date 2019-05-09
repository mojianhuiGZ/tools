# coding: utf-8

import argparse
from bs4 import BeautifulSoup
from urllib.request import urlopen
from urllib.error import HTTPError


OUTPUT_FORMAT = """<!DOCTYPE NETSCAPE-Bookmark-file-1>
<!-- This is an automatically generated file.
    It will be read and overwritten.
    DO NOT EDIT! -->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks</TITLE>
<H1>Bookmarks</H1>
<DL><p>
    <DT>{}
    <DL><p>
{}
    </DL><p>
</DL><p>
"""


def extract_title(bookmarks, output_file):
    print('重新生成所有书签的标题...')
    bookmarks_soup = BeautifulSoup(bookmarks, 'xml')

    for tag in bookmarks_soup.find_all('A'):
        print('书签: {}'.format(tag['HREF']))
        try:
            resp = urlopen(tag['HREF'])
            content = resp.read()
            soup = BeautifulSoup(content, 'lxml')
            print('\t{}'.format(soup.title.string.strip()))
            tag.string = soup.title.string.strip()
        except HTTPError as e:
            print('\t{}'.format(e))

    header = str(bookmarks_soup.H3)
    content = ''
    for tag in bookmarks_soup.find_all('A'):
        content += '        <DT>' + str(tag) + '\n'
    output = OUTPUT_FORMAT.format(header, content)
    print('结果保存到{}'.format(output_file))
    with open(output_file, 'w') as f:
        f.write(output)
        f.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='重新生成所有书签的标题')
    parser.add_argument('input_file', help='chrome的书签文件')
    parser.add_argument('output_file', nargs='?', default='output.html',
                        help='输出文件')
    args = parser.parse_args()
    with open(args.input_file, 'r') as f:
        bookmarks = f.read()
        f.close()
        extract_title(bookmarks, args.output_file)
