//
//  ServersViewController.swift
//  AMM
//
//  Created by Sinkerine on 19/02/2017.
//  Copyright © 2017 sinkerine. All rights reserved.
//

import Cocoa

class ServersViewController: NSViewController, NSTableViewDataSource {
    let preferences = AMMPreferences.instance
    let tableViewDragType = "amm.serverprofile"

    @IBOutlet var arrayController: ServerProfileArrayController!
    @IBOutlet weak var serversTableScrollView: NSScrollView! {
        didSet {
            serversTableScrollView.borderType = .noBorder
        }
    }
    @IBOutlet weak var serversTableView: NSTableView! {
        didSet {
            serversTableView.dataSource = self
            serversTableView.register(forDraggedTypes: [tableViewDragType])
        }
    }
    @IBOutlet weak var protocolPopUpBtn: NSPopUpButton! {
        didSet {
            protocolPopUpBtn.addItems(withTitles: Aria2Protocols.allValues.map({$0.rawValue}))
            if !preferences.servers.isEmpty {
                let protocolOfSelection = (arrayController.selection as AnyObject).value(forKey: "ptclRawValue") as! String?
                protocolPopUpBtn.selectItem(withTitle: protocolOfSelection!)
            }
        }
    }
    @IBOutlet weak var setDefaultServerCheckBox: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setDefaultServerCheckBox.toolTip = "If you set this server as default, when opening associated items, AMM will send tasks to it directly instead of asking you to choose one"
    }
    
    // Drag & Drop to reorder rows
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        let data = NSKeyedArchiver.archivedData(withRootObject: rowIndexes)
        pboard.declareTypes([tableViewDragType], owner: self)
        pboard.setData(data, forType: tableViewDragType)
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        if dropOperation == .above {
            return .move
        }
        return NSDragOperation()
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
        let pbboard = info.draggingPasteboard()
        if let indexesData = pbboard.data(forType: tableViewDragType) {
            let oldIndexes: IndexSet = NSKeyedUnarchiver.unarchiveObject(with: indexesData) as! IndexSet
            var profilesToMove:[ServerProfile] = []
            var offset = 0
            for index in oldIndexes {
                profilesToMove.append(preferences.servers[index])
                if index < row {
                    offset -= 1
                }
            }
            arrayController.remove(atArrangedObjectIndexes: oldIndexes)
            arrayController.insert(contentsOf: profilesToMove, atArrangedObjectIndexes: IndexSet((row + offset)..<(row + offset + profilesToMove.count)))
            return true
        }
        return false
    }
    
    // Association Checkbox
    @IBAction func setDefaultServercheckBoxClicked(_ sender: Any) {
        let selectedServer = arrayController.selectedObjects[0] as! ServerProfile
        if(selectedServer.isDefaultServer) {
            for server in arrayController.arrangedObjects as! [ServerProfile] {
                if server != selectedServer {
                    server.isDefaultServer = false
                }
            }
        }
    }
}
