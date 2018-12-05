#!/usr/bin/env python
# coding=utf-8

import glob
import re
import linecache


#TODO smali_dir as a global variable?
smali_dir = '/home/dosi/08/contentProvider/apktool_out/smali-test/'

def is_smali_file(method_class_name):
    '''
        if the smali file exist, return the smali file path, else, return None
        :param method_class_name: class name of the method
        :rtype: String
    '''
    method_class_smali_name = smali_dir + method_class_name[1:-1] + '.smali'
    if glob.glob(method_class_smali_name):
        return method_class_smali_name
    else:
        return None

def loc_method(method_name, method_descriptor, method_access_flag, method_class_smali_file, method_smali_file_path):
    '''
        locate method in method_class_smali_file
        :param method_name: name of method
        :param method_descriptor: method descriptor
        :param method_access_flag: method access flag
        above three make up the re.search pattern
        :param method_class_smali_file: file object, for read
        :param method_smali_file_path: file path, for new a smali file
        :rtype: path to the new smali file
    '''
    #prepare a new smali file, named xx1.smali, rename it after instrumentation done
    newfilepath = method_smali_file_path[:-6] + '1' + method_smali_file_path[-6:]
    newfile = open(newfilepath, 'w')
    #prepare for pattern
    method_descriptor = method_descriptor.replace(' ', '')#remove space!
    str = ['/', '(', ')', ';', '[', ']']
    for i in str:
        method_name = method_name.replace(i, '\\' + i)#no need?
        method_descriptor = method_descriptor.replace(i, '\\' + i)
    pattern = '.method ' + method_access_flag + ' ' + method_name + method_descriptor
    print('\nmethod pattern', pattern)
    while 1:
        line = method_class_smali_file.readline()
        if not line:
            break
        newfile.write(line)
        line = line.lstrip()
        if re.search(pattern, line):
            print('here is the method')
            break
    newfile.close()
    return newfilepath

def loc_basicblock(flag, ins, method_class_smali_file, newfilepath):
    '''
        locate each basic block and do some instrumentation, if it comes to the explicit basicblock, ignore the basicblock info from androguard
        :param flag: 1 for one line basicblock, 0 for first ins, 2 for last ins
        :param ins: ins to locate, instrument after this ins. in detail, instument an ins after the first and last ins of a basicblock
        :param method_class_smali_file: file object at the specific method locationi, for read
        :param newfilepath: path to the new smali file, for append
        :rtype: True if it comes to explicit basicblocks
    '''
    newfile = open(newfilepath, 'a') #append
    #TODO find lines in order is not ideal...
    #TODO ignore the value of the ins is not ideal, too...
    print('ins:', ins)
    stopflag = False
    for num, line in enumerate(method_class_smali_file):
        #print(num, line)
        newfile.write(line)
        if ins in line:
            #instrumentation
            if flag == 1: # one line basicblock
                sub = '\n' + 'dosi' + '\n'#change sub contents here!!!
            elif flag == 0:
                sub = '\n' + 'dosi first ins' + '\n'
            else:
                sub = '\n' + 'dosi last ins' + '\n'
            line = re.sub(r'.*\n', sub, line)
            newfile.write(line)
            #newfile.write(sub)
            break
    newfile.close()
    return stopflag

def instrument_rest_of_method(method_class_smali_file, newfile):
    '''
        starts at the first explicit basicblock, instruments from here
        :param method_class_smali_file: file object
        :param newfilepath: file object
        :rtype: no return
    '''
    print('explicit')
    '''
    for num, line in enumerate(method_class_smali_file):
        print('explicit:', num, line)
        newfile.write(line)
        if line.lstrip().startswith(':'):
            sub = 'dosi' + '\n'
            newfile.write(sub)
    newfile.close()
    '''
        

def append_rest_of_smali(method_class_smali_file, newfilepath):
    '''
        append the rest of the original smali file to the new smali file
        :param method_class_smali_file: file object
        :param newfilepath: path to the new smali file 
        :rtype: no return
    '''
    newfile = open(newfilepath, 'a')
    newfile.write(method_class_smali_file.read())
    #method_class_smali_file.seek(0, 0) #back to the beginning of the original smali file, for next bb
    newfile.close()
'''
method_class_name = 'Lcom/facebook/lite/photo/MediaContentProvider;'
method_name = 'openFile(Landroid/net/Uri;Ljava/lang/String;)'
method_descriptor = 'Landroid/os/ParcelFileDescriptor;'
method_access_flag = 'public'
firstins = 'const-string'
lastins = 'if-ne'
firstins2 = 'new-instance'
lastins2 = 'throw'
import os
f = is_smali_file(method_class_name)
if f:
    file = open(f, 'r+')
    newfilepath = loc_method(method_name, method_descriptor, method_access_flag, file, f)
    loc_basicblock(firstins, file, newfilepath)
    loc_basicblock(lastins, file, newfilepath)
    loc_basicblock(firstins2, file, newfilepath)
    loc_basicblock(lastins2, file, newfilepath)
    append_rest_of_smali(file, newfilepath)
    file.close()
    os.rename(newfilepath, f)
'''
