//
//  ServerClient.swift
//  BloodPresureAvg
//
//  Created by Kuan on 2022/8/2.
//

import Foundation

struct BloodPressureDM: Codable {
    var userName: String
    var firstDiastolic: String
    var secondDiastolic: String
    var firstSystolic: String
    var secondSystolic: String
    var firstPulse: String
    var secondPulse: String
}

struct CalResult: Codable {
    var encryptName: String
    var avgDiastolic: String
    var avgSystolic: String
    var avgPulse: String
    var pressureStatus: String
}

extension CalResult {
    static let empty = CalResult(encryptName: "", avgDiastolic: "", avgSystolic: "", avgPulse: "", pressureStatus: "")
}

extension BloodPressureDM {
    static let empty = BloodPressureDM(userName: "", firstDiastolic: "", secondDiastolic: "", firstSystolic: "", secondSystolic: "", firstPulse: "", secondPulse: "")
    static let test = BloodPressureDM(userName: "username", firstDiastolic: "123", secondDiastolic: "143", firstSystolic: "89", secondSystolic: "86", firstPulse: "79", secondPulse: "79")
}

class ServerClient: ObservableObject {
    
    @Published var userBloodPressure: BloodPressureDM = .empty
    @Published var getResult: CalResult = .empty
    
    let jsonDecoder: JSONDecoder
    let jsonEncoder: JSONEncoder
    
    init() {
        self.jsonDecoder = JSONDecoder()
        self.jsonEncoder = JSONEncoder()
    }
    
    var baseURL = URL(string: "http://127.0.0.1:8080")
    
    
    func getHello() async throws {
        do {
            guard let url = baseURL?.appendingPathComponent("hello") else { return }
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            print(data.description)
            guard let responBody = String(data: data, encoding: .utf8) else {
                return
            }
            print(responBody)
        }
    }
    
    @MainActor
    func getBloodAvgWithUserInfo(userData: BloodPressureDM) async throws {
        do {
            guard let url = baseURL?.appendingPathComponent("bloodCal") else { return }
            
            //Encode
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? jsonEncoder.encode(userData)
            request.httpBody = jsonData
//            request.setValue("Content-Length", forHTTPHeaderField: jsonData.description)
            
            let (data, _) = try await URLSession.shared.data(for: request)
//            guard let responseBody = String(data: data, encoding: .utf8) else {
//                return
//            }
//            print(responseBody.description)
            let decodeData = try jsonDecoder.decode(CalResult.self, from: data)
//            debugPrint("encrypt user: \(decodeData.encryptName)")
//            debugPrint("response body: \(responseBody.debugDescription)")

            //        return responseBody
            self.getResult = decodeData
        } catch {
            print(error)
        }
    }
}
