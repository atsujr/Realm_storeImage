import Foundation
import RealmSwift

class Tweet: Object {
    @Persisted var tweetText: String?
    @Persisted var tweetImageName: String?
}
