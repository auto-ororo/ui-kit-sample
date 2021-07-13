//
//  SelectImageViewController.swift
//  UiKitSample
//
//  Created by Ryo Narisawa on 2021/07/12.
//

import Foundation
import UIKit
import AVKit

class SelectImageViewController: ViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private lazy var libraryImagePicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        picker.delegate = self
        return picker
    }()
    
    private lazy var takePhotoImagePicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.showsCameraControls = true
        picker.delegate = self
        return picker
    }()
    
    private let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("chosenImage.jpg")

    @IBOutlet weak var imageLabel: UIImageView!

    @IBAction func selectButton(_ sender: UIButton) {
        self.showActionSheet()
    }
    
    override func viewDidLoad() {
        let readData = try! Data(contentsOf: url)
        imageLabel.image = UIImage(data: readData)
    }
    
    // ActionSheetを表示
    private func showActionSheet() {
        let alert: UIAlertController = UIAlertController(title: "画像を選択", message: nil, preferredStyle:  UIAlertController.Style.actionSheet)

        // カメラロール
        let cameraRollAction: UIAlertAction = UIAlertAction(title: "カメラロール", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("カメラロール")
            
            self.present(self.libraryImagePicker, animated: true, completion: nil)
        })
        
        // 撮影
        let takePictureAction: UIAlertAction = UIAlertAction(title: "撮影", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            
            if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
                    AVCaptureDevice.requestAccess(for: .video) { isAuthorized in
                        DispatchQueue.main.async {
                            if isAuthorized {
                                self.present(self.takePhotoImagePicker, animated: true, completion: nil)
                            } else {
                                // 権限が許可されていない場合は設定画面に遷移
                                self.showSettingAlert()
                            }
                        }
                    }
            } else {
                self.present(self.takePhotoImagePicker, animated: true, completion: nil)
            }
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel)

        // Actionを追加
        alert.addAction(cameraRollAction)
        alert.addAction(takePictureAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    private func showSettingAlert() {
        let alert = UIAlertController(
            title: nil,
            message: "カメラ権限を許可して下さい",
            preferredStyle: .alert
        )
        let okAction: UIAlertAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: { _ in
                let url = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(url!, options: [:])
            })
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }

    // 画像を取得した際に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // 取得した画像をjpgで保存し、画面上に表示
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let data = image.jpegData(compressionQuality: 0.9)!
            try! data.write(to: self.url)
            
            // カメラの場合はカメラロールに保存
            if picker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            
            imageLabel.image = UIImage(data: data)
        } else{
            print("Error")
        }

        // モーダルビューを閉じる
        self.dismiss(animated: true, completion: nil)
    }

     //画像選択がキャンセルされた時に呼ばれる.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        // モーダルビューを閉じる
        self.dismiss(animated: true, completion: nil)
    }
}
