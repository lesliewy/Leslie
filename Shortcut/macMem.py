#!/usr/bin/python
#coding=utf-8
'''
Created on Jun 1, 2014
@author: jay

mac当中的内存使用标示跟Linux并不一样，mac里面有这样的四种：wired, active, inactive, free其中
wired是不能通过操作系统调度来协调内存，用了多少就是多少；
active是表示当前系统的软件等使用所占用的内存，是有效的数据
inactive表示内存数据曾经被使用过，但最近没有使用，有效的数据
free表示数据无效，也就是随时可以被操作系统调度用来做别的事情
所以一般一个比较正常健康的操作系统的内存状态是inactive和free能够有相对充足的余量，一般来说操作系统都会尽可能地占用内存（“不用白不用”的策略），所以free可能并不是很大，不过inactive足够就表示其实内存还是够用的。
'''
 
import subprocess
import re
 
# Get process info
ps = subprocess.Popen(['ps', '-caxm', '-orss,comm'], stdout=subprocess.PIPE).communicate()[0]
vm = subprocess.Popen(['vm_stat'], stdout=subprocess.PIPE).communicate()[0]
 
# Iterate processes
processLines = ps.split('\n')
sep = re.compile('[\s]+')
rssTotal = 0 # kB
for row in range(1,len(processLines)):
  rowText = processLines[row].strip()
  rowElements = sep.split(rowText)
  try:
    rss = float(rowElements[0]) * 1024
  except:
    rss = 0 # ignore...
  rssTotal += rss
 
# Process vm_stat
vmLines = vm.split('\n')
sep = re.compile(':[\s]+')
vmStats = {}
for row in range(1,len(vmLines)-2):
  rowText = vmLines[row].strip()
  rowElements = sep.split(rowText)
  vmStats[(rowElements[0])] = int(rowElements[1].strip('\.')) * 4096
 
print 'Wired Memory:\t\t%d MB' % ( vmStats["Pages wired down"]/1024/1024 )
print 'Active Memory:\t\t%d MB' % ( vmStats["Pages active"]/1024/1024 )
print 'Inactive Memory:\t%d MB' % ( vmStats["Pages inactive"]/1024/1024 )
print 'Free Memory:\t\t%d MB' % ( vmStats["Pages free"]/1024/1024 )
print 'Real Mem Total (ps):\t%.3f MB' % ( rssTotal/1024/1024 )
