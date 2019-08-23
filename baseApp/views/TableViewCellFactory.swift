//  TableViewCellFactory.swift
//  SeekOp
//  Created by Erick Daniel Rodríguez Liceaga on 27/03/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.

import UIKit

class TableViewCellFactory: NSObject {
    
    static func registerCells(tableView: UITableView, types: InfoItemType...) {
        tableView.register(UINib(nibName: "SOHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "SOHeaderCell")
        
        for type in types {
            let identifier = type.rawValue
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    static func registerCells(tableView: UITableView, identifiers: String...) {
        tableView.register(UINib(nibName: "SOHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "SOHeaderCell")
        
        for identifier in identifiers {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    static func heightForRow(items: InfoManager, indexPath: IndexPath) -> CGFloat {
        let item = items.getItem(section: indexPath.section, at: indexPath.row)
        
        if !item.showItem || !items.isSectionVisible(section: indexPath.section) {
            return 0
        }
        
        if let _ = item.tableCell {
            return item.itemHeight
        }
        else {
            switch item.type {
            case .label, .labelInfo, .textField, .spinner, .isCorreo, .isTelefono:
                return 68
            case .observations:
                return 180
            case .button, .isAddTelephone, .isAddCorreo, .checkBox, .segmented:
                return 60
            case .datePicker, .imagenCell:
                return 150
            case .statusbar, .radio:
                if item.rechazo
                {
                    return item.itemHeight
                }
                else
                {
                    return 100
                }
            case .cellCheckBoxRass:
                return 60
            case .checkDerecho, .iconLabel:
                return 50
            case .dobleCampo, .cellDemoRass:
                return item.itemHeight
            case .precioCell:
                return 80
            case .scoreTcell:
                return 190
            case .offertCell:
                return 140
            default:
                return item.itemHeight
            }
        }
    }
    
    static func createCell(tableView: UITableView, items: InfoManager, indexPath: IndexPath, target: UIViewController, delegate: AnyObject) -> UITableViewCell {
        let item = items.getItem(section: indexPath.section, at: indexPath.row)
        let requiredStar = item.required ? " *" : ""
        
        if let cell = item.tableCell {
            return cell
        } else {
            var cell_: UITableViewCell?
            
            if item.type != .isAddTelephone && item.type != .isAddCorreo {
                cell_ = tableView.dequeueReusableCell(withIdentifier: item.type.rawValue)
            }
            
            if !item.showItem || !items.isSectionVisible(section: indexPath.section) {
                cell_?.contentView.alpha = 0
            }
            else {
                cell_?.contentView.alpha = 1
            }
            
            switch item.type {
//            case .label:
//                let cell = cell_ as! label
//                if !item.title.isEmpty {
//                    cell.titulo.text = item.title + requiredStar
//                    cell.tituloHeight.constant = 21
//                } else {
//                    cell.tituloHeight.constant = 0.0
//                }
//                cell.titulo.textColor = UIColor.black
//                if let color = item.textValueColor {
//                    cell.contenido.textColor = color
//                } else {
//                    cell.contenido.textColor = UIColor.black
//                }
//                cell.contenido.text = item.value
//
//
//                return cell
//            case .labelInfo:
//                let cell = cell_ as! labelInfo
//                cell.delegate = delegate as? labelInfoDelegate
//                cell.titulo.text = item.title
//                cell.titulo.textColor = UIColor.black
//                cell.contenido.text = item.value
//                cell.indexPath = indexPath
//
//                return cell
//            case .dobleCampo:
//                let cell = cell_ as! dobleCampo
//                cell.precioC.text = item.title
//                cell.precioV.text = item.value
//
//                return cell
//            case .textField:
//                let cell = cell_ as! textField
//                cell.titulo.text = item.title + requiredStar
//                cell.titulo.textColor = item.titleColor
//                cell.valor.text = item.value
//                cell.indexPath = indexPath
//                cell.delegate = delegate as? SeekOpTextFieldDelegate
//                cell.valor.keyboardType = item.keyboardType
//                addToolBar(cell.valor, target: target)
//
//                if !item.showItem || !items.isSectionVisible(section: indexPath.section) || item.itemHeight == 0.0 {
//                    cell.contenedor.alpha = 0.0
//                }
//
//                if !item.value.isEmpty {
//                    cell.titulo.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
//                }
//                if item.rechazo
//                {
//                    cell.backgroundColor = UIColor.groupTableViewBackground
//                }
//
//                return cell
//            case .spinner:
//                let cell = cell_ as! spinner
//                cell.nombreCampo.text = item.title + requiredStar
//                cell.nombreCampo.textColor = item.titleColor
//                cell.valor.text = item.value.isEmpty ? "(SELECCIONAR)" : item.value
//                cell.indexPath = indexPath
//                cell.delegate = delegate as? showSpinnerDelegate
//                if !item.showItem || !items.isSectionVisible(section: indexPath.section) || item.itemHeight == 0.0 {
//                    cell.contenido.alpha = 0.0
//                }
//                if item.rechazo
//                {
//                    cell.backgroundColor = UIColor.groupTableViewBackground
//                }
//
//                return cell
//
//            case .observations:
//                let cell = cell_ as! textViewCell
//                cell.backgroundColor = UIColor.groupTableViewBackground
//                cell.tituloLabel.text = item.title + requiredStar
//                cell.contenidoTextView.text = item.value
//                cell.contenidoTextView.backgroundColor = .white
//                cell.tituloLabel.textColor = item.titleColor
//                cell.indexPath = indexPath
//                cell.delegate = delegate as? textViewCellDelegate
//                cell.contenidoTextView.keyboardType = item.keyboardType
//                addToolBar(cell.contenidoTextView, target: target)
//
//                if !item.showItem || !items.isSectionVisible(section: indexPath.section) || item.itemHeight == 0.0 {
//                    cell.contenedor.alpha = 0.0
//                }
//
//                return cell
//            case .button:
//                let cell = cell_ as! boton
//                cell.boton.setTitle(item.title, for: .normal)
//                cell.indexPath = indexPath
//                cell.delegate = delegate as? botonDelegate
//
//                return cell
//            case .add:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as! AddCell
//                cell.delegate = delegate as? AddCellDelegate
//                cell.indexPath = indexPath
//                cell.titulo.text = item.title
//                cell.titulo.textColor = item.titleColor
//
//                return cell
//            case .isAddTelephone :
//                let cell = UITableViewCell()
//                cell.textLabel?.text = "Agregar Teléfono"
//                cell.textLabel?.textColor = item.titleColor
//                cell.textLabel?.font = UIFont(name: FONT_MEDIUM, size: 16.0)
//                cell.contentView.backgroundColor = .clear
//                cell.backgroundColor = .clear
//                return cell
//            case .isAddCorreo:
//                let cell = UITableViewCell()
//                cell.textLabel?.text = "Agregar Correo"
//                cell.textLabel?.font = UIFont(name: FONT_MEDIUM, size: 16.0)
//                cell.contentView.backgroundColor = .clear
//                cell.backgroundColor = .clear
//                return cell
//            case .customCheck:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "customCheck") as! customCheck
//                cell.index = indexPath
//                cell.delegate = delegate as? regresaValorCheckDelegate
//                cell.checkBoxHeight = item.checkBoxHeight
//                cell.checkmarkLineWidth = item.checkmarkLineWidth
//                cell.padding = item.padding
//                cell.activeColor = item.activeColor
//                cell.inactiveColor = item.inactiveColor
//                cell.inactiveBorderColor = item.inactiveBorderColor
//                cell.checkMarkColor = item.checkMarkColor
//                cell.enabled = item.enabled
//                cell.texto = item.title
//                cell.style = item.style
//                cell.checkSelect = item.checkSelect
//                cell.fontSize = item.fontSize
//                cell.colorTexto = item.colorTexto
//                cell.useColorTexto = item.useColorTexto
//                cell.boton.isHidden = !item.showItem
//                cell.isRequired = item.required
//                return cell
//            case .isCorreo:
//                let cell = cell_ as! correoCell
//                cell.textFielCorreo.text = item.correo
//                cell.tipoCorreo.text = item.tipoCorreo
//                cell.textFielCorreo.tag = indexPath.row + 9
//                cell.delegate = delegate as? correoCellDelegate
//                cell.indexPath = indexPath
//                cell.emailLabel.textColor = item.colorCorreo
//
//                addToolBar(cell.textFielCorreo, target: delegate as! UIViewController)
//
//                if !item.showItem || !items.isSectionVisible(section: indexPath.section) || item.itemHeight == 0.0 {
//                    cell.contenedor.alpha = 0.0
//                    cell.contenedor1.alpha = 0.0
//                    cell.contenedor2.alpha = 0.0
//                }
//
//                return cell
//            case .isTelefono:
//                let cell = cell_ as! telefonosCell
//                cell.tipoTelefono.text = item.tipoTelefono
//                cell.numTelefono.text = item.numTelefono
//                cell.numExt.text = item.numExt
//                cell.tituloExtencion.textColor = item.colorExt
//                cell.numTelefono.tag = 1
//                cell.numExt.tag = 2
//                cell.tituloTelefono.textColor = item.colorTelefono
//                addToolBar(cell.numTelefono, target: target)
//                addToolBar(cell.numExt, target: target)
//
//                cell.indexPath = indexPath
//                cell.delegate = delegate as? telefonosCellDelegate
//
//                if item.tipoTelefono != "Oficina" {
//                    cell.viewExtencion.alpha = 0.0
//                    cell.extWidth.constant = 0.0
//                    cell.extMargin.constant = 0.0
//                }
//
//                if !item.showItem || !items.isSectionVisible(section: indexPath.section) || item.itemHeight == 0.0 {
//                    cell.contenedor.alpha = 0.0
//                    cell.viewExtencion.alpha = 0.0
//                    cell.contenedor1.alpha = 0.0
//                    cell.contenedor2.alpha = 0.0
//                }
//
//                return cell
//            case .datePicker:
//                let cell = cell_ as! datePiker
//                cell.dateString = item.value
//                cell.datePicker.datePickerMode = item.typePicker
//                cell.contraintHeight.constant = CGFloat(item.heightDatePicker)
//                cell.indexPath = indexPath
//                cell.delegate2 = delegate as? datePickeProtocol2
//
//                if item.title.isEmpty {
//                    cell.contraintHeight.constant = 0.0
//                }
//                else {
//                    cell.titulo.text = item.title
//                }
//
//                if let fecha = toDateTime(item.value, formato: "yyyy-MM-dd HH:mm:ss") {
//                    cell.datePicker.date = fecha
//                }
//                else if let fecha = toDateTime(item.value, formato: "yyyy-MM-dd HH:mm:ss", isSegimiento: true) {
//                    cell.datePicker.date = fecha
//                }
//                cell.indexPath = indexPath
//                cell.delegate2 = delegate as? datePickeProtocol2
//                if item.rechazo
//                {
//                    cell.backgroundColor = UIColor.groupTableViewBackground
//                    cell.titulo.alpha = 1.0
//                    cell.titulo.text = item.title
//                    cell.titulo.textColor = colorAzul
//                }
//                else
//                {
//                    cell.titulo.alpha = 0.0
//                    if !item.showItem || !items.isSectionVisible(section: indexPath.section) || item.itemHeight == 0.0 {
//                        cell.contenedor.alpha = 0.0
//                    }
//                }
//                if item.posVenta
//                {
//                    let date = Date()
//
//                    let endDate = Calendar.current.date(byAdding: Calendar.Component.day, value: -45, to: date)!
//                    cell.datePicker.maximumDate = date
//                    cell.datePicker.minimumDate = endDate
//                }
//
//                return cell
//            case .statusbar:
//                let cell = cell_ as! statusBarCell
//                cell.label.text = item.title
//                cell.statusBar.delegate2 = delegate as? StatusBarDelegate
//                cell.statusBar.reprogramar = item.isRepreogramar
//
//                if let indice = item.valueIdStatus.toInt() {
//                    cell.statusBar.createStatusBar(item.tupleArray, index: indice)
//                }
//                else {
//                    cell.statusBar.createStatusBar(item.tupleArray, index: 0)
//                }
//
//                return cell
//            case .checkBox:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "checkBoxDatosCell", for: indexPath) as! checkBoxDatosCell
//                cell.tituliLabel.text = (item.title == "Privacidad") ? "" : item.title + requiredStar
//
//                cell.imagenCheck.image = (item.valueId == "0") ? #imageLiteral(resourceName: "unchecked_checkbox") : #imageLiteral(resourceName: "checked_checkbox")
//                cell.tituliLabel.textColor = item.titleColor
//                cell.delegate = delegate as? checkBoxDatosCellDelegate
//                cell.indexPath = indexPath
//                cell.subtitle.text = (item.title == "Privacidad") ? "Privacidad" : "Prospecto importante"
//                return cell
//            case .imagenCell:
//                let cell = cell_ as! imagenCell
//                cell.imagen.image = item.image
//
//                return cell
//            case .cellCheckBoxRass:
//                let cell = cell_ as! cellCheckBoxRass
//                cell.labelText.text = item.title
//                cell.constarintImagen.constant = (item.showItem) ? 20.0 : 0
//                cell.indexPath = indexPath
//                cell.imagen.image = (item.value == "1") ? #imageLiteral(resourceName: "checked_checkbox") : #imageLiteral(resourceName: "unchecked_checkbox")
//                cell.delegate = delegate as? cellCheckBoxRassDelegate
//                if let color  = item.backgroundColor {
//                    cell.contenedor.backgroundColor = color
//                    cell.labelText.textColor = item.required ? UIColor.black : UIColor.lightGray
//                    cell.labelText.font = item.required ? UIFont(name: FONT_BOLD, size: 15) : UIFont(name: FONT_MEDIUM, size: 15)
//                } else {
//                    cell.contenedor.backgroundColor = UIColor.lightGray
//                }
//
//                return cell
//            case .checkDerecho:
//                let cell = cell_ as! celdaCatalogoDeclinar
//
//                cell.tituloMotivo.text = item.title
//                if item.isActive
//                {
//                    cell.estadoMotivo.text = "Activo"
//                    cell.imageAcept.isHidden = false
//                }
//                else
//                {
//                    cell.imageAcept.isHidden = true
//                    cell.estadoMotivo.text = "Inactivo"
//                }
//                cell.index = indexPath
//                cell.delegate = delegate as? celdaCatalogoDeclinarDelegate
//                return cell
//            case .cellDemoRass:
//
//                let cell = cell_ as! cellDemoRass
//                cell.label1.text = item.autoModeloRass
//                cell.label2.text = item.VinRass
//                cell.label3.text = item.productoRass
//                cell.indexPath = indexPath
//                cell.delegate = delegate as? cellDemoRassDelegate
//                //cell.observacionesDemo.text = campo[indexPath.section].Valor[indexPath.row].Valor
//                return cell
//            case .iconLabel:
//                let cell = cell_ as! busquedaProspectoCell
//                cell.nombre.text = item.title
//
//                if item.value.isEmpty {
//                    cell.idProspectoHeight.constant = 0.0
//                }
//                else {
//                    cell.idProspectoHeight.constant = 20.0
//                    cell.idProspecto.text = item.value
//                }
//
//                cell.personaImagen.image = item.image
//
//                return cell
//            case .precioCell:
//                let cell = cell_ as! precioCell
//                return cell
//            case .scoreTcell:
//                let cell = cell_ as! scoreTcell
//                cell.titulo.text = item.title
//                cell.LValor.text = item.value
//                cell.LValorFloat.text = "\(item.totaleadsPaquete)"
//                cell.totalDeLeads = item.valueCGFloat
//                cell.totalPaquete = item.totaleadsPaquete
//                return cell
//            case .twoLabelsHCell:
//                let cell = cell_ as! twoLabelsHCell
//                cell.backgroundColor = UIColor.groupTableViewBackground
//                cell.labelIzquierdo.text = item.title
//                cell.labelDerecho.text = item.value
//                return cell
//            case .cellProspectosDu:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "cellProspectosDu") as! cellProspectosDu
//
//                cell.titulo.text = item.title
//                cell.titulo.font = UIFont.boldSystemFont(ofSize: 13.0)
//                cell.titulo.textColor = item.titleColor
//                cell.valor.text = item.value
//                //cell.valor.delegate = self
//                if item.message.elementsEqual("") {
//                    cell.valorSeleccionar.text = "(Sin acción)"
//                } else {
//                    cell.valorSeleccionar.text = item.message
//                }
//
//                cell.indexPath = indexPath
//                //cell.delegate = self
//                cell.valor.isUserInteractionEnabled  = (indexPath.row == 0 || indexPath.row == 1) ? false : true
//                return cell
//            case .radio:
//                let cell = cell_ as! radioCell
//                cell.labelTitulo.text = item.title
//
//                cell.labelSi.text = item.lsi
//                cell.labelNo.text = item.lno
//                cell.delegate = delegate as? radioCellDelegate
//                cell.indexPath = indexPath
//                cell.valorRadio = item.value
//                cell.imagenUncheck.image = (item.value == "1") ?  #imageLiteral(resourceName: "radiounCheck") : #imageLiteral(resourceName: "radiocheck")
//                cell.imagencheck.image = (item.value == "1") ?  #imageLiteral(resourceName: "radiocheck") : #imageLiteral(resourceName: "radiounCheck")
//                if item.rechazo
//                {
//                    cell.labelTitulo.font = UIFont(name: FONT_BOLD, size: 15.0)
//                    cell.backgroundColor = UIColor.groupTableViewBackground
//                }
//                return cell
//            case .cellAutoInteres:
//                let cell = cell_ as! cellAutoInteres
//                cell.index = indexPath
//                cell.marca.text = item.marca
//                cell.auto.text = item.auto
//                cell.modelo.text = item.modelo
//                cell.version.text = item.version
//                cell.delegate = delegate as? interesAutoDelegate
//                cell.imageAuto.image = (item.favorito == true) ?  #imageLiteral(resourceName: "autoInt") : #imageLiteral(resourceName: "autoInt2")
//                cell.imageAuto.image = (item.favorito == false) ?  #imageLiteral(resourceName: "autoInt2") : #imageLiteral(resourceName: "autoInt")
//
//                return cell
//            case .cellThreeRadio:
//                let cell = cell_ as! cellThreeRadio
//                cell.delegate = delegate as? cellThreeRadioDelegate
//                cell.index = indexPath
//                cell.constraintH.constant = CGFloat(item.radioH)
//                cell.view1.isHidden = item.v1
//                cell.view2.isHidden = item.v2
//                cell.view3.isHidden = item.v3
//                cell.Luno.text = item.l1
//                cell.LDos.text = item.l2
//                cell.LTres.text = item.l3
//                cell.img1.image = (item.value == "") ? #imageLiteral(resourceName: "radiocheck") : #imageLiteral(resourceName: "radiounCheck")
//                cell.img2.image = (item.value == "1") ?  #imageLiteral(resourceName: "radiocheck") : #imageLiteral(resourceName: "radiounCheck")
//                cell.img3.image = (item.value == "0") ?  #imageLiteral(resourceName: "radiocheck") : #imageLiteral(resourceName: "radiounCheck")
//                cell.backgroundColor = UIColor.groupTableViewBackground
//                return cell
//            case .labelBackGround:
//                let cell = cell_ as! labelBackGround
//                cell.labelView.text = item.title
//                //cell.labelView.textColor = item.colorTexto
//                //cell.labelView.font = UIFont(name: FONT_ITALIC, size: CGFloat(item.fontSize))
//                cell.labelView.textAlignment = item.textAlig
//                cell.contentLabel.backgroundColor = item.colorFondo
//                cell.contentLabel.layer.cornerRadius = 8.0
//                cell.contentView.backgroundColor = UIColor.groupTableViewBackground
//                return cell
//            case .radioOption:
//                let celda = cell_ as! checkCell
//                celda.tituloLabel.text = item.title
//                celda.tituloLabel.textColor = item.titleColor
//                celda.radioLeftLabel.text = item.leftTitle
//                celda.radioRightLabel.text = item.rightTitle
//                celda.indexPath = indexPath
//                celda.delegate = delegate as? checkCellDelegate
//
//                if item.valueId == "0" {
//                    celda.type = .left
//                }
//                else{
//                    celda.type = .right
//                }
//
//                return celda
//            case .segmented:
//                let cell = cell_ as! SegmentedCell
//                cell.delegate = delegate as? SegmentedCellDelegate
//                cell.indexPath = indexPath
//                cell.segmentos = item.array
//                cell.indexSelected = item.indexSelected
//
//                return cell
//            case .autoInteres:
//                let cell = cell_ as! AutoInteresCell
//                if item.rechazo
//                {
//                    cell.delegate = delegate as? AutoInteresCellDelegate
//                }
//                cell.item = item
//                cell.vc = target
//                return cell
//            case .seguimiento:
//                let cell = cell_ as! ProximoSeguimientoCell
//                cell.item = item
//                cell.vc = target
//                cell.indexPath = indexPath
//                cell.delegate = delegate as? ProximoSeguimientoCellDelegate
//
//                return cell
//            case .textCell:
//                let cell = cell_ as! textCell
//                cell.txtView.text = item.title
//                cell.txtView.backgroundColor = item.colorFondo
//                cell.txtView.textColor = item.colorTexto
//                cell.txtView.font = UIFont.boldSystemFont(ofSize: CGFloat(item.fontSize))
//                cell.txtView.textAlignment = item.textAlig
//                return cell
//            case .imageBtnCell:
//                let cell = cell_ as! imageBtnCell
//                cell.labelGuia.text = item.title
//                cell.imageGuia.image = item.image?.withRenderingMode(.alwaysTemplate)
//                cell.imageGuia.tintColor = colorAzul
//                cell.labelGuia.textColor = colorAzul
//                return cell
//            case .headColapsable:
//                let cell = cell_ as! headColapsable
//                cell.delegate = delegate as? pressColapsableDelegate
//                cell.label.text = item.title
//                cell.label.textColor = UIColor.white
//                if item.setEstadoColapsable
//                {
//                    cell.imageArrow.image = #imageLiteral(resourceName: "flechaArriba").withRenderingMode(.alwaysTemplate)
//                    cell.imageArrow.transform = cell.imageArrow.transform.rotated(by: CGFloat(Double.pi))
//                }
//                else
//                {
//                    cell.imageArrow.image = #imageLiteral(resourceName: "flechaArriba").withRenderingMode(.alwaysTemplate)
//                    cell.imageArrow.transform = cell.imageArrow.transform.rotated(by: CGFloat(Double.pi))
//                }
//                cell.imageArrow.tintColor = UIColor.white
//                cell.viewContent.backgroundColor = item.colorFondo
//                cell.state = item.setEstadoColapsable
//                return cell
            case .offertCell:
//                let cell = cell_ as! OffertCell

                let cell = cell_ as! cellOffert
                cell.indexPath = indexPath
                cell.offer = item.offer
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
}
