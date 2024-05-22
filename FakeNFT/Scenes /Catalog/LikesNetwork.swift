//
//  LikesNetwork.swift
//  FakeNFT
//
//  Created by Chingiz on 19.05.2024.
//

import Foundation

final class LikesNetwork {
    private let networkClient: DefaultNetworkClient
    
    init() {
        self.networkClient = DefaultNetworkClient()
    }
    
    func getLikes(completion: @escaping (Likes?) -> Void) {
        networkClient.send(request: LikesRequest(), type: Likes.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let likes):
                    print("Успешно получены данные о лайках")
                    completion(likes)
                case .failure(let error):
                    print("Ошибка при получении данных о лайках: \(error)")
                    completion(nil)
                }
            }
        }
    }
    
    func sendNewOrder(nftsIds: [String], completion: @escaping (Error?) -> Void) {
        let bodyDict: [String: Any] = ["nfts": nftsIds]
        guard let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict, options: []) else { return }
        
        guard let url = URL(string: "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net/api/v1/profile/1") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("9db803ac-6777-4dc6-9be2-d8eaa53129a9", forHTTPHeaderField: "X-Practicum-Mobile-Token")
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка при отправке запроса: \(error)")
                completion(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Статус код ответа сервера: \(httpResponse.statusCode)")
                if (200...299).contains(httpResponse.statusCode) {
                    print("Успешно отправлен новый запрос")
                    completion(nil)
                } else {
                    print("Ошибка сервера: \(httpResponse.statusCode)")
                    let serverError = NSError(domain: "Server Error", code: httpResponse.statusCode, userInfo: nil)
                    completion(serverError)
                }
            }
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Данные ответа: \(responseString ?? "Нет данных ответа")")
            }
        }
        task.resume()
    }
}
