// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTopMoviesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTopMovies($limit: Int!) {
      movies(limit: $limit, orderBy: "voteAverage", sort: DESC) {
        __typename
        title
        releaseDate
        voteAverage
        posterPath
      }
    }
    """

  public let operationName: String = "GetTopMovies"

  public var limit: Int

  public init(limit: Int) {
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("movies", arguments: ["limit": GraphQLVariable("limit"), "orderBy": "voteAverage", "sort": "DESC"], type: .list(.object(Movie.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(movies: [Movie?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "movies": movies.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }])
    }

    public var movies: [Movie?]? {
      get {
        return (resultMap["movies"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Movie?] in value.map { (value: ResultMap?) -> Movie? in value.flatMap { (value: ResultMap) -> Movie in Movie(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }, forKey: "movies")
      }
    }

    public struct Movie: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Movie"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("releaseDate", type: .nonNull(.scalar(String.self))),
          GraphQLField("voteAverage", type: .nonNull(.scalar(Double.self))),
          GraphQLField("posterPath", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, releaseDate: String, voteAverage: Double, posterPath: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Movie", "title": title, "releaseDate": releaseDate, "voteAverage": voteAverage, "posterPath": posterPath])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var releaseDate: String {
        get {
          return resultMap["releaseDate"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "releaseDate")
        }
      }

      public var voteAverage: Double {
        get {
          return resultMap["voteAverage"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "voteAverage")
        }
      }

      public var posterPath: String? {
        get {
          return resultMap["posterPath"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "posterPath")
        }
      }
    }
  }
}

public final class GetMoviesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMovies($limit: Int!) {
      movies(limit: $limit, orderBy: "title") {
        __typename
        title
        releaseDate
        voteAverage
        posterPath
      }
    }
    """

  public let operationName: String = "GetMovies"

  public var limit: Int

  public init(limit: Int) {
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("movies", arguments: ["limit": GraphQLVariable("limit"), "orderBy": "title"], type: .list(.object(Movie.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(movies: [Movie?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "movies": movies.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }])
    }

    public var movies: [Movie?]? {
      get {
        return (resultMap["movies"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Movie?] in value.map { (value: ResultMap?) -> Movie? in value.flatMap { (value: ResultMap) -> Movie in Movie(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }, forKey: "movies")
      }
    }

    public struct Movie: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Movie"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("releaseDate", type: .nonNull(.scalar(String.self))),
          GraphQLField("voteAverage", type: .nonNull(.scalar(Double.self))),
          GraphQLField("posterPath", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, releaseDate: String, voteAverage: Double, posterPath: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Movie", "title": title, "releaseDate": releaseDate, "voteAverage": voteAverage, "posterPath": posterPath])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var releaseDate: String {
        get {
          return resultMap["releaseDate"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "releaseDate")
        }
      }

      public var voteAverage: Double {
        get {
          return resultMap["voteAverage"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "voteAverage")
        }
      }

      public var posterPath: String? {
        get {
          return resultMap["posterPath"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "posterPath")
        }
      }
    }
  }
}

public final class GetAllMoviesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAllMovies {
      movies(orderBy: "title") {
        __typename
        title
        releaseDate
        voteAverage
        posterPath
      }
    }
    """

  public let operationName: String = "GetAllMovies"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("movies", arguments: ["orderBy": "title"], type: .list(.object(Movie.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(movies: [Movie?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "movies": movies.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }])
    }

    public var movies: [Movie?]? {
      get {
        return (resultMap["movies"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Movie?] in value.map { (value: ResultMap?) -> Movie? in value.flatMap { (value: ResultMap) -> Movie in Movie(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }, forKey: "movies")
      }
    }

    public struct Movie: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Movie"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("releaseDate", type: .nonNull(.scalar(String.self))),
          GraphQLField("voteAverage", type: .nonNull(.scalar(Double.self))),
          GraphQLField("posterPath", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, releaseDate: String, voteAverage: Double, posterPath: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Movie", "title": title, "releaseDate": releaseDate, "voteAverage": voteAverage, "posterPath": posterPath])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var releaseDate: String {
        get {
          return resultMap["releaseDate"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "releaseDate")
        }
      }

      public var voteAverage: Double {
        get {
          return resultMap["voteAverage"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "voteAverage")
        }
      }

      public var posterPath: String? {
        get {
          return resultMap["posterPath"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "posterPath")
        }
      }
    }
  }
}

public final class GetMoviesByGenreQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMoviesByGenre($genre: String!) {
      movies(genre: $genre, orderBy: "title") {
        __typename
        title
        posterPath
      }
    }
    """

  public let operationName: String = "GetMoviesByGenre"

  public var genre: String

  public init(genre: String) {
    self.genre = genre
  }

  public var variables: GraphQLMap? {
    return ["genre": genre]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("movies", arguments: ["genre": GraphQLVariable("genre"), "orderBy": "title"], type: .list(.object(Movie.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(movies: [Movie?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "movies": movies.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }])
    }

    public var movies: [Movie?]? {
      get {
        return (resultMap["movies"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Movie?] in value.map { (value: ResultMap?) -> Movie? in value.flatMap { (value: ResultMap) -> Movie in Movie(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Movie?]) -> [ResultMap?] in value.map { (value: Movie?) -> ResultMap? in value.flatMap { (value: Movie) -> ResultMap in value.resultMap } } }, forKey: "movies")
      }
    }

    public struct Movie: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Movie"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("posterPath", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, posterPath: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Movie", "title": title, "posterPath": posterPath])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var posterPath: String? {
        get {
          return resultMap["posterPath"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "posterPath")
        }
      }
    }
  }
}
