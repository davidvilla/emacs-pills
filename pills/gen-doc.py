#!/usr/bin/python
# -*- coding:utf-8; tab-width:4; mode:python -*-

import sys
import glob

REPO = 'https://bitbucket.org/DavidVilla/emacs-pills/src/tip/pills/'


def gen_title(text, level='='):
    title = "`{0} <{1}/{0}.el>`_".format(text, REPO)
    return "{0}\n{1}\n\n".format(title, level * len(title))


def module_doc(fname):
    retval = gen_title(fname[:-3])

    with file(fname) as fd:
        for line in fd:
            if not line.startswith(';|'):
                continue

            line = line[3:].strip('\n')
            print line
            if ':skip:' in line:
                return ''

            retval += line + '\n'
        retval += '\n'

    return retval


doc = file(sys.argv[1], 'w')
doc.write(file('header.rst').read() + '\n')

for line in file('template.el').readlines():
    doc.write('  ' + line)

doc.write('\n')

for fname in sorted(glob.glob('*.cfg.el')):
    doc.write(module_doc(fname))

doc.close()
