//
//  APIManager.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//


import UIKit
import SystemConfiguration
import SwiftUI
import Alamofire

//MARK: - APIManager
final class APIManager {
    static let shared = APIManager()

    var defaultHeaders: HTTPHeaders {
        get {
            return [
                NetworkConstants.ApiHeaders.kContentType   : "application/json"
            ]
        }
    }
    
    private init() {
///        print(UserDefaults.standard.dictionaryRepresentation())
    }
}


//MARK: - GET API Request Call
///`Get API Request`
extension APIManager {
    func getApiRequest<T: Codable>(
        manualHeaders: [String: String]? = nil,
        queryParams: [String: String]? = nil,
        urlString: String,
        type: T.Type
    ) async throws -> (response: T, responseHeaders: [AnyHashable: Any]) {
        let headers: HTTPHeaders = manualHeaders == nil ? defaultHeaders : HTTPHeaders(manualHeaders!)
        
        guard var urlComponents = URLComponents(string: urlString) else {
            throw APIError.invalidURL
        }

        if let queryParams = queryParams, !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        guard isConnectedToNetwork() else {
            throw APIError.noInternet
        }

        printCurl(headers: headers, queryParams: queryParams, url: url)

        let response = await AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers
        ) { $0.timeoutInterval = 300 }
            .serializingDecodable(T.self).response

        Logger.logResponse(ofAPI: url.absoluteString, logType: .info, object: response.data?.prettyPrintedJSONString ?? "")
        switch response.result {
        case .success(let data):
            return (data, response.response?.allHeaderFields ?? [:])
        case .failure(let error):
            let customMessage = response.response?.statusCode == 401
            ? "Unauthorized access. Please login again."
            : error.localizedDescription

            Logger.log(logType: .error, object: error.localizedDescription)
            throw APIError.serverError(customMessage)
        }
    }

    private func printCurl(headers: HTTPHeaders, queryParams: [String: String]?, url: URL) {
#if DEBUG
        var curlCommand = "curl -X GET "
        headers.forEach { header in
            curlCommand += "-H \"\(header.name): \(header.value)\" "
        }
        curlCommand += "\(url)"
        print("curl command:\n******************\n\(curlCommand)\n******************\n")
#endif
    }
}
