#!/usr/bin/env python
# -*- mode: python; coding: utf-8 -*-

import sys
from time import sleep
from commodity.os_ import SubProcess
from gexter.gext import mouse, keyboard, Keyboard, UserNote


def k(keys):
    keyboard.generateKeyEvents(keys, mode=Keyboard.MODE_NORMAL)


def comment(msg):
    k('<Control_L><End><Up>')
    k('<Control_L>a<Control_L>k')
    k(msg + ' ')
    sleep(2)


def save():
    k('<Control_L>x<Control_L>s')


def close_compilation():
    k('<Control_L>x1')


SubProcess('rm /tmp/hello.c').wait()
emacs = SubProcess('/usr/bin/emacs --no-splash -q -l init.el -g 80x25')
sleep(3)

mouse.moveAbsTo(767, 345)
mouse.leftClick()

# new file: /tmp/hello.c
k('<Alt_L>xerase-buffer<Return>y')
comment("; Lets to create a minimal C program at '/tmp/hello.c'")

k('<Control_L>x<Control_L>f')
k('<Shift_L><7>tmp<Shift_L><7>hello<period>c<Return>')

# main
k('main<Tab>')
k('<Control_L><End><Return><Return>')
comment("// Ready to compile: M-x compile, make hello")

k('<Alt_L>xcompile<Return>')
k('<Control_L>a<Control_L>kmake hello<Return>')

comment("// Green modeline means SUCCESS")
close_compilation()

# error
comment("// Lets to produce an C error, and recompile (F5)")
k('<Up><Up><Up><Up>')
k('wrong<Tab>')
k('<F5>')

comment("// Red modeline means ERROR, 'compilation buffer' is open")
save()
close_compilation()

# error fixed
comment("// Fixing the error and recompile (F5)")

k('<Up><Up><Up><Up>')
k('<Control_L>a<Control_L>k')
k('<F5>')

comment("// Green, all right again ('compile buffer' is not shown)")

comment("// Lets to add some code")

# warning
k('<Up><Up><Up><Up>')
k('printf("hi");')
k('<F5>')

comment("// Orange, that is a warning ('compile buffer' is not shown)")

comment("// But you can see it pressing Control-F5")

k('<Control_L><F5>')
comment("// Fixing the warning...")
close_compilation()

k('<Control_L><Home><Control_L>o')
k('inc<Tab>')
mouse.moveAbsTo(779, 240)
mouse.leftClick()
k('stdio<period>h<Tab>')
k('<F5>')

comment("// That's all<Return>// This feature is available in 'emacs-pills'")
save()
