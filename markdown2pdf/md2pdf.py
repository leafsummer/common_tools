#!/usr/bin/env python
import os
import argparse

from weasyprint import HTML
from markdown2 import markdown_path


def convert_md_2_pdf(filepath, output=None, theme=None, codecss=None):
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    html = markdown_path(filepath, extras=["code-friendly", "fenced-code-blocks"])
    css_file_list = []
    if output and os.path.isdir(output):
        output = os.path.join(output, '.'.join([os.path.basename(filepath).rsplit('.', 1)[0], 'pdf']))
    elif output is None:
        output = '.'.join([filepath.rsplit('.', 1)[0], 'pdf'])
    if theme is not None:
        css_file = theme
        if not os.path.exists(css_file):
            css_file = os.path.join(BASE_DIR, 'themes/'+theme+'.css')
        print 'theme_css:', css_file
        css_file_list.append(css_file)
        # HTML(string=html).write_pdf(output, stylesheets=[css_file])
    
    if codecss is not None:
        css_file = codecss
        if not os.path.exists(css_file):
            css_file = os.path.join(BASE_DIR, 'pygments-css/'+codecss+'.css')
        print 'code_css:', css_file
        css_file_list.append(css_file)

    print 'output file:', output
    if css_file_list:
        HTML(string=html).write_pdf(output, stylesheets=css_file_list)
    else:
        HTML(string=html).write_pdf(output)


def main():
    parser = argparse.ArgumentParser(description='Convert markdown file to pdf')
    parser.add_argument('-f', '--filepath', help='Markdown file path')
    parser.add_argument('-t', '--theme', help='Set the theme, default is GitHub flavored.', default='github')
    parser.add_argument('-cc', '--codecss', help='Set the code css, default is pygments friendly css.', default='friendly')
    parser.add_argument('-o', '--output', help='The output file path. If not set, '
                        'the name will be same as the input file but with ".pdf" in current dir.')
    args = parser.parse_args()
    convert_md_2_pdf(**dict(args._get_kwargs()))


if __name__ == '__main__':
    main()
