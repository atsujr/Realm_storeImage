import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet var tweetTextLabel: UILabel!
    @IBOutlet var tweetImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setTweet(tweetText: String?, tweetImageURL: String?) {
        
        tweetTextLabel.text = tweetText
        // 画像のパスを取得
        if let tweetImageName = tweetImageURL {
            let path = getImageURL(fileName: tweetImageName).path
            if FileManager.default.fileExists(atPath: path) { //pathにファイルが存在しているかチェック
                if let imageData = UIImage(contentsOfFile: path) {  //pathに保存されている画像を取得
                    tweetImageView.image = imageData
                } else {
                    print("Failed to load the image. path = ", path)
                }
            } else {
                print("Image file not found. path = ", path)
            }
        }
    }
    func getImageURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
}
