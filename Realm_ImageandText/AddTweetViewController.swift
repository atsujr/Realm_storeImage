import Foundation
import UIKit
import RealmSwift

class AddTweetViewController: UIViewController {
    @IBOutlet weak var tweetTexTextField: UITextField!
    @IBOutlet weak var tweetIamgeImageview: UIImageView!

    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTexTextField.delegate = self

    }

    @IBAction func saveTweet(_ sender: Any) {
        saveInputText()
    }
    @IBAction func addImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
        self.present(picker, animated: true)
    }

    func saveInputText() {
        guard let setTweetText = tweetTexTextField.text else {return}

        let tweet = Tweet()
        tweet.tweetText = setTweetText
        if let setTweetImage = tweetIamgeImageview.image{
            let tweetImageurl = saveImage(image: setTweetImage)
            tweet.tweetImageName = tweetImageurl
        }
        try! realm.write({
            realm.add(tweet)
        })
    }
    // 画像を保存するメソッド
    func saveImage(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }

        do {
            let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
            let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
            try imageData.write(to: imageURL) // imageURLに画像を書き込む
            return fileName
        } catch {
            print("Failed to save the image:", error)
            return nil
        }
    }
    // URLを取得するメソッド
    func getImageURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
}
extension AddTweetViewController: UITextFieldDelegate {
    //キーボードをreturnで閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tweetTexTextField.resignFirstResponder()
        return true
    }
    //キーボードを画面タップで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension AddTweetViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            tweetIamgeImageview.image = selectedImage
        }
        self.dismiss(animated: true)
    }
}
extension AddTweetViewController: UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
