# coding: UTF-8

import time
import msvcrt
from ctypes import *

if __name__=='__main__':

    user32 = windll.LoadLibrary('user32.dll')
    user32.BlockInput(True)

    while True:
        pw = list()
        for i in range(4):
            ch = msvcrt.getch()
            pw.append(ch)

        str_pw = ''.join(pw)

        if str_pw == 'open':
            user32.BlockInput(False)
            break

        print "-------------------"