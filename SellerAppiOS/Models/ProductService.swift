import Foundation

class ProductService {
    private let apiURL = "https://run.mocky.io/v3/0d3f5911-1041-411b-ae9b-df0113e6a02c"
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        print("API Called")
        guard let url = URL(string: apiURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response.data.items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// Root structure for JSON response
struct Response: Codable {
    let status: String
    let data: DataWrapper
}

struct DataWrapper: Codable {
    let items: [Product]
}
