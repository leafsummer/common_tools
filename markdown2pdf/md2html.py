#!/usr/bin/env python
import os
import argparse

from markdown2 import markdown_path


def convert_md_2_html(filepath, output=None, theme=None, codecss=None):
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    html = """<!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8">
        <style type="text/css">
        .content-center { width: 76%; margin: auto; }
    """
    if theme is not None:
        theme_css_file = theme
        if not os.path.exists(theme_css_file):
            theme_css_file = os.path.join(BASE_DIR, 'themes/'+theme+'.css')

        print 'theme_css:', theme_css_file
        with open(theme_css_file) as theme_css_in:
            theme_css_html = theme_css_in.read()
    else:
        theme_css_html = ''
    html += theme_css_html
    if codecss is not None:
        codecss_file = codecss
        if not os.path.exists(codecss_file):
            codecss_file = os.path.join(BASE_DIR, 'pygments-css/'+codecss+'.css')
        print 'code_css', codecss_file
        with open(codecss_file) as code_css_in:
            code_css_html = code_css_in.read()
    else:
        code_css_html = ''
    html += code_css_html
    html += """
        </style>
    </head>
    <body>
    <div class="content-center">
    """

    html += markdown_path(filepath, extras=["code-friendly", "fenced-code-blocks"])
    html += """
        </div>
        </body>
    </html>
    """
    if output and os.path.isdir(output):
        output_file = '.'.join([output, filepath.rsplit('.')[0], 'html'])
    else:
        output_file = '.'.join([filepath.rsplit('.')[0], 'html'])

    print 'output file:', output_file
    with open(output_file, 'w') as output_html:
        output_html.write(html.encode('utf-8'))

def main():
    parser = argparse.ArgumentParser(description='Convert markdown file to pdf')
    parser.add_argument('-f', '--filepath', help='Markdown file path')
    parser.add_argument('-t', '--theme', help='Set the theme, default is GitHub flavored.', default='github')
    parser.add_argument('-cc', '--codecss', help='Set the code css, default is pygments friendly css.', default='friendly')
    parser.add_argument('-o', '--output', help='The output file path. If not set, '
                        'the name will be same as the input file but with ".pdf" in current dir.')
    args = parser.parse_args()
    convert_md_2_html(**dict(args._get_kwargs()))


if __name__ == '__main__':
    main()
