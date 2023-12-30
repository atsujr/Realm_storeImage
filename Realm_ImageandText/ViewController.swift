import UIKit
import RealmSwift

class ViewController: UIViewController {
    let realm = try! Realm()
    var tweets = [Tweet]()

    @IBOutlet weak var tweetTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        gettweet()
    }

    func gettweet() {
        tweets = Array(realm.objects(Tweet.self)).reversed()
        tweetTableView.reloadData()
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TweetTableViewCell
        let tweet: Tweet = tweets[indexPath.row]
        cell.setTweet(tweetText: tweet.tweetText, tweetImageURL: tweet.tweetImageName)
        return cell
    }


}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
