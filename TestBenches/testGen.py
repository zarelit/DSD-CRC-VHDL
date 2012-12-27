#!/usr/bin/env python2
#
# 27 Dec 2012
# Write some random numbers and their CRC to two files as
# binary strings for the CRC module testing
#

import random
import crcmod 
# Has to be installed: pip2 install crcmod

## Constants
# CRC polynomial
CRCgrade = 9
poly = 0x115 # x^8+x^4+x^2+1
# Number of bits
numBits = 56
# Amount of data
numLines = 1000
# Output file
outFile = "./testInput.txt"
outResFile = "./testOutput.txt"

## Open files
inf = open(outFile, 'w')
outf = open(outResFile, 'w')

# Generate a function that calculates the CRC with our polynomial
crc_func = crcmod.mkCrcFun(poly, initCrc=0)

# Format specifications
numFormat = "0{}b".format(numBits) # E.G. 0x05 => "0000000101"
CRCformat = "0{}b".format(CRCgrade-1)
hexFormat = "0{}x".format(numBits/4)

# Generate random numbers, calculate CRC and print them to file
# There are several format conversion because manipulations are 
# done on strings mixed with "strings representing a number"
for i in range(numLines):
	num = random.randint(0,2**numBits -1)
	formattedNum = format(num,numFormat)
	numAsString = format(num,hexFormat).decode("hex")
	crc = crc_func(numAsString)
	formattedCRC = format(crc,CRCformat)
	output = formattedNum+formattedCRC
	inf.write(formattedNum+'\n')
	outf.write(output+'\n')
	print (format(num,hexFormat))
	print (format(num,hexFormat)+format(crc,'02x'))

