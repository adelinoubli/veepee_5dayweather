//
//  RequestHandler.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import Moya

enum RequestHandler{
    case forecast
    case localJsonFile
}

extension RequestHandler: Moya.TargetType{
    
    var baseURL: URL{
        switch self{
        case .forecast:
            return URL(string: Constant.baseURL)!
        default:
            return URL(string: "")!
        }
    }
        
        var path: String {
            switch self {
            case.forecast:
                return  "/"
            default: return Constant.jsonFileName
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var task: Moya.Task {
            
            switch self {
            case .forecast:
                
                var params: [String: Any] = [:]
                params["q"] = Constant.cityName
                params["appid"] = Constant.APIKey
                params["units"] = Constant.units
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
                
            default: return  .requestPlain
                
            }
        }
        
        var headers: [String : String]? {
            var header :[String:String] = [:]
            switch self {
            default:
                header["Content-Type"] = "application/json"
            }
            return header
        }
        
    }
