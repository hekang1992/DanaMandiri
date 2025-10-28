//
//  DeviceInfoManager.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/18.
//

import UIKit
import DeviceKit
import Foundation

class DeviceInfoManager {
    let lausize: Lausize
    let forgetacity: Forgetacity
    let anythingine: Anythingine
    let opener: Opener
    let subter: Subter
    let professorarium: Professorarium
    
    let json: [String: Any]
    
    init() {
        self.lausize = Lausize()
        self.forgetacity = Forgetacity()
        self.anythingine = Anythingine()
        self.subter = Subter()
        self.opener = Opener()
        self.professorarium = Professorarium()
        self.json = ["lausize": lausize.toJson(),
                     "forgetacity": forgetacity.toJson(),
                     "anythingine": anythingine.toJson(),
                     "professorarium": professorarium.toJson(),
                     "subter": subter.toJson(),
                     "foldic": ["opener": [opener.toJson()]]]
    }
    
    func toJson() -> [String: Any] {
        return json
    }
    
    static func backJson() -> [String: Any] {
        let instanca = DeviceInfoManager()
        return instanca.toJson()
    }
    
}

class Lausize {
    var allelery: String?
    var kindment: String?
    var gratern: String?
    var statementative: String?
    
    init(allelery: String? = nil, kindment: String? = nil, gratern: String? = nil, statementative: String? = nil) {
        let diskInfo = DiskSpaceHelper.getDiskSpaceInfo()
        self.allelery = diskInfo.available
        self.kindment = diskInfo.total
        self.gratern = MemerinConfig.getTotalMemoryString()
        self.statementative = MemerinConfig.getAvailableMemoryString()
    }
    
    func toJson() -> [String: String] {
        return ["allelery": allelery ?? "",
                "kindment": kindment ?? "",
                "gratern": gratern ?? "",
                "statementative": statementative ?? ""]
    }
    
}

class Forgetacity {
    var opoterard: String?
    var acetoot: String?
    
    init(opoterard: String? = nil, acetoot: String? = nil) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        self.opoterard = String(Forgetacity.getBatteryLevel())
        self.acetoot = String(Forgetacity.isCharging())
    }
    
    static func getBatteryLevel() -> Int {
        let level = Device.current.batteryLevel ?? 0
        guard level >= 0 else { return -1 }
        return Int(level)
    }
    
    static func isCharging() -> Int {
        switch Device.current.batteryState {
        case .charging, .full:
            return 1
        default:
            return 0
        }
    }
    
    func toJson() -> [String: String] {
        return ["opoterard": opoterard ?? "",
                "acetoot": acetoot ?? ""]
    }
    
}


class Professorarium {
    var bolaally: String?
    var fabeous: String?
    var firmette: String?
    var troglial: String?
    var pont: String?
    var helioion: String?
    var war: String?
    
    init(bolaally: String? = nil, fabeous: String? = nil, firmette: String? = nil, troglial: String? = nil, pont: String? = nil, helioion: String? = nil, war: String? = nil) {
        self.bolaally = Device.current.systemVersion ?? ""
        self.fabeous = Device.current.name
        self.firmette = Device.identifier
        self.troglial = Device.current.description
        self.pont = String(Int(UIScreen.main.bounds.size.height))
        self.helioion = String(Int(UIScreen.main.bounds.size.width))
        self.war = String(Device.current.diagonal)
    }
    
    func toJson() -> [String: String] {
        return ["bolaally": bolaally ?? "",
                "fabeous": fabeous ?? "",
                "firmette": firmette ?? "",
                "troglial": troglial ?? "",
                "pont": pont ?? "",
                "helioion": helioion ?? "",
                "war": war ?? ""]
    }
    
}

class Anythingine {
    var germinproof: String { "100" }
    var genarfier: String { "0" }
    var graph: String { String(Device.current.isSimulator ? 1 : 0) }
    var gregheavyant: String { String(JailbreakDetector.isJailbroken()) }
    
    func toJson() -> [String: String] {
        return ["germinproof": germinproof,
                "genarfier": genarfier,
                "graph": graph,
                "gregheavyant": gregheavyant]
    }
    
}

class Subter {
    var myrmec: String?
    var wearic: String?
    var feelaneity: String?
    var own: String?
    var centrten: String?
    var iton: String?
    var situationature: String?
    var truety: String?
    var intro: String?
    var coprise: String?
    var coldlike: String?
    
    init(myrmec: String? = nil, wearic: String? = nil, feelaneity: String? = nil, own: String? = nil, centrten: String? = nil, iton: String? = nil, situationature: String? = nil, truety: String? = nil, intro: String? = nil, coprise: String? = nil, coldlike: String? = nil) {
        self.myrmec = NSTimeZone.system.abbreviation() ?? ""
        self.wearic = String(DeinfoVoipInfo.proxyStatus.rawValue)
        self.feelaneity = String(DeinfoVoipInfo.vpnStatus.rawValue)
        self.own = ""
        self.centrten = IDFVManager.shared.getPersistentIDFV() ?? ""
        self.iton = Locale.preferredLanguages.first ?? "en_US"
        self.situationature = UserDefaults.standard.object(forKey: "network") as? String ?? ""
        self.truety = String(Device.current.isPhone ? 1 : 0)
        self.intro = GetIpInfo.getIPAddress() ?? ""
        self.coprise = SSIDInfo.getBSSID() ?? ""
        self.coldlike = IDFAManager.getIDFA() ?? ""
    }
    
    func toJson() -> [String: String] {
        return ["myrmec": myrmec ?? "",
                "wearic": wearic ?? "",
                "feelaneity": feelaneity ?? "",
                "own": own ?? "",
                "centrten": centrten ?? "",
                "iton": iton ?? "",
                "situationature": situationature ?? "",
                "truety": truety ?? "",
                "intro": intro ?? "",
                "coprise": coprise ?? "",
                "coldlike": coldlike ?? ""]
    }
}

struct DiskSpaceHelper {
    
   static func getDiskSpaceInfo() -> (total: String, available: String) {
        let rootURL = URL(fileURLWithPath: "/")
        do {
            let values = try rootURL.resourceValues(forKeys: [.volumeTotalCapacityKey, .volumeAvailableCapacityKey])
            
            if let total = values.volumeTotalCapacity,
               let available = values.volumeAvailableCapacity {
                return ("\(total)", "\(available)")
            } else {
                return ("0", "0")
            }
        } catch {
            return ("0", "0")
        }
    }

}

class MemerinConfig: NSObject {
    
    static func getTotalMemoryString() -> String {
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        return String(totalMemory)
    }
    
    static func getAvailableMemoryString() -> String {
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
        
        let hostPort = mach_host_self()
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &count)
            }
        }
        
        if result != KERN_SUCCESS {
            return "0"
        }
        
        let pageSize = vm_kernel_page_size
        let freeMemory = UInt64(stats.free_count + stats.inactive_count) * UInt64(pageSize)
        
        return String(freeMemory)
    }
    
    
}
