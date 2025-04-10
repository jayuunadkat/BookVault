//
//  NetworkConstants.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//


///`NetworkConstants`
public class NetworkConstants {
    private init() {}
    public static var shared: NetworkConstants = .init()
    
    #if DEBUG
    public var environment: APIEnvironments = .Production
    #else
    public var environment: APIEnvironments = .Production
    #endif
}

public extension NetworkConstants {
    enum APIEnvironments: String, CaseIterable, Equatable {
        case Production
        public var serverBaseURL: String {
            switch self {
            case .Production:
                return "https://gutendex.com/"
            }
        }
    }
}

extension NetworkConstants {
    ///`ApiKeys`
    struct ApiHeaders {
        static let kContentType                 = "Content-Type"
    }
}
