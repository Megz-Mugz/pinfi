# run test with -> python3 faultinject.py ./test 10 ""
#!/usr/bin/python

# executables will live in a file as such:
# /home/rmengle/pin/source/tools/pinfi/example/basicmath

import sys
import os
import getopt
import time
import random
import signal
import subprocess
import summarize_results

# updated paths for renamed top-level directory "pin"
currdir = "/home/rmengle/pin/source/tools/pinfi/example"   # example dir (contains median, test, inputs)
progbin = currdir  # directory containing binaries (script will join this with the binary name)

pinbin = "/home/rmengle/pin/pin"   # path to the pin executable (note: ./pin → /home/rmengle/pin/pin)

instcategorylib = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/instcategory.so"
instcountlib    = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/instcount.so"
filib           = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/faultinjection.so"

# Optional input if your program expects it:
# inputfile = currdir + "/input1.txt"

# only ever leave one of these commented in, 
# the rest should be commented out

outputdir     = currdir + "/std_output"
# outputdir     = currdir + "/unoptimized_output"
# outputdir     = currdir + "/unroll4x_output"

basedir       = currdir + "/baseline"
errordir      = currdir + "/error_output"
fileoutputdir = currdir + "/prog_output"

optionlist = []
if not os.path.isdir(outputdir):
  os.mkdir(outputdir)
if not os.path.isdir(basedir):
  os.mkdir(basedir)
if not os.path.isdir(errordir):
  os.mkdir(errordir)
if not os.path.isdir(fileoutputdir):
  os.mkdir(fileoutputdir)

timeout = 500

def execute(execlist, golden_output=False):
    global outputfile
    timeout = 30  # or wherever this is defined
    
    if golden_output:
      print("----- GOLDEN OUTPUT")
    else:
      print("----- Normal Test Case")

    outputFile = open(outputfile, "w")

    p = subprocess.Popen(
        execlist,
        stdout=subprocess.PIPE,     # capture output so we can print it
        stderr=subprocess.STDOUT,   # merge stderr into stdout
        universal_newlines=False     # return strings, not bytes
    )

    start_time = time.time()

    # --- stream output live ---
    for raw in p.stdout:
        
      line = raw.decode("utf-8", errors="replace").rstrip()

      # write to the file
      outputFile.write(line + "\n")

      # flush so file gets updated immediately
      outputFile.flush()

      # print line immediately to terminal
      if line not in {"include", "all", "exclude"}:
        print(f"> {line}")

      # --- timeout check ---
      if time.time() - start_time > timeout:
          print("\tParent: Child timed out. Cleaning up ... ")
          p.kill()
          outputFile.close()
          return "timed-out"

    # --- wait for child to actually finish ---
    returncode = p.wait()

    print("Program finished with code:", returncode)
    print("Time taken:", round(time.time() - start_time, 2))

    outputFile.close()
    print("\n")
    return str(returncode)


def main():
  #clear previous output
  global run_number, optionlist, outputfile
  # outputfile = basedir + "/golden_output"
  # execlist = [pinbin, '-t', instcategorylib, '--', progbin]
  # execlist.extend(optionlist)
  # execute(execlist)


  # baseline
  filelist_bef1 = os.listdir('./')
  filecounter_bef1 = len(filelist_bef1)
  outputfile = basedir + "/golden_std_output"
  execlist = [pinbin, '-t', instcountlib, '--', progbin]
  execlist.extend(optionlist)
  # execute(execlist, golden_output=True)
  filelist_aft1 = os.listdir('./')
  filecounter_aft1 = len(filelist_aft1)
  if(filecounter_aft1 - filecounter_bef1 > 2):
    for item in filelist_aft1:
      if(item not in filelist_bef1 and item != "pin.instcount.txt" and item != "pintool.log" and item != "pin.log"):
        os.system("mv " + item + ' ' + basedir)

  # fault injection
  for index in range(0, run_number):
    print(f'Run Number: #{index+1}')
    filelist_bef2 = os.listdir('./')
    filecounter_bef2 = len(filelist_bef2)
    outputfile = outputdir + "/std_outputfile-" + str(index)
    errorfile = errordir + "/errorfile-" + str(index)
    execlist = [pinbin, '-t', filib, '-fioption', 'AllInst', '--', progbin]
    execlist.extend(optionlist)
    ret = execute(execlist)
    if ret == "timed-out":
      error_File = open(errorfile, 'w')
      error_File.write("Program hang\n")
      error_File.close()
    elif int(ret) < 0:
      error_File = open(errorfile, 'w')
      error_File.write("Program crashed, terminated by the system, return code " + ret + '\n')
      error_File.close()
    elif int(ret) > 0:
      error_File = open(errorfile, 'w')
      error_File.write("Program crashed, terminated by itself, return code " + ret + '\n')
      error_File.close()
    filelist_aft2 = os.listdir('./')
    filecounter_aft2 = len(filelist_aft2)
    for item in filelist_aft2:
      if(item not in filelist_bef2 and item != "activate"):
        fileoutputfile = fileoutputdir + '/' + item + '-' + str(index)
        os.system("mv " + item + ' ' + fileoutputfile)


if __name__=="__main__":
  global run_number
  assert len(sys.argv) == 4, "Usage: python3 faultinject.py <binary> <num_runs> <input_args>"
  progbin = os.path.join(progbin, sys.argv[1].lstrip("./"))  # remove leading './'
  run_number = int(sys.argv[2])
  optionlist = sys.argv[3].split(' ')
  print("DEBUG: Running", progbin)
  main()
  summarize_results.summarize(run_number)