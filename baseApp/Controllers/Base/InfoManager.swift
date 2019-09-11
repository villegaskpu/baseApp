import UIKit
//import SwiftyJSON
import ObjectMapper
import a4SysCoreIOS

class InfoManager: NSObject {

    private var sections: [(sectionName: String, showSection: Bool, items: [InfoItem], identifier:String)] = []
    private var itemsNotReadyArray: [String] = []
    var tableView: UITableView?
    
    var count: Int {
        return sections.count
    }
    var contMotivos = 0
    var arrayIdMotivos: [String] = []
    
    override init() {
        super.init()
        
    }
    
    func numberOfSections() -> Int {
        return count
    }
    
    func numberOfItems(_ section: Int) -> Int {
        return sections[section].items.count
    }
    
    func removeAll() {
        sections.removeAll()
    }
    
    func set(section: String, identifier:String = "") {
        sections.append((section, true, [], identifier))
    }
    
    func append(item: InfoItem) {
        
        if let old_ = sections.last {
            var old = old_
            old.items.append(item)
            sections.removeLast()
            sections.append(old)
        }
    }
    
    func insert(items: [InfoItem], section: Int) {
        if sections.count > section {
            for item in items {
                sections[section].items.append(item)
            }
        }
    }
    
    func insert(section: String, at: Int, identifier: String = "") {
        sections.insert((section, true, [], identifier), at: at)
    }
    
    func insert(item: InfoItem, section: Int, at: Int) {
        if sections.count > section {
            sections[section].items.insert(item, at: at)
        }
    }
    
    func getSectionName(section: Int) -> String {
        if sections.count > section {
            return sections[section].sectionName
        }
        
        return ""
    }
    
    func getSectionName(identifier: String) -> String {
        if let section = sections.index(where: {$0.identifier == identifier}) {
            return sections[section].sectionName
        } else {
            print("no se encontro identificador")
            return ""
        }
    }
    
    func changeSectionName(sectionName: String, section: Int) {
        if sections.count > section {
            sections[section].sectionName = sectionName
        }
    }
    
    func changeSectionName(sectionName: String, identifier: String) {
        if let section = sections.index(where: {$0.identifier == identifier}) {
            sections[section].sectionName = sectionName
        } else {
            print("no se encontro identificador")
        }
    }
    
    func getItem(section: Int, at: Int) -> InfoItem {
//        if section < sections.count {
//            if at < sections[section].items.count {
//                return sections[section].items[at]
//            }
//        }
//        
//        return InfoItem(identifier: "", type: .default, title: "", value: "")
        
        return sections[section].items[at]
        
    }
    
//    func quitarFavorito() {
//        for section in sections {
//            for item in section.items {
//                if item.type == .cellAutoInteres {
//                    item.favorito = false
//                }
//            }
//        }
//    }
//
    func getItem(identifier: String) -> InfoItem? {
        var returnItem: InfoItem?

        for section in sections {
            for item in section.items {
                if item.identifier == identifier {
                    returnItem = item
                }
            }
        }

        return returnItem
    }
    
    func removeItem(section: Int, at: Int) {
        sections[section].items.remove(at: at)
    }
    
    func removeItem(identifier: String) {
        var finish = false
        
        for (i, section) in sections.enumerated() {
            for (j, item) in section.items.enumerated() {
                if item.identifier == identifier {
                    finish = true
                    sections[i].items.remove(at: j)
                    break
                }
            }
            
            if finish {
                break
            }
        }
    }
    
    func removeSection(index: Int) {
        sections.remove(at: index)
    }
    
    
    func removeSection(_ withIdentifier: String) {
        var index: Int?
        
        for (i, section) in sections.enumerated() where section.identifier.elementsEqual(withIdentifier) {
            index = i
            break
        }
        
        if let index_ = index {
            removeSection(index: index_)
        }
    }
    
    func getItemIdentifier(section: Int, at: Int) -> String {
        return sections[section].items[at].identifier
    }
    
    func showSection(sectionName: String, show: Bool) {
        for (i, section) in sections.enumerated() {
            if section.sectionName.elementsEqual(sectionName) {
                sections[i].showSection = show
            }
        }
    }
    
    func showSection(Identifier: String, show: Bool) {
        for (i, section) in sections.enumerated() {
            if section.identifier.elementsEqual(Identifier) {
                sections[i].showSection = show
            }
        }
    }
    
    func showSection(section: Int, show: Bool) {
        if sections.count > section {
            sections[section].showSection = show
        }
    }
    
    func isSectionVisible(section: Int) -> Bool {
        var visible = false

        if sections.count > section {
            visible = sections[section].showSection
        }
        
        return visible
    }
    

    
    func isReadyToSave() -> Bool {
        var ready = true
        var readyAux = false
        var readyAux2 = true
//        var color = colorVerde
        var color = UIColor.green
        itemsNotReadyArray.removeAll()
        contMotivos = 0
        
        let colorRojo = #colorLiteral(red: 1, green: 0.1493165817, blue: 0.1344394096, alpha: 1)
        let colorVerde = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        for (i, section) in sections.enumerated() where section.showSection {
            for (j, item) in section.items.enumerated() where item.showItem {
                if item.required {
                    if item.type == .spinner {
                        if item.valueId.isEmpty {
                            color = colorRojo
                            ready = false
                            itemsNotReadyArray.append("\n" + item.title)
                        }
                        else {
                            color = colorVerde
                        }
                    }
                    else if item.type == .textField || item.type == .observations {
                        if item.value.isEmpty {
                            color = colorRojo
                            ready = false
                            readyAux2 = false
                            itemsNotReadyArray.append("\n" + item.title)
                        }
                        else {
                            color = colorVerde
                        }
                    }
//                    else if item.type == .isTelefono {
//                        if item.idTipoTelefono == "2" { // es el tipo oficina
//                            if item.numExt.isEmpty {
//                                color = colorRojo
//                                sections[i].items[j].colorExt = colorRojo
//                                ready = false
//                                itemsNotReadyArray.append("\n" + item.title)
//                            }
//                            else {
//                                color = colorVerde
//                            }
//                            
//                            if item.numTelefono.isEmpty {
//                                color = colorRojo
//                                sections[i].items[j].colorTelefono = colorRojo
//                                ready = false
//                                itemsNotReadyArray.append("\n" + item.title)
//                            }
//                            else {
//                                color = colorVerde
//                            }
//                        } else {
//                            if item.numTelefono.isEmpty {
//                                color = colorRojo
//                                sections[i].items[j].colorTelefono = colorRojo
//                                ready = false
//                                itemsNotReadyArray.append("\n" + item.title)
//                            }
//                            else {
//                                color = colorVerde
//                            }
//                        }
//                    }
//                    else if item.type == .isCorreo {
//                        if item.correo.isEmpty {
//                            color = colorRojo
//                            sections[i].items[j].colorCorreo = colorRojo
//                            ready = false
//                            itemsNotReadyArray.append("\n" + item.title)
//                        }
//                        else {
//                            color = colorVerde
//                        }
//                    }
//                    else if item.type == .checkBox {
//                        if item.valueId != "1" {
//                            color = colorRojo
//                            sections[i].items[j].titleColor = colorRojo
//                            ready = false
//                            itemsNotReadyArray.append("\n" + item.title)
//                        }
//                        else {
//                            color = colorVerde
//                        }
//                    }
//                    else if item.type == .checkDerecho {
//                        if item.isActive {
//                            color = colorVerde
//                            if item.identifier != "PrecioAux" && item.identifier != "ObservacionesAux"
//                            {
//                                arrayIdMotivos.append(item.value)
//                            }
//                            print(item.value)
//                            contMotivos += 1
//                            readyAux = true
//                        }
//                        else {
//                            color = colorRojo
//                            ready = false
//                            sections[i].items[j].titleColor = colorRojo
//                            itemsNotReadyArray.append("\n" + item.title)
//                        }
//                        if readyAux
//                        {
//                            ready = true
//                        }
//                        if !readyAux2
//                        {
//                            ready = false
//                        }
//                    }
//                    else if item.type == .autoInteres || item.type == .seguimiento {
//                        ready = ready && item.tableItems.isReadyToSave()
//                    }
                }
                else {
                    color = colorVerde
                }
//
                sections[i].items[j].titleColor = color
            }
        }
//

        //        for (i, section) in sections.enumerated() where section.identifier == etiquetasSec.TELEFONOS.rawValue {
//            print("section: \(sections[i].items.count)")
//            if sections[i].items.count == 1 {
//                sections[i].items[0].titleColor = colorRojo
//                ready = false
//            } else {
//                if sections[i].items.count == 2 {
//                    sections[i].items[1].titleColor = UIColor.black
//                }
//            }
//        }
        
        
        tableView?.reloadData()
        
        return ready
    }
    
    func itemsNotReady() -> [String] {
        return self.itemsNotReadyArray
    }
}

enum InfoItemType: String {
    case `default` = ""
    case spinner = "spinner"
    case button = "boton"
    case datePicker = "datePiker"
    case textField = "textField"
    case label = "label"
    case labelInfo = "labelInfo"
    case dobleCampo = "dobleCampo"
    case phoneNumber = "phoneNumber"
    case mail = "mail"
    case stack = "celdaStack3"
    case observations = "textViewCell"
    case isLineChart = "isLineChart"
    case isPieChart = "isPieChart"
    case isScrollView = "isScrollView"
    case radioOption = "checkCell"
    case radio = "radioCell"
    case checkDerecho = "celdaCatalogoDeclinar"
    case isAddTelephone = "isAddTelephone"
    case isTelefono = "telefonosCell"
    case isAddCorreo = "isAddCorreo"
    case isCorreo = "correoCell"
    case statusbar = "statusBarCell"
    case checkBox = "checkBoxDatosCell"
    case imagenCell = "imagenCell"
    case cellCheckBoxRass = "cellCheckBoxRass"
    case cellDemoRass = "cellDemoRass"
    case iconLabel = "busquedaProspectoCell"
    case precioCell = "precioCell"
    case scoreTcell = "scoreTcell"
    case twoLabelsHCell = "twoLabelsHCell"
    case cellProspectosDu = "cellProspectosDu"
    case cellAutoInteres = "cellAutoInteres"
    case segmented = "SegmentedCell"
    case autoInteres = "AutoInteresCell"
    case seguimiento = "ProximoSeguimientoCell"
    case add = "AddCell"
    case cellThreeRadio = "cellThreeRadio"
    case labelBackGround = "labelBackGround"
    case customCheck = "customCheck"
    case textCell = "textCell"
    case imageBtnCell = "imageBtnCell"
    case headColapsable = "headColapsable"
    
    case pickerView = "pickerViewcell"
    //yopter
    case offertCell = "cellOffert"
    case articulosCell = "ArticulosCell"
    
}

enum AutoInteresType {
    case inventario
    case catalogo
}

class InfoItem: NSObject {
    
    var identifier: String = ""
    var type: InfoItemType = .default
    var required = true {
        didSet {
            self.titleColor = required ? .black : UIColor.lightGray
        }
    }
    var title = ""
    var subtitle = ""
    var value = ""
    var valueId = ""
    var valueCGFloat:CGFloat = 0
    var message = ""
    var url = ""
    var regExValidation = "[\\w\\d\\sñÑáéíóúÁÉÍÓÚ@:.,_-]{0,}"
    var textLength = -1 {
        didSet {
            if textLength > 0 {
                self.regExValidation = "[\\w\\d\\sñÑáéíóúÁÉÍÓÚ@:.,_-]{0,\(self.textLength)}"
            }
        }
    }
    
    //SEGMENTED
    var indexSelected = 0
    // status
    var valueIdStatus = ""
    var titleColor: UIColor = .black
    var itemHeight: CGFloat = 0.0
    var dateValue: Date = Date()
    var keyboardType: UIKeyboardType = .default
    var showItem: Bool = true
    
    //TELÉFONOS Y EXT
    var tipoTelefono = ""
    var idTipoTelefono = ""
    var numTelefono = ""
    var numExt = ""
    var colorTelefono = UIColor.black
    var colorExt = UIColor.black
//    var telefonos: [(tipo: PhoneType, numero: String)] = []
    
    //RADIO
    var leftTitle = ""
    var rightTitle = ""
    
    //CORREO
    var correo = ""
    var tipoCorreo = ""
    var colorCorreo = UIColor.black
    var image: UIImage?
    
    //ARRAYS
    var array: [String] = []
    var biArray: [[String]] = []
    var tupleArray: [(String, String)] = []
    var tupleArray2: [(String, String, String)] = []
    
    //GRAFICAS
    var series: [(value: Int, name: String)] = []
    var series2: [(value: Int, name: String)] = []
    var colors: [UIColor] = []
    
    //Other
    var isActive = false
    var tableCell: UITableViewCell?
//    var json: JSON?
    
    //Auto demoRass
    var autoModeloRass:String?
    var VinRass: String?
    var productoRass:String?
    
    ///proveedor de leads
    var totaleadsPaquete:CGFloat = 0
    var tableItems = InfoManager()
    
    //AUTO DE INTERES
    var autoInteres = InfoItemAutoInteres()
    //SEGUIMIENTO
    var seguimiento = InfoItemSeguimiento()
    
    ///datepicker
    var typePicker : UIDatePicker.Mode = .dateAndTime
    var heightDatePicker : Double = 30.0
    var rechazo : Bool = false
    var posVenta : Bool = false
    
    ///autointeres
    var favorito : Bool = false
    var marca : String?
    var auto : String?
    var version : String?
    var modelo : String?
    var isRepreogramar :Bool = false
    
    var backgroundColor:UIColor?
    var textValueColor:UIColor?
    var IdComponente:String?
    var IdMenu:String?
    
    ///3radio
    var radioH : Double = 21.0
    var l1 : String?
    var l2 : String?
    var l3 : String?
    var v1 : Bool = false
    var v2 : Bool = false
    var v3 : Bool = false
    
    ///2radio
    var lsi : String = "Sí"
    var lno : String = "No"

    
    //labelBackGround
    var colorLabel : UIColor?
    
    //customCheck
    var checkBoxHeight : Int = 35
    var checkmarkLineWidth : Int = 5
    var padding : Int = 15
    var fontSize : Int = 18
    var activeColor : UIColor = UIColor.white
    var inactiveColor : UIColor = UIColor.white
    var inactiveBorderColor : UIColor = UIColor.lightGray
//    var checkMarkColor : UIColor = colorAzul
    var checkMarkColor : UIColor = UIColor.blue
    var enabled : Bool = true
    //var texto = "Texto"
//    var style : RadioCheckboxStyle = .square
    var colorTexto : UIColor = UIColor.black
    var useColorTexto : Bool = false
    var checkSelect : Bool = false
    //var textCell
//    var colorFondo : UIColor = colorAzul
    var colorFondo : UIColor = UIColor.blue
    var textAlig : NSTextAlignment = .justified
    //colapsable
    var setEstadoColapsable = false
    
    var offer = Offer()
    var textAlignmentL:NSTextAlignment = .justified


    
    //var isRequired : Bool = false

    init(identifier: String, type: InfoItemType, title: String, value: String, itemHeight: CGFloat = 60.0) {
        super.init()
        
        self.identifier = identifier
        self.type = type
        self.title = title
        self.value = value
        
        self.itemHeight = itemHeight
        
        switch type {
        case .spinner:
            self.itemHeight = 68.0
            break
        case .button:
            break
        case .datePicker:
            self.itemHeight = 165.0
            break
        case .textField:
            self.itemHeight = 68.0
            break
        case .label:
            break
        case .phoneNumber:
            break
        case .mail:
            break
        case .stack:
            break
        case .observations:
            self.itemHeight = 200.0
            break
        case .isLineChart:
            break
        case .isPieChart:
            break
        case .isScrollView:
            break
        case .radio:
            break
        case .checkDerecho:
            break
        case .isAddTelephone:
            break
        case .isTelefono:
            self.itemHeight = 68.0
            break
        case .add:
            break
        case .isAddCorreo:
            break
        case .isCorreo:
            self.itemHeight = 68.0
            break
        case .statusbar:
            self.itemHeight = 97.0
            break
        case .checkBox:
            break
        case .imagenCell:
            break
        case .cellCheckBoxRass:
            self.itemHeight = 66.0
            break
        case .cellDemoRass:
            break
        case .iconLabel:
            break
        case .precioCell:
            break
        case .scoreTcell:
            break
        case .articulosCell:
            self.itemHeight = 300.0
            break
        default:
            break
        }
    }
}


struct InfoItemAutoInteres {
    var seminuevos = false
    var autoCompleto = false
    var hideTipoCatalogo = false
    var autoInteresType: AutoInteresType = .catalogo
    var autocomplete = true
    var showColor = false
    var hideVersion = false
    var onlyRead = false
    
    var idMarca = ""
    var idAuto = ""
    var modelo = ""
    var idProducto = ""
    var idColor = ""
    var idDistribuidorSeminuevos = ""
}

struct InfoItemSeguimiento {
    var idStatus = ""
    var idTipoActividad = ""
    var idTipoActividadDetalle = ""
    var isRepreogramar: Bool = false
}
