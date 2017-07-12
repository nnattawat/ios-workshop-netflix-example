//
//  NetflixClient.swift
//  TableViews
//
//  Created by Rhydian Thomas on 13/1/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Alamofire
import SwiftyJSON


/// A model struct, used to capture movie details
struct Movie {
  let showId: Double?
  let showTitle: String?
  let releaseYear: String?
  let rating: String?
  let category: String?
  let showCast: String?
  let director: String?
  let summary: String?
  let poster: String?
  let runtime: String?
}


/// Maps a movie API response to `Movie` isntances
class MovieMapper {
  func objectGraphFrom(data: Data?) -> [Movie] {
    var movies =  [Movie]()
    if let data = data {
      let json = JSON(data: data)
      for (_, movieJson):(String, JSON) in json {
        movies.append(Movie(showId: movieJson["show_id"].double, showTitle: movieJson["show_title"].string, releaseYear: movieJson["release_year"].string, rating: movieJson["rating"].string, category: movieJson["category"].string, showCast: movieJson["show_cast"].string, director: movieJson["director"].string, summary: movieJson["summary"].string, poster: movieJson["poster"].string, runtime: movieJson["runtime"].string))
      }
    }
    return movies
  }
}


/// Fetch movies from the Netflix API
class NetflixClient {
  func fetch(forActorName actor: String, completion: @escaping ([Movie]) -> Void) {
    let parameters: Parameters = ["actor": actor]
    Alamofire.request("http://netflixroulette.net/api/api.php", parameters: parameters)
      .responseString { response in debugPrint(response) }
      .responseData { response in
        if response.result.error == nil  && response.result.value != nil {
          DispatchQueue.main.async {
            completion(MovieMapper().objectGraphFrom(data: response.data))
          }
        }
      }
  }
}
