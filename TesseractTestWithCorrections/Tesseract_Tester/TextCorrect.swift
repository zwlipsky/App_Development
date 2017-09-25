//
//  TextCorrect.swift
//  Tesseract_Tester
//
//  Created by Cody Fizette on 9/25/17.
//  Copyright © 2017 Cody Fizette. All rights reserved.
//

import Foundation

var dict : [String] = []

// Calculates string similarity
func levDis(w1: String, w2: String) -> Int {
    
    let (t, s) = (w1.characters, w2.characters)
    
    let empty = Array<Int>(repeating:0, count: s.count)
    var last = [Int](0...s.count)
    
    for (i, tLett) in t.enumerated() {
        var cur = [i + 1] + empty
        for (j, sLett) in s.enumerated() {
            cur[j + 1] = tLett == sLett ? last[j] : min(last[j], last[j + 1], cur[j])+1
        }
        last = cur
    }
    //print(last)
    return last.last!
}

func findSimilarString(s1: String, dictionary: [String]) -> String {
    // Define threshold for good match
    let thresh: Float64 = 0.5
    var score: Float64 = 1000 // Some rediculous number... lower is better
    var bestMatch: String = ""
    // Find the best match
    for e in dictionary{
        let newScore = Float64(levDis(w1: s1, w2: e))
        if newScore < score {
            score = newScore
            bestMatch = e
        }
    }
    // Convert # of differences to percentage
    score = score/Float64(bestMatch.characters.count)
    print("Best match")
    print(bestMatch)
    print("score of:")
    print(score)
    print("-------------------------")
    if score < thresh {
        return bestMatch
    }else{
        return "NMF"
    }
}

// Used to convert recognized text to array
func textToArray(text: String) -> [String]{
    let text = text.replacingOccurrences(of: "\n", with: " ")
    let charSet = CharacterSet(charactersIn: ".,:;/'")
    print("String Array")
    print(text.components(separatedBy: charSet))
    
    return text.components(separatedBy: charSet)
}

// Used to make new array of closest matches
func replaceStrings(stringArray: [String], dictionary: [String]) -> [String]{
    var newArray: [String] = []
    // For each element in array, replace with closest match
    for s in stringArray{
        print("Text from image")
        print(s.trimmingCharacters(in: .whitespaces))
        newArray.append(findSimilarString(s1: s.uppercased().trimmingCharacters(in: .whitespaces), dictionary: dictionary))
        
        print(newArray)
    }
    return newArray
}

// Call this in viewDidLoad function <--------------
func loadDict(path : String){
    if let path = Bundle.main.path(forResource: path, ofType: "txt"){
        do{
            let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            dict = data.components(separatedBy: "\n")
        } catch{
            print(error)
        }
    }
}
