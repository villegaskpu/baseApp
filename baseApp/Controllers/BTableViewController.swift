//
//  BTableViewController.swift
//  SeekOp
//
//  Created by Erick Daniel Rodríguez Liceaga on 27/03/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.
//

import UIKit

@objc
protocol BTableViewDelegate {
    @objc optional func BTableView(tableItems: InfoManager, spinnerItemAt indexPath: IndexPath, indexPathItem: IndexPath, spinnerName: String)
    @objc optional func BTableView(tableItems: InfoManager, observationsDidChange text: String, indexPath: IndexPath)
    @objc optional func BTableView(tableItems: InfoManager, textFieldDidChange text: String, indexPath: IndexPath)
    @objc optional func BTableView(tableItems: InfoManager, buttonPressedAt indexPath: IndexPath)
    //delegados de la celda de teléfonos
    @objc optional func BTableView(tableItems: InfoManager, telefonoDidEndEditing indexPath: IndexPath)
    
    //delegados de la celda del correo
    @objc optional func BTableView(tableItems: InfoManager, correoShowspinnerDel indexPath: IndexPath)
    @objc optional func BTableView(tableItems: InfoManager, correoDidEndEditing indexPath: IndexPath)
    
    // delegado de la barra de status
    @objc optional func BTableView(tableItems: InfoManager, StatusBarOnItemSelected indexPath: Int)
    @objc optional func BTableView(tableItems: InfoManager, statusBarChange at: IndexPath, idStatus: String)
    
    // delegado del datepiker
    @objc optional func BTableView(tableItems: InfoManager, dateSelected indexPath: IndexPath)
    // delegado del checkbox
    @objc optional func BTableView(tableItems: InfoManager, checkBoxPressed indexPath: IndexPath)
    // delegado del RASS
    @objc optional func BTableView(tableItems: InfoManager, checkBoxPressedRass indexPath: IndexPath)
    // delegado del checkbox derecho
    @objc optional func BTableView(tableItems: InfoManager, checkBoxDerechoActive indexPath: IndexPath)


    // delegado del two radio
    @objc optional func BTableView(tableItems: InfoManager, selectRadio indexPath: IndexPath)
    // delegado del 3 radio
    @objc optional func BTableView(tableItems: InfoManager, radioDidSelect3 selectRadio3: String, indexPath: IndexPath)
    // delegado del customCheck
    @objc optional func BTableView(tableItems: InfoManager, returnValoresCheck texto: String, valor: String, indexPath: IndexPath)
    // delegado del auto interes en venta
    @objc optional func BTableView(tableItems: InfoManager, selectAutoInteres indexPath: IndexPath)
    @objc optional func BTableView(tableItems: InfoManager, infoPressed indexPath: IndexPath)
    @objc optional func BTableView(tableItems: InfoManager, segmentChange at: Int, indexPath: IndexPath)
    
    @objc optional func BTableView(tableItems: InfoManager, add indexPath: IndexPath)
    
    @objc optional func BTableView(tableItems: InfoManager, deleteCorreo indexPath: IndexPath)
    @objc optional func BTableView(tableItems: InfoManager, deleteTelefono indexPath: IndexPath)
    // delegado del auto interes en venta
    @objc optional func BTableView(tableItems: InfoManager, selectVersionAuto idMarca: String, idAuto: String, modelo: String, idProducto: String, idColor: String)
    @objc optional func BTableView(tableItems: InfoManager, selectVersionAutoAux press: Bool)
    // delegado del colapsable
    @objc optional func BTableView(tableItems: InfoManager, pressColapsable press: Bool)
    
    
    @objc optional func BTableView(tableItems: InfoManager, updateCell indexPath: IndexPath, value: String, action: String)
    @objc optional func BTableView(tableItems: InfoManager, deleteCell indexPath: IndexPath)
}

class BTableViewController: BViewController {

    var tableItems = InfoManager()
    var BaseDelegate: BTableViewDelegate?
//    var autoInteresDelegate: AutoInteresCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func isValidText(regEx: String, text: String) -> Bool {
        let textregEx = regEx
        let textTest = NSPredicate(format: "SELF MATCHES %@", textregEx)
        
        return textTest.evaluate(with: text)
    }
    
    func clearSpinner(identifier: String) {
        tableItems.getItem(identifier: identifier)?.value = ""
        tableItems.getItem(identifier: identifier)?.valueId = ""
        tableItems.getItem(identifier: identifier)?.tupleArray = []
    }
    
    func animate(tableView: UITableView, alpha: CGFloat, completion: (() -> Void)?) {
        
        UIView.animate(withDuration: 0.5, animations: {
            tableView.alpha = alpha
        }) { _ in
            completion?()
        }
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE
extension BTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableItems.count > 0 {
            return tableItems.numberOfItems(section)
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCellFactory.createCell(tableView: tableView, items: tableItems, indexPath: indexPath, target: self, delegate: self)
        
//        if tableItems.getItem(section: indexPath.section, at: indexPath.row).type == .autoInteres {
//            autoInteresDelegate = cell as? AutoInteresCellDelegate
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return TableViewCellFactory.heightForRow(items: tableItems, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableItems.getSectionName(section: section).isEmpty || !tableItems.isSectionVisible(section: section) {
            return nil
        }
        else if tableView.style == .grouped {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SOHeaderCell") as? SOHeaderCell
            header?.titulo.text = tableItems.getSectionName(section: section)
            
            return header
        }
        else {
            return HeaderCell(title: tableItems.getSectionName(section: section), textalignment: .center, style: tableView.style)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableItems.getSectionName(section: section).isEmpty || !tableItems.isSectionVisible(section: section) {
            if tableView.style == .grouped {
                return 1.0
            }
            
            return 0.0
        }
        
        if tableView.style == .grouped {
            return 60.0
        }
        
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.style == .grouped {
            if tableItems.getSectionName(section: section).isEmpty || !tableItems.isSectionVisible(section: section) {
                return 1.0
            }
            
            return 20.0
        }
        
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
        
        if item.type == .isAddTelephone  || item.type == .isAddCorreo {
            return true
        }
        else {
            return false
        }
    }
}


//MARK: SPINNER DELEGATE METHODS (SPINNER)
//extension BTableViewController: UIPopoverPresentationControllerDelegate, showSpinnerDelegate, popopViewControllerDelegate2 {
extension BTableViewController: UIPopoverPresentationControllerDelegate {
    
//    func showSpinner(_ nombreCampo: String, indexPath: IndexPath, sender: AnyObject) {
//        let identifier = tableItems.getItemIdentifier(section: indexPath.section, at: indexPath.row)
//        var message = tableItems.getItem(identifier: identifier)?.message ?? ""
//
//        if message.isEmpty {
//            message = "No hay elementos disponibles"
//        }
//
//        let array = tableItems.getItem(identifier: identifier)!.tupleArray.map({ $0.1 })
//
//        if array.isEmpty {
//            YopterAlerts(title: "Aviso", message: message, buttonTitle: "Aceptar").presentAlert()
//        }
//        else {
//            presentSpinner(sender, arrayItems: array, nombre: identifier, target: self, delegate: self, indexPath: indexPath)
//        }
//    }
    
    func valorSeleccionado2(_ indexPhat: IndexPath, indexPathCampo: IndexPath, nombreSpinner: String) {
        let item = tableItems.getItem(section: indexPathCampo.section, at: indexPathCampo.row)
        let id = item.tupleArray[indexPhat.row].0
        let value = item.tupleArray[indexPhat.row].1
        
//        if tableItems.getItemIdentifier(section: indexPathCampo.section, at: indexPathCampo.row) == etiquetasCap.Telefono.rawValue {
//            tableItems.getItem(section: indexPathCampo.section, at: indexPathCampo.row).tipoTelefono = value

        if item.type == .isTelefono {
            tableItems.getItem(section: indexPathCampo.section, at: indexPathCampo.row).tipoTelefono = value
        }
        else if item.type == .isCorreo {
            tableItems.getItem(identifier: nombreSpinner)?.tipoCorreo = value
        }
        else {
            tableItems.getItem(identifier: nombreSpinner)?.value = value
        }
        
        tableItems.getItem(section: indexPathCampo.section, at: indexPathCampo.row).valueId = id
        BaseDelegate?.BTableView?(tableItems: tableItems, spinnerItemAt: indexPhat, indexPathItem: indexPathCampo, spinnerName: nombreSpinner)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//MARK: OFFERT CEL DELEGATE
extension BTableViewController: cellOffertDelegate{
    func updateCell(indexPath: IndexPath, value: String, action: String) {
        BaseDelegate?.BTableView?(tableItems: tableItems, updateCell: indexPath, value: value, action: action)
    }
    
    func deleteCell(indexPath: IndexPath) {
        BaseDelegate?.BTableView?(tableItems: tableItems, deleteCell: indexPath)
    }
}

////MARK: TEXTFIELD & TEXTVIEW DELEGATE METHODS (TEXTFIELD & OBSERVATIONS)
//extension BTableViewController: SeekOpTextFieldDelegate, textViewCellDelegate {
//
//    func textViewCellDidChange(textView: UITextView, input:String, indexPath: IndexPath) {
//
//        let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
//
//        if isValidText(regEx: item.regExValidation, text: input) {
//            item.value = input
//        }
//        else {
//            let oldText = String(input.dropLast())
//            textView.text = oldText
//            item.value = oldText
//        }
//
//        SOdelegate?.BTableView?(tableItems: tableItems, observationsDidChange: item.value, indexPath: indexPath)
//    }
//
//
//    @objc func seekOpTextFieldChange(textField: UITextField, indexPath: IndexPath, text: String) {
//        let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
//
//        if isValidText(regEx: item.regExValidation, text: text) {
//            item.value = text
//        }
//        else {
//            let oldText = String(text.dropLast())
//            textField.text = oldText
//            item.value = oldText
//        }
//
//        SOdelegate?.BTableView?(tableItems: tableItems, textFieldDidChange: item.value, indexPath: indexPath)
//    }
//}
//
////MARK: BUTTON DELEGATE METHODS (BUTTON)
//extension BTableViewController: botonDelegate {
//
//    func botonPressed(indexPath: IndexPath) {
//        SOdelegate?.BTableView?(tableItems: tableItems, buttonPressedAt: indexPath)
//    }
//}
//
//extension BTableViewController: telefonosCellDelegate {
//
//    func telefonosCellDel(indexPath: IndexPath) {
//        SOdelegate?.BTableView?(tableItems: tableItems, deleteTelefono: indexPath)
//    }
//
//    func ShowSpinnerTipoTelefonoDel(_ nombreCampo: String, indexPath: IndexPath, sender: AnyObject) {
//        showSpinner(etiquetasCap.Telefono.rawValue, indexPath: indexPath, sender: sender)
//    }
//
//    func telefonoDidEndEditing(text: String, atIndexPath indexPath: IndexPath) {
//        tableItems.getItem(section: indexPath.section, at: indexPath.row).numTelefono = text
//        SOdelegate?.BTableView?(tableItems: tableItems, telefonoDidEndEditing: indexPath)
//    }
//
//
//}
////MARK: BUTTON DELEGATE METHODS (BUTTON)
//extension BTableViewController: correoCellDelegate {
//    func correoShowspinnerDel(_ nombreCampo: String, indexPath: IndexPath, sender: AnyObject) {
//        showSpinner(etiquetasCap.Telefono.rawValue, indexPath: indexPath, sender: sender)
//    }
//
//    func correoTextChange(text: String, atIndexPath indexPath: IndexPath) {
//        print("esta escribiendo")
//    }
//
//    func correoDidEndEditing(text: String, atIndexPath indexPath: IndexPath) {
//        print("ya termino")
//        tableItems.getItem(section: indexPath.section, at: indexPath.row).correo = text
//        SOdelegate?.BTableView?(tableItems: tableItems, correoDidEndEditing: indexPath)
//    }
//
//    func correoCellDel(indexPath: IndexPath) {
//        SOdelegate?.BTableView?(tableItems: tableItems, deleteCorreo: indexPath)
//    }
//}
//
////MARK: BUTTON DELEGATE METHODS (BUTTON)
//extension BTableViewController: StatusBarDelegate, ProximoSeguimientoCellDelegate {
//    func StatusBar(onItemSelected index: Int) {
//        SOdelegate?.BTableView?(tableItems: tableItems, StatusBarOnItemSelected: index)
//    }
//
//    func statusBarChange(indexPath: IndexPath, idStatus: String) {
//        SOdelegate?.BTableView?(tableItems: tableItems, statusBarChange: indexPath, idStatus: idStatus)
//    }
//}
////MARK: BUTTON DELEGATE METHODS
//extension BTableViewController: datePickeProtocol2 {
//
//    func dateSelected(date: Date, dateString: String, indexPath: IndexPath) {
//        tableItems.getItem(section: indexPath.section, at: indexPath.row).value = dateString
//        tableItems.getItem(section: indexPath.section, at: indexPath.row).dateValue = date
//        SOdelegate?.BTableView?(tableItems: tableItems, dateSelected: indexPath)
//    }
//}
//
//
////MARK: ADD DELEGATE METHODS
//extension BTableViewController: AddCellDelegate {
//
//    func addPressed(indexPath: IndexPath) {
//        SOdelegate?.BTableView?(tableItems: tableItems, add: indexPath)
//    }
//}
//
////MARK: checkBox DELEGATE METHODS
//extension BTableViewController: checkBoxDatosCellDelegate {
//
//    func checkboxDatosPressed(indexPath: IndexPath) {
//        if tableItems.getItem(section: indexPath.section, at: indexPath.row).valueId == "1" {
//            tableItems.getItem(section: indexPath.section, at: indexPath.row).valueId = "0"
//        } else {
//            tableItems.getItem(section: indexPath.section, at: indexPath.row).valueId = "1"
//        }
//        SOdelegate?.BTableView?(tableItems: tableItems, checkBoxPressed: indexPath)
//    }
//}
//
//extension BTableViewController : cellCheckBoxRassDelegate {
//    func changeImageViewCheckDel(_ indexPath: IndexPath) {
//        if tableItems.getItem(section: indexPath.section, at: indexPath.row).value == "1" {
//            tableItems.getItem(section: indexPath.section, at: indexPath.row).value = "0"
//        } else {
//            tableItems.getItem(section: indexPath.section, at: indexPath.row).value = "1"
//        }
//        SOdelegate?.BTableView?(tableItems: tableItems, checkBoxPressedRass: indexPath)
//    }
//}
//
////MARK: checkBox derecho DELEGATE METHODS
//extension BTableViewController : celdaCatalogoDeclinarDelegate {
//    func celdaCheckDel(index: IndexPath) {
//        let isActive = tableItems.getItem(section: index.section, at: index.row).isActive
//        tableItems.getItem(section: index.section, at: index.row).isActive = !isActive
//        SOdelegate?.BTableView?(tableItems: tableItems, checkBoxDerechoActive: index)
//    }
//}
//
//extension BTableViewController : labelInfoDelegate
//{
//    func botonInfo(indexPath: IndexPath) {
//        SOdelegate?.BTableView?(tableItems: tableItems, infoPressed: indexPath)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7)
//        {
//            let vc = infoLibroAzul(nibName: "infoLibroAzul", bundle: nil)
//            let modal = SOModal(contentVC: vc, fromVC: self)
//            modal.present()
//        }
//    }
//}
//
//
////MARK: SEGMENTED CONTROL
//extension BTableViewController: SegmentedCellDelegate {
//    func segmentedIndexChange(indexPath: IndexPath, index: Int) {
//        tableItems.getItem(section: indexPath.section, at: indexPath.row).indexSelected = index
//        SOdelegate?.BTableView?(tableItems: tableItems, segmentChange: index, indexPath: indexPath)
//    }
//}
//
//extension BTableViewController: radioCellDelegate, checkCellDelegate
//{
//    func getData(_ index: IndexPath?, valor: checkCellSelection) {
//
//        if let indexPath = index {
//            tableItems.getItem(section: indexPath.section, at: indexPath.row).valueId = (valor == .left) ? "0" : "1"
//            SOdelegate?.BTableView?(tableItems: tableItems, selectRadio: indexPath)
//        }
//
//    }
//
//    func radioCellDel(_ index:IndexPath, valor:String) {
//        SOdelegate?.BTableView?(tableItems: tableItems, selectRadio: index)
//    }
//}
//
//extension BTableViewController: cellThreeRadioDelegate
//{
//    func pressBtn1(_ index: IndexPath, valor: String)
//    {
//        //tableItems.getItem(section: index.section, at: index.row).valueId = valor
//        SOdelegate?.BTableView?(tableItems: tableItems, radioDidSelect3: valor, indexPath: index)
//    }
//
//    func pressBtn2(_ index: IndexPath, valor: String)
//    {
//        //tableItems.getItem(section: index.section, at: index.row).valueId = valor
//        SOdelegate?.BTableView?(tableItems: tableItems, radioDidSelect3: valor, indexPath: index)
//    }
//
//    func pressBtn3(_ index: IndexPath, valor: String)
//    {
//        //tableItems.getItem(section: index.section, at: index.row).valueId = valor
//        SOdelegate?.BTableView?(tableItems: tableItems, radioDidSelect3: valor, indexPath: index)
//    }
//
//
//}
//
//extension BTableViewController: interesAutoDelegate
//{
//    func autoSelected(index: IndexPath)
//    {
//        tableItems.quitarFavorito()
//        SOdelegate?.BTableView?(tableItems: tableItems, selectAutoInteres: index)
//    }
//}
//
//extension BTableViewController: regresaValorCheckDelegate
//{
//    func returnValores(titulo: String, valor: String, index: IndexPath)
//    {
//        tableItems.getItem(section: index.section, at: index.row).checkSelect = (valor.elementsEqual("1") ? true : false)
//        SOdelegate?.BTableView?(tableItems: tableItems, returnValoresCheck: titulo, valor: valor, indexPath: index)
//    }
//}
//
//extension BTableViewController: AutoInteresCellDelegate
//{
//    func realoadData(idMarca: String, idAuto: String, modelo: String, idProducto: String, idColor: String)
//    {
//        SOdelegate?.BTableView?(tableItems: tableItems, selectVersionAuto: idProducto, idAuto: idAuto, modelo: modelo, idProducto: idProducto, idColor: idColor)
//    }
//
//    func versionSelected()
//    {
//        SOdelegate?.BTableView?(tableItems: tableItems, selectVersionAutoAux: true)
//    }
//}
//
//extension BTableViewController: pressColapsableDelegate
//{
//    func press(valor: Bool)
//    {
//        SOdelegate?.BTableView?(tableItems: tableItems, pressColapsable: valor)
//    }
//}
