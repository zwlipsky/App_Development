//
//  getMendeley.swift
//  
//
//  Created by May on 9/25/17.
//
//

import Foundation
import UIKit
import PlaygroundSupport


class askMendeley {
    
    var token:String = ""
    var folder_ID:String = ""
    var lookThisUp:String = ""
    var docIDs = [String]()
    
    let refreshCode = "MSw0OTM3NzYwMzEsMTAyOCxhbGwsNWQwMjdkYjQyYzg2YjE0OWVlMzhiOWU4MjA1NjZlMTE1Y2VhZ3hycWIsZDEyNC03Yjk2OWZjN2Q1MTU0OGQwMTg1NWJmN2E1M2IwNTBiMDdmMi1FLDE1MDEwNDE1NzIxMzEsZWFlYzc4OTEtYzRjNi0zZmIxLWI5ZTQtZjE5MzFlNTlhN2E2LDE0MW1QcVlBemQ0OWJIZXktV2JxLTJ6MXFyOA"
    
    let folderLookUpFromGroupURL = "https://api.mendeley.com/folders?group_id=f554e56b-24ec-3318-89eb-29050b566947"
    let documentsLookUpFromFolderURL = "https://api.mendeley.com/folders/"
    let annotLookUpFromDocumentURL = "https://api.mendeley.com/annotations?document_id="
    
    func APIcall(callURL: String, keyword: String, completion: @escaping (Any) -> Void) {
        var urlRequest = URLRequest(url: URL(string: callURL)!)
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling GET method")
                return
            }
            guard let responseData = data else {
                print("error getting data")
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: responseData) {
                completion(json)
                return
            }
        }
        task.resume()
    }
    
    func refreshToken(completion: @escaping (String) -> Void) {
        var refreshRequest = URLRequest(url: URL(string: "https://api.mendeley.com/oauth/token")!)
        refreshRequest.httpMethod = "POST"
        let postString = "grant_type=refresh_token&refresh_token=" + refreshCode + "&redirect_uri=http:%2F%2Flocalhost&client_id=4588&client_secret=5iA3cwFIIYCZPLUd"
        refreshRequest.httpBody = postString.data(using: .utf8)
        let refreshTask = URLSession.shared.dataTask(with: refreshRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling GET method")
                return
            }
            guard let responseData = data else {
                print("error getting data")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: responseData) as! [String: Any]
            let accessToken = json?["access_token"] as! String
            self.token = "Bearer " + accessToken
            completion(self.token)
            return
        }
        refreshTask.resume()
    }
    
    func getListOfIngredients(_ json: Any) {
        let listOfIngredients = json as? [Any]
        
        //listOfIngredients contains the array of folders, named by the ingredient. It is an array of dictionaries containing metadata of each folder. We match the "name" field to the ingredient in search:
        for entry in listOfIngredients! {
            let ingredientInfo = entry as! [String: String]
            if lookThisUp == ingredientInfo["name"] {
                print(ingredientInfo["name"]!)
                self.folder_ID = ingredientInfo["id"]!
            }
        }
    }
    
    func displayNotes(_ keyword: String, _ annotArray: [Any] ) -> [String] {
        var resultNotes = [String]()
        for notes in annotArray {
            let docAnnot = notes as! [String: String]
            let doc_notes = docAnnot["text"]
            let lineBroken = doc_notes!.replacingOccurrences(of: "<[^>]+>", with: "\n", options: String.CompareOptions.regularExpression, range: nil)
            let separatedByTopic = lineBroken.components(separatedBy: "/BREAK/")
            for component in separatedByTopic {
                if component.range(of: keyword) != nil {
                    let notes = component.replacingOccurrences(of:keyword + ": ", with:"", options: NSString.CompareOptions.literal, range: nil)
                    print(notes)
                    resultNotes.append(notes)
                }
            }
        }
        return resultNotes
    }
    
    
    func getDocumentID(_ json: Any) {
        let listOfDocuments = json as? [Any]
        for document in listOfDocuments! {
            let docInfo = document as? [String:String]
            let doc_ID = docInfo!["id"]
            self.docIDs.append(doc_ID!)
        }
    }
    
}


//the following codes are for testing. Change testing.lookThisUp variable to the name of an ingredient; the selected ingredient from the OCR output will be assigned to this variable
//var testing = askMendeley()
//testing.lookThisUp = "Aloe barbadensis leaf juice"


//testing.refreshToken() { (json) in
//    var token = testing.token
    
//    testing.APIcall(callURL: testing.folderLookUpFromGroupURL, keyword: testing.lookThisUp) { (json) in
        
        
//        testing.getListOfIngredients(json)
        
        //we obtained the ID of the folder the name of which matches the ingredient in search. We take this folder ID to query all documents inside it, and get their IDs:
//        testing.APIcall(callURL: testing.documentsLookUpFromFolderURL + testing.folder_ID + "/documents", keyword: testing.lookThisUp) { (json) in
//            testing.getDocumentID(json)
            
            //we now have the ID of each paper (document) that contains information about the ingredient that we want to deliver to the user. Using the document ID, we will get the annotations associated with the document:
//            for id in testing.docIDs {
//                testing.APIcall(callURL: testing.annotLookUpFromDocumentURL + id, keyword: testing.lookThisUp) { (json) in
//                    let annotationsArray = json as? [Any]
//                    testing.displayNotes(testing.lookThisUp, annotationsArray!)
//                }
//            }
//        }
//    }
//}
