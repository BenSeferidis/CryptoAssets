//
//  APICaller.swift
//  CryptoAssets
//
//  Created by Ben Seferidis on 11/10/22.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    public struct Constants {
        static let url = "https://public.arx.net/~chris2/nfts.json"
    }
    
   // private init(){}
    
    
    public func parseJSON(completion:@escaping (Result<[Crypto], Error>) -> Void )
    {
        guard let url = URL(string:Constants.url)else{
            return
        }
        
        
        
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            
           print(response)
            print("here")
            guard let data = data , error == nil else{
                print("something went wrong")
                return
            }
            print("here1")
            //mexri edo exoume parei ta data kai tora me to do-catch tha ta kanoume convert se object
            do{
                //Decode the response
                print("here2")
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                print("here3")
                completion(.success(cryptos))
            }catch{
                completion(.failure(error))
            }
            
            
        }
        
        task.resume()
        
    }
    
//    public func getAllIcons(){
//        guard let url = URL(string: "https://public.arx.net/~chris2/nfts.json ")else{
//            return
//        }
//        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
//            
//           print(response)
//            print("here")
//            guard let data = data , error == nil else{
//                print("something went wrong")
//                return
//            }
//            print("here1")
//            //mexri edo exoume parei ta data kai tora me to do-catch tha ta kanoume convert se object
//            do{
//                //Decode the response
//                print("here2")
//                let icons = try JSONDecoder().decode([Icons].self, from: data)
//                print("here3")
//               
//            }catch{
//             
//            }
//            
//            
//        }
//        
//        task.resume()
//    }
}
