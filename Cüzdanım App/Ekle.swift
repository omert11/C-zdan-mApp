//
//  Ekle.swift
//  Cüzdanım App
//
//  Created by MacUser on 25.09.2018.
//  Copyright © 2018 MacUser. All rights reserved.
//

import UIKit
import CoreData

class Ekle: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return spinnerarray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return spinnerarray[row]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return harcamatablearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let satir = UITableViewCell()
        satir.textLabel?.text=harcamatablearray[indexPath.row]
        return satir
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        harcamatablearray.remove(at: indexPath.row)
        Ekletable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        tablefiyat.remove(at: indexPath.row)
        toplamdegis()
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Sil"
    }
    @IBOutlet weak var Ekletable: UITableView!
    @IBOutlet weak var ekletx: UITextField!
    @IBOutlet weak var toplamharcama: UILabel!
    @IBOutlet weak var eklespin: UIPickerView!
    var harcamatablearray=[String]()
    var tablefiyat=[Float]()
    var spinnerarray=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Ekletable.delegate = self
        Ekletable.dataSource = self
        eklespin.dataSource = self
        eklespin.delegate = self
        spinarayata()
        
    }
    func spinarayata() {
        spinnerarray.append("Ev")
        spinnerarray.append("Telefon")
        spinnerarray.append("Akar yakit")
        spinnerarray.append("Egelence")
        spinnerarray.append("Yemek")
        spinnerarray.append("Kisisel Ihtiyac")
    }
    @IBAction func eklebtn(_ sender: Any) {
        if let parastg = ekletx.text{
            if let para=Float(parastg){
                let secim = eklespin.selectedRow(inComponent: 0)
                let harcamasekli = spinnerarray[secim]
                harcamatablearray.append(parastg + "-TL      "+harcamasekli)
                self.Ekletable.beginUpdates()
                self.Ekletable.insertRows(at: [IndexPath(row: harcamatablearray.count-1, section: 0)], with: .automatic)
                self.Ekletable.endUpdates()
                tablefiyat.append(para)
                toplamdegis()
            }else{
                let hata = UIAlertController.init(title: "Hata", message: "Geçerli Bir Para Birimi giriniz", preferredStyle: UIAlertController.Style.alert)
                let tamam = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
                hata.addAction(tamam)
                self.present(hata, animated: true, completion: nil)
            }
            //kaydet()
        }
    }
    func kaydet() {
        let appdelagete = UIApplication.shared.delegate as! AppDelegate
        let contecx = appdelagete.persistentContainer.viewContext
        let yeniData = NSEntityDescription.insertNewObject(forEntityName: "Eklenen", into: contecx)
        yeniData.setValue(tablefiyat, forKey: "paraflt")
        yeniData.setValue(harcamatablearray, forKey: "list")
        do{
           try contecx.save()
        }catch{
            print("hata")
        }
        

    }
    func toplamdegis() {
        var  toplam = Float(0)
        for para in tablefiyat {
            toplam += para
        }
        toplamharcama.text=String(toplam)
    }
}
