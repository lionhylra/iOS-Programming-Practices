

import UIKit

/* String API for swift version 2.1.1 */

/* Construction */
let s = String(UnicodeScalar(65))

let str1 = String()//empty string

let nsstr:NSString = "hi"
let str2 = String(nsstr)//initialise with NSStrig

let char:Character = "H"
let str3 = String(char)//initialise with a Character

let charView:String.CharacterView = String.CharacterView("hahaa")
let str4 = String(charView)

class Person:CustomStringConvertible{
    var firstName:String
    var lastName:String
    var description:String{
        return firstName + " " + lastName
    }
    init(firstName:String, lastName:String){
        self.firstName = firstName
        self.lastName = lastName
    }
}
let aPerson = Person(firstName: "Yilei", lastName: "He")
let str5 = String(aPerson)//construct using CustomStringConvertible type

let ten = -10
let str6 = String(ten)//construct using Int

let eight:UInt = 8
let str7 = String(eight)//construct using UInt

let chars:Array<Character> = ["a","b","c","d"]
let str8 = String(chars)//construct using collection of characters

let thirty = 30
let str9 = String(thirty, radix:16, uppercase:false)//get a representation of an Integer of any base

let seven:UInt = 7
let str10 = String(seven, radix:2, uppercase:true)

let charForA:Character = "A"
let str11 = String(count: 10, repeatedValue: charForA)//repeating a character

let str12a = String(format: "There are %d A's in %@", 10, str11)
let str12b = String(format: "Ten divide twenty is %.2f", 0.5)//construct using C style format

//-----------------------

let sentence = "Hello, my name is Yilei He."
/* Transform */
sentence.capitalizedString
sentence.uppercaseString
sentence.lowercaseString

/* Verify */
sentence.hasPrefix("HEL")//case sensitive
sentence.hasPrefix("He")
sentence.hasSuffix(".")
"tomcat".containsString("cat")

"Yilei".caseInsensitiveCompare("YILei") == NSComparisonResult.OrderedSame
"unknown".commonPrefixWithString("unable", options: [NSStringCompareOptions.CaseInsensitiveSearch])

/* Presentation */

sentence.unicodeScalars
sentence.utf8
sentence.utf16

let c1 = sentence[sentence.startIndex]
c1.dynamicType
let c2 = sentence[sentence.startIndex.advancedBy(2)]
c2.dynamicType
let c3 = sentence[sentence.startIndex...sentence.startIndex.advancedBy(5)]
c3.dynamicType

let word = sentence.substringWithRange(sentence.startIndex ... sentence.startIndex.advancedBy(4))

/* Chop String */
"unbelievable".componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "ei"))
"banana".componentsSeparatedByString("n")

/* Enumerate String */
sentence.characters
for c in sentence.characters {
    print(c)
}

"This is the first line.\nThis is the second line.\nThis is the third line.".enumerateLines { (line, stop) -> () in
    print(line)
    print("=====")
}

/* Modify String */
var tiger = "tigr"
tiger.insert("e" as Character, atIndex: tiger.startIndex.advancedBy(3))
tiger.removeAtIndex(tiger.startIndex)
tiger

/* Encoding and Decoding URL String */
//"http://google.com?query=dog".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
let URL = "http://google.com/maps/australia?city=melbourne"
let escapedURL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())
let unescapedURL = escapedURL?.stringByRemovingPercentEncoding

/* Additional */
extension String {
    var length:Int {return self.characters.count}
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start: start, end: end)]
    }
    
    var reversedString:String{
        return String(self.characters.reverse())
    }
}


