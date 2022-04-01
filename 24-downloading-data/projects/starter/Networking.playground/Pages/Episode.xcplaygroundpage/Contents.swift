//: ## Episode
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

struct EpisodeStore: Decodable {
    var episodes: [Episode] = []
    
    enum CodingKeys: String, CodingKey {
        case episodes = "data"
    }
}

struct Episode: Decodable, Identifiable {
    let id: String
    let attributes: Attributes
}

struct Attributes: Codable {
    let name: String
    let released_at: Date
}

let baseURLString = "https://api.raywenderlich.com/api/"
var urlComponents = URLComponents(string: baseURLString + "contents/")!
var baseParams = [
    "filter[subscription_types][]": "free",
    "filter[content_types][]": "episode",
    "sort": "-popularity",
    "page[size]": "20",
    "filter[q]": ""
]
urlComponents.setQueryItems(with: baseParams)
urlComponents.queryItems! += [URLQueryItem(name: "filter[domain_ids][]", value: "1")]
urlComponents.url?.absoluteString

let contentURL = urlComponents.url!

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(.apiDateFormatter)

URLSession.shared.dataTask(with: contentURL) { data, response, error in
    defer { PlaygroundPage.current.finishExecution() }
    if let data = data, let response = response as? HTTPURLResponse {
        print(response.statusCode)
        if let decodedResponse = try? decoder.decode(EpisodeStore.self, from: data) {
            DispatchQueue.main.async {
                let date = decodedResponse.episodes[0].attributes.released_at
                DateFormatter.episodeDateFormatter.string(from: date)
            }
        }
        return
    }
    print("Contents fetch failed: " + "\(error?.localizedDescription ?? "Unknown error")")
}.resume()


//: [VideoURL ->](@next)

/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
//: [VideoURL ->](@next)
