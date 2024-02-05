//
//  NetworkManager.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 03/02/24.
//

import Foundation
import Combine
import UIKit

//MARK: - UIImage - load Image
extension UIImage {
    convenience init?(urlString: String?) async {
        guard let url = URL(string: urlString ?? "") else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.init(data: data)
        } catch {
            print("Error fetching image: \(error)")
            self.init(systemName: "photo")
        }
    }
}


class NetworkManager {
    
    var cancellables =  Set<AnyCancellable>()
    var subscription: AnyCancellable?
    var wcElement: WelcomeElement?
    
    
    func fetchData(completionHandler : @escaping (() -> Void)) async throws {
        let urlString = "https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [WelcomeElement].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    print("finished!!")
                case .failure(let error):
                    print("There was an error \(error)")
                }
            } receiveValue: { [weak self] welcomeElement in
                self?.wcElement = welcomeElement[0]
                completionHandler()
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
