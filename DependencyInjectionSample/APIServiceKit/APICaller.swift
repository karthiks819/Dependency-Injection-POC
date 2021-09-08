//
//  APICaller.swift
//  DependencyInjectionSample
//
//  Created by Karthik on 08/09/21.
//

import Foundation

public final class APICaller {
    public static let shared = APICaller()
    private init() {
        
    }
    public func fetchCourses(completion: @escaping ([String])->Void) {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php")else {
            completion([])
            return
        }
        
        _ = URLSession.shared.dataTask(with: url) { data, resp, err in
            if let data = data {
                do {
                    guard let respObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:String]] else {
                        completion([])
                        return
                    }
                    let strArr = respObj.compactMap({$0["name"]})
                    print(strArr)
                    completion(strArr)
                }catch{
                    completion([])
                }
            }
            
        }.resume()
    }
}
