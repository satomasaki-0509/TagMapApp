//
//  ViewController.swift
//  TagMapApp2
//
//  Created by Masaki Sato on 2021/04/27.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController , UITextFieldDelegate, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dispMap.delegate = self
        
        //mapView.delegate = self
        
        //Text Fieldのdelegate通知先を設定
        inputText.delegate = self
        
        
    }


    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    func mapView(_mapView: MKMapView, didSelect view: MKAnnotationView) {
        
          if let annotation = view.annotation{
              print(annotation.title!!)
            
          }
//        let img01 = UIImageView(image: UIImage(named: "IMG_6168"))
//        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.view.addSubview(img01)
        
      }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // キーボードを閉じる（１）
        textField.resignFirstResponder()
        
        //　入力された文字を取り出す（２）
        if let searchKey = textField.text{
            // 入力された文字をデバックエリアに表示（３）
            print(searchKey)
            
            // CLGeocoderインスタンスを取得（５）
            let geocoder = CLGeocoder()
            
            // 入力された文字から位置情報を取得（６）
            geocoder.geocodeAddressString(searchKey , completionHandler: { (placemarks, error) in
                
                //位置情報が存在する場合は、unwrapPlacemarksに取り出す（７）
                if let unwrapPlacemarks = placemarks {
                    
                    //1件目の情報を取り出す（８）
                    if let firstPlacemark = unwrapPlacemarks.first{
                        
                        // 位置情報を取り出す（９）
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から緯度経度をtargetCoordinateに取り出す（１０）
                            let targetCoordinate = location.coordinate
                            
                            // 緯度経度をデバッグエリアに表示（１１）
                            print(targetCoordinate)
                            
                            // MKPointAnnotationインスタンスを取得し、ピンを生成（１２）
                            let pin = MKPointAnnotation()
                            
                            // ピンの置く場所に緯度経度を設定（１３）
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルを設定（１４）
                            pin.title = searchKey
                        
                            
                            // ピンを地図に置く（１５）
                            self.dispMap.addAnnotation(pin)
                            
                            
                            
                            // ピンに吹き出しを出す
//                            pin.title = "\(mapView.annotations.count)"
                            
                            
                          
                            
                            // ピンを押下
                            
//                            if let annotation = view.annotation{
//                                print(annotation.title!!)
//                                let img01 = UIImageView(image: UIImage(named: "IMG_6168"))
//                                 img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//                                 self.view.addSubview(img01)
//                            }
                        
                            
                           // let img01 = UIImageView(image: UIImage(named: "IMG_6168"))
                           // img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                            //self.view.addSubview(img01)
                            
                            
                            
                            // 緯度経度を中心にして半径500mの範囲を表示（１６）
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    
                        func didReceveMemoryWarning(){
                            super.didReceiveMemoryWarning()
                        }
                        
                    }
                }
                
            })
        }
        
        //  デフォルト動作を行うのでtrueで返す（４）
        return true
}
    
    

}
