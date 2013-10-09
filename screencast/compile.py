#!/usr/bin/env python
# -*- mode: python; coding: utf-8 -*-

import sys
import os
import time
import signal

from time import sleep
from commodity.os_ import SubProcess
from gexter.gext import mouse, keyboard, Keyboard


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


recorder = SubProcess('/usr/bin/recordmydesktop --no-sound --full-shots -x 10 -y 45 --width 775 --height 580 --delay 4 compile.ogv')
# --no-cursor

SubProcess('rm /tmp/hello.c').wait()
emacs = SubProcess('/usr/bin/emacs --no-splash -q -l init.el -g 80x25')
sleep(5)

# new file: /tmp/hello.c
k('<Alt_L>xerase-buffer<Return>y')
comment("; The emacs 'compile' command works for any language or anything...")
comment("; As example lets to create a minimal C program at '/tmp/hello.c'.")

k('<Control_L>x<Control_L>f')
k('<Shift_L><7>tmp<Shift_L><7>hello<period>c')
k('<Return>')

# main
k('main<Tab>')
k('<Control_L><End><Return><Return>')
comment("// Ready to compile: F5 and enter command 'make hello'")

k('<F5>')
k('<Control_L>a<Control_L>kmake hello')
k('<Return>')

comment("// Green modeline means SUCCESS")
close_compilation()

# error
comment("// Lets to produce an error, and recompile (F5)")
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

comment("// Green, all right again ('compilation buffer' is not shown)")

comment("// Lets to add some code")

# warning
k('<Up><Up><Up><Up>')
k('printf("hi");')
k('<F5>')

comment("// Orange, that is a warning ('compilation buffer' is not shown)")

comment("// But you can see it pressing Control-F5")

k('<Control_L><F5>')
comment("// Fixing the warning...")
close_compilation()

k('<Control_L><Home><Control_L>o')
k('inc<Tab>')
mouse.moveAbsTo(100, 260)
mouse.leftClick()
k('stdio<period>h<Tab>')
k('<F5>')

comment("// That's all<Return>// This feature is available in 'emacs-pills' (module 'compile.cfg')<Return>// https://bitbucket.org/arco_group/emacs-pills<Return><Return>// This screenshot was made using gexter and recordmydesktop<Return><Return>// David.Villa@gmail.com (@david_vi11a)")
save()

time.sleep(1)
os.kill(recorder.pid, signal.SIGTERM)
