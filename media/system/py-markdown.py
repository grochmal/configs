#!/usr/bin/env python

import sys
import markdown as md

head_top = '''<!DOCTYPE html>
<html>
<head>

<title>D&amp;D reference</title>
<meta charset="utf-8" />
<style>
h1, h2, h3, h4 { color : #335; }
blockquote { background-color : #ccc;
             padding : 3px;
}
table { background-color : #e3e3e3;
        border-collapse : collapse;
        text-align : center;
        margin : 0.3em;
}
thead { border-bottom : 1px solid black; }
thead tr { background-color : #c3c3c3; }
td { padding : 0.3em; }
th { padding : 0.3em; }
tr:nth-child(2n) { background-color : #c3c3c3; }
dt { font-weight : bold; }
code { font-size : 1.3em; }
</style>'''
# here go the arguments
head_bottom = '''
</head>
<body>
'''
# here goes the mardown
tail = '''
</body>
</html>
'''

if 1 >= len(sys.argv):
    print('Usage:', sys.argv[0], 'file.md [<head> elements]')
else:
    with open(sys.argv[1]) as f:
        print(head_top)
        for arg in sys.argv[2:]:
            print(arg)
        print(head_bottom)
        print(md.markdown(f.read(), ['markdown.extensions.extra']))
        print(tail)

