import Cocoa

//var base = 16.0
//let goldenRation = 1.61803398875
//
//for i in 1...10 {
//    base = base * goldenRation
//    print(base.rounded())
//}
//
//base = 16.0
//for i in 1...5 {
//    base = base / goldenRation
//    print(base.rounded())
//}


let baseDamage = 10.0
let hitsPerSecond = 2.0
let timeToKillInSeconds = 10.0

let t1 = baseDamage //timeToKillInSeconds * hitsPerSecond * baseDamage // level 1 common armor base health bonus
let t2 = (t1 * pow(1.1, 4)) // uncommon
let t3 = (t2 * pow(1.1, 4)) // rare
let t4 = (t3 * pow(1.1, 4)) // heroic
let t5 = (t4 * pow(1.1, 4)) // epic
let t6 = (t5 * pow(1.1, 4)) // legendary
let t7 = (t6 * pow(1.1, 4)) // supreme

func random() -> CGFloat {
    return CGFloat(Float.random(in: 0...1))
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(min < max)
    return random() * (max - min) + min
}

enum rarity: String {
    case common, uncommon, rare, heroic, epic, legendary, supreme
}

func armorRandomBaseHealthBonus(rarity: rarity) -> CGFloat {
    
    let min: CGFloat = 0.5
    let max: CGFloat = 2.0
    
    var value = random(min: min, max: max)
    
    value = 2.0 // comment to use random values
    
    switch rarity {
    case .common:
        value = value * CGFloat(t1)
        break
    case .uncommon:
        value = value * CGFloat(t2)
        break
    case .rare:
        value = value * CGFloat(t3)
        break
    case .heroic:
        value = value * CGFloat(t4)
        break
    case .epic:
        value = value * CGFloat(t5)
        break
    case .legendary:
        value = value * CGFloat(t6)
        break
    case .supreme:
        value = value * CGFloat(t7)
        break
    }
    
    return round(value)
}

class Armor: NSObject {
    var level = 1
    var rarity: rarity = .common
}

func armorHealthBonus(armor: Armor) -> Int {
    return Int(armorRandomBaseHealthBonus(rarity: armor.rarity) * CGFloat(pow(1.1, Double(armor.level - 1))))
}

func playerMaxHealth(constitution: Double) -> Int {
    let baseHealth = 100.0
    let baseConstitution = 10.0
    let scale = 1.05
    return Int(baseHealth * pow(scale, constitution - baseConstitution))
}

for i in 0...29 {
    // constitution starts at 13 if warrior
    // constitution starts at 10 if not warrior
    // 100 hp if not warrior and no points spent on constitution
    // 411 hp if not warrior and half points spent on constitution
    // 476 hp if warrior and no points spent on constitution
    // 1694 hp if not warrior and all points spent on constitution
    // 1961 hp if warrior and half points spent on constitution
    // 8073 hp if warrior and all points spent on constitution
    let constitution = Double(13 + i * 3) // on poit per level if warrior plus two optional points per level
    // print("level: \(i + 1) constitution: \(constitution) health: \(playerMaxHealth(constitution: constitution))")
}

let armor = Armor()
for rarity in [rarity.supreme] { //[rarity.common, .uncommon, .rare, .heroic, .epic, .legendary, .supreme] {
    for level in 1...10 {
        armor.rarity = rarity
        armor.level = level
        print("\(rarity) armor level \(level): \(armorHealthBonus(armor: armor))")
    }
}

func xpForLevel(level x: Int) -> Int {
    let x = Double(x - 2)
    let xp = pow(1.1, x) * 1000
    return Int(xp)
}

var xpTotal = 0
for i in 2...90 {
    xpTotal = xpTotal + xpForLevel(level: i)
    // print("Level \(i): \(xpForLevel(level: i))")
    // print("Total xp: \(xpTotal)\n")
}
