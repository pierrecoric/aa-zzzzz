from bs4 import BeautifulSoup
import requests
import re
import urllib2
import os
import argparse
import sys
import json
import time
import signal

#Create one file to store the image adresses for each letter combination
def newTextFile():
    global currentSearch
    global textFile
    textFile = open ("urls/" + currentSearch + ".txt", "w+")
    print ("newTextFile created")
#Write each Url in a textFile
def urlWrite(currentImg, countUrl):
    global textFile
    global currentSearch
    textFile.write(currentSearch + " - " + str(countUrl) + ": " + currentImg + "\n")
#manage timeout problems
class TimeoutException(Exception):
    pass
def timeout_handler(signum, frame):
    raise TimeoutException
signal.signal(signal.SIGALRM, timeout_handler)

#This code is based on the code of genekogan https://gist.github.com/genekogan/ebd77196e4bf0705db51f86431099e57
def get_soup(url,header):
    return BeautifulSoup(urllib2.urlopen(urllib2.Request(url,headers=header)),"html.parser")

def main(searchKeyWord, saveDirectory, amountImages):
        newTextFile()
	query = searchKeyWord#raw_input(args.search)
	save_directory = saveDirectory
	image_type="Action"
	query= query.split()
	query="+".join(query)
        print("query " + query)
	url="https://www.google.co.in/search?q="+query+"&source=lnms&tbm=isch"
	header={"User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"}
	soup = get_soup(url,header)
	ActualImages=[]# contains the link for Large original images, type of  image
	for a in soup.find_all("div",{"class":"rg_meta"}):
	    link , Type =json.loads(a.text)["ou"]  ,json.loads(a.text)["ity"]
	    ActualImages.append((link,Type))
        print (len(ActualImages))
        for i , (img , Type) in enumerate( ActualImages[0:amountImages]):
            signal.alarm(9)
            try:
                req = urllib2.Request(img, headers={"User-Agent" : header})
                raw_img = urllib2.urlopen(req).read()
                print("img " + img)
                if len(Type)==0:
                    f = open(os.path.join(saveDirectory, searchKeyWord + "_"+ str(i)+".jpg"), "wb")
                    urlWrite(img , i)
                    
    	        else :
                    f = open(os.path.join(saveDirectory, searchKeyWord + "_"+ str(i)+"."+Type), "wb")
                    urlWrite(img , i)
    	            f.write(raw_img)
                    time.sleep(1)
    	            f.close()

            except Exception as e:
                print "could not load : "+img
                print e
                continue
            except TimeoutException:
                continue
            else:
                signal.alarm(0)
        textFile.close
        
        
        
#generate aa_zz[]
aa_zz = []
firstLetter = (0)
secondLetter = (0)
alphabet = ("a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z" )
for i in range(26*26):
    aa_zz.append(alphabet[secondLetter] + alphabet[firstLetter])
    firstLetter += 1
    if firstLetter > 25:
        secondLetter += 1
        firstLetter = 0
count = 0
while count < (len(aa_zz)):
    count += 1

count = 567
while count < 676:
    currentSearch = aa_zz[count]
    os.mkdir("save_aa_zz/" + currentSearch)
    print (str(count) + " - " + currentSearch)
    main (currentSearch, "save_aa_zz/" + currentSearch , 75)
    count += 1
    textFile.close
