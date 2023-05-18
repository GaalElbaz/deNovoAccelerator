# Defines.
K = 16  # Length of kmer.
N = 255 # A constant used in hash function.
myDNAdictionary = {'A': '0', 'T': '1', 'G': '2', 'C': '3'}
myBinarydictionary = {'0': '00', '1': '01', '2': '10', '3': '11'}

# For SV coding TB.
# Converts DNA sequence to decimal number.
def dnaToDecimal(dnaSeq):
    newStr = ""
    for c in dnaSeq:
        newStr += myDNAdictionary[c]
    return newStr

def invertToBinary(elem):
    newElem = ""
    for c in elem:
        newElem += myBinarydictionary[c]
    return newElem

def shingleForSV(dnaSeq, seqOneFlag):
    shingle_set = []
    for i in range(len(dnaSeq) - K + 1):
        shingle_set.append(dnaSeq[i:i + K])
    if (seqOneFlag):
        for idx, elem in enumerate(shingle_set):
            newElem = invertToBinary(elem)
            print("		kmersSeqOne[" + str(idx) + "]= 32'b" + str(newElem) + ";")
    else:
        for idx, elem in enumerate(shingle_set):
            newElem = invertToBinary(elem)
            print("		kmersSeqTwo[" + str(idx) + "]= 32'b" + str(newElem) + ";")

def shingleForPY(dnaSeq):
    shingle_set = []
    for i in range(len(dnaSeq) - K + 1):
        shingle_set.append(dnaSeq[i:i + K])
    return shingle_set

def hashModule(mySet, randA, randB):
    hashRes = []
    for elem in mySet:
        res = (((int(elem) & randA) | randB) % N)
        hashRes.append(res)
    return hashRes

def findMin(resArray):
    currMin = 255
    minRes = 0
    for res in resArray:
        if (res < currMin):
            currMin = res
            minRes = res
    return minRes

def checkJaccard(minSeqOne, minSeqTwo):
    if (minSeqOne == minSeqTwo):
        return 1
    return 0

def shingleToBinaryToDecimal(shingleSet):
    newShingle = []
    for elem in shingleSet:
        newShingle.append(int(invertToBinary(elem),2))
    return newShingle

seqOneDna = "GATCGGATTGCCTAGTGATAAGTCGATGAATGCCGATAGATTTGAGCGGCAAGTTGCGTAGTCG"
# shingleForSV(dnaToDecimal(seqOneDna), True)
seqTwoDna = "GATCGATGTCGAGTCCAGTCCCCCCCCCCCGATGATGACGGTTGGACCGCCCCCCCCCCAGTTG"
# shingleForSV(dnaToDecimal(seqTwoDna), False)
seqOne = shingleToBinaryToDecimal(shingleForPY(dnaToDecimal(seqOneDna)))
seqTwo = shingleToBinaryToDecimal(shingleForPY(dnaToDecimal(seqTwoDna)))
randA = [10323, 2324, 358771, 409712, 94390, 2229481, 123, 1441]
randB = [10091, 1, 233, 76423, 4232409, 57554, 2231130, 1091]
jaccardSim = 0
for i in range(8):
    resHashOne = hashModule(seqOne, randA[i], randB[i])
    resHashTwo = hashModule(seqTwo, randA[i], randB[i])
    minSeqOne = findMin(resHashOne)
    minSeqTwo = findMin(resHashTwo)
    jaccardSim += checkJaccard(minSeqOne, minSeqTwo)
# print("Jaccard similarity is:", jaccardSim)


def printRandomForSV(randA, randB):
    print("		randA = ", randA, ";")
    print("		randB = ", randB, ";")
for i in range(8):
    printRandomForSV(randA[i], randB[i])

# shingleForSV(dnaToDecimal("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"),True)
# shingleForSV(dnaToDecimal("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"),False)
# shingleForSV(dnaToDecimal("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"), False)

# str = "1010101100111001010100111100111001100100011111011001"
# print(len(str))
# print(invertToBinary(dnaToDecimal("AATG")))
