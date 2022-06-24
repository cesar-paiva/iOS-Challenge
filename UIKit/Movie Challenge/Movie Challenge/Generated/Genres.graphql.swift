// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetGenresQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetGenres {
      genres
    }
    """

  public let operationName: String = "GetGenres"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("genres", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(genres: [String]) {
      self.init(unsafeResultMap: ["__typename": "Query", "genres": genres])
    }

    public var genres: [String] {
      get {
        return resultMap["genres"]! as! [String]
      }
      set {
        resultMap.updateValue(newValue, forKey: "genres")
      }
    }
  }
}
