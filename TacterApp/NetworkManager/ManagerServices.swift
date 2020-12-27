//
//  ManagerServices.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import Foundation

class ManagerServices {
    static let shared = ManagerServices()

    func getChampionsList(completionHandler: @escaping ([Champion]?) -> Void) {

        let session = URLSession.shared
        var request = URLRequest(url:
                                    URL(string: MAIN_URL + CHAMPIONS_LIST_ENDPOINT)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in

            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else { return }

            if response.statusCode == 200 {
                do {
                    let champions = try JSONDecoder().decode([Champion].self, from: data)
                    completionHandler(champions)
                } catch let error {
                    print("Unknown error in call: " + "\(error)")
                    completionHandler(nil)
                }
            }
        }.resume()
    }
}
