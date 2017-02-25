func matchIt(_ criteria: String) -> NSArray{
    var crime: NSArray

    switch criteria {
    case "CO":
        crime = ["SUSPICIOUS PERSON",
                 "SUSPICIOUS VEHICLE",
                 "MENTAL COMPLAINT",
                 "MISCHIEF, NUISANCE COMPLAINTS"]
//    case "Gun Fire":
//        crime = "SHOTS"
//    case "Theft":
//        crime = "THEFT (DOES NOT INCLUDE SHOPLIFT OR SVCS)"
//    case "Assault":
//        crime = "ASLT - IP/JO - WITH OR W/O WPNS (NO SHOOTINGS)"
//    case "Breaking and Entering":
//        crime = "ALARMS - RESIDENTIAL BURGLARY"
//    case "Burgulary":
//        crime = "BURG - IP/JO - RES (INCL UNOCC STRUCTURES)"
//    case "Property Damage":
//        crime = "PROPERTY - DAMAGE"
    default:
        crime = [criteria.uppercased()]
    }
    return crime
}


var crimeList = ["SUSPICIOUS PERSON",
                 "SUSPICIOUS VEHICLE",
                 "MENTAL COMPLAINT",
                 "MISCHIEF, NUISANCE COMPLAINTS",
                 "LEWD CONDUCT",
                 "NOISE DISTURBANCE",
                 "PORNOGRAPHY"]
let temp = "co"
let crime = temp.uppercased()

let parsed = matchIt(crime)

for i in 0 ..< crimeList.count {
    for j in 0..<parsed.count {
        let nCrime = parsed[j] as! String
        if crimeList[i].range(of: nCrime, options: .regularExpression) != nil {
            print(crimeList[i])
        }
    }
}
