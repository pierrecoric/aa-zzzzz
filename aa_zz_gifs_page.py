url1 = "https://www.google.co.in/search?q="
url2 = "&source=lnms&tbm=isch"

def createFile():
    global gifHtml
    gifHtml = open("aa_zz_gif.html", "w+")
    print("html file created")
    
def generationAaZz ():
    global aa_zz
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
            
def fillTheFile():
    for i in range (len(aa_zz)):
        content = ("<a href=\"" + url1 +  aa_zz[i] + url2 + "\" target=\"_blank\"><img src=\"{}\"></a>" .format("data/aa_zz_gifs/" + aa_zz[i] + ".gif"  ))
        print(content)
        gifHtml.write (content)
    gifHtml.close
    
generationAaZz()
createFile()
fillTheFile()
