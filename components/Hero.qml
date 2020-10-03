import QtQuick 2.0
import Qt.labs.settings 1.1

Item {
    id: hero
    property string muText: qsTr("COU")
    property int mu: 8
    property string klText: qsTr("SGC")
    property int kl: 8
    property string chText: qsTr("CHA")
    property int ch: 8
    property string inText: qsTr("INT")
    property int intu: 8
    property string ffText: qsTr("DEX")
    property int ff: 8
    property string geText: qsTr("AGE")
    property int ge: 8
    property string kkText: qsTr("STR")
    property int kk: 8
    property string koText: qsTr("CON")
    property int ko: 8

    property int leMod: 2
    property int leBought: 0
    property int leMax: ko+ko+leMod+leBought
    property int le: leMax

    property string mainAttr: ""

    property int aeMod: -1
    property int aeBought: 0
    property int aeMax: aeMod >= 0 ? eval(mainAttr)+aeMod+aeBought+20:0
    property int ae: aeMax

    property int keMod: -1
    property int keBought: 0
    property int keMax: keMod >= 0 ? eval(mainAttr)+keMod+keBought+20:0
    property int ke: keMax

    property int maxLoad: kk*2
    property real currentLoad: 0
    property int weightBurden: 0

    property int spiritBase:-4
    property int spiritMod: 0
    property int spirit: Math.round((hero.mu+hero.kl+hero.intu)/6)+spiritBase+spiritMod
    property int toughnessBase: -4
    property int toughnessMod: 0
    property int toughness: Math.round((hero.ko*2+hero.kk)/6)+toughnessBase+toughnessMod
    property int dodge: Math.round(hero.ge/2)+dodgeMod
    property int dodgeMod: 0
    property int iniMod: 0
    property int iniBase: Math.round((hero.mu+hero.ge)/2)+iniMod
    property int moveRaceMod: 0
    property int moveMod: 0
    property int move: 8+moveMod+moveRaceMod
    property int fatePoints: 3
    property int fatePointsMod: 0
    property int fatePointsMax: 3+fatePointsMod

    property int confusion: 0
    property int pain: 0
    property int burden: 0
    property int paralysis: 0
    property int rapture: 0
    property int stupor: 0
    property int fear: 0

    property string hName: " "
    property int raceId: 0
    property string profession: " "
    property int hSize: 0
    property int hWeight: 0
    property string avatar: ""

    property int stateModAll: confusion+pain+burden+paralysis+rapture+stupor+fear
    property int stateModMove: burden+pain+paralysis*0.25*(8+moveMod+moveRaceMod)
    property int stateModTalent: stupor+rapture+pain+confusion+fear
    property int stateModMagic: stupor+rapture+fear+pain+confusion+paralysis

    Settings {
        property alias mu: hero.mu
        property alias kl: hero.kl
        property alias ch: hero.ch
        property alias intu: hero.intu
        property alias ff: hero.ff
        property alias ge: hero.ge
        property alias kk: hero.kk
        property alias ko: hero.ko

        property alias le: hero.le
        property alias leBought: hero.leBought
        property alias aeMod: hero.aeMod
        property alias aeBought: hero.aeBought
        property alias ae: hero.ae
        property alias keMod: hero.keMod
        property alias keBought: hero.keBought
        property alias ke: hero.ke
        property alias mainAttr: hero.mainAttr

        property alias spiritBase: hero.spiritBase
        property alias spiritMod: hero.spiritMod
        property alias toughnessBase: hero.toughnessBase
        property alias toughnessMod: hero.toughnessMod
        property alias dodgeMod: hero.dodgeMod
        property alias fatePoints: hero.fatePoints
        property alias fatePointsMod: hero.fatePointsMod

        property alias confusion: hero.confusion
        property alias pain: hero.pain
        property alias burden: hero.burden
        property alias paralysis: hero.paralysis
        property alias rapture: hero.rapture
        property alias stupor: hero.stupor

        property alias hName: hero.hName
        property alias raceId: hero.raceId
        property alias profession: hero.profession
        property alias hSize: hero.hSize
        property alias hWeight: hero.hWeight
        property alias avatar: hero.avatar

        property alias currentLoad: hero.currentLoad
        property alias weightBurden: hero.weightBurden
    }

    onKkChanged: {
        if(page3.bagList.count >0){
            page3.bagList.setProperty(0,"size", kk*2)
        }
    }
    onLeChanged: {
        if(le<=5){
            pain = 4
        }else if(le<leMax/4){
            pain = 3
        }else if(le<leMax/2){
            pain = 2
        }else if(le<leMax/4*3){
            pain = 1
        }else{
            pain = 0
        }
    }

    onCurrentLoadChanged: {
        if(currentLoad > maxLoad){
            var extraFill = currentLoad - maxLoad
            var extraBurden = Math.floor(extraFill/4)+1

            burden += extraBurden - weightBurden
            weightBurden = extraBurden
        }else if(weightBurden > 0){
            burden -= weightBurden
            weightBurden = 0
        }
    }

    function getAttr(mAttr, cat=0, enc=0, par=0){ // cat 0=text, 1=Attr values, 2=For Talent, 3=For Spell, 4=All mods     enc 0=No, 1=Yes     par  0=No, 1=Yes
        var attr = {
            mu: hero.mu,
            kl: hero.kl,
            in: hero.intu,
            ch: hero.ch,
            ff: hero.ff,
            ge: hero.ge,
            ko: hero.ko,
            kk: hero.kk
        }
        var attrName = {
            mu: hero.muText,
            kl: hero.klText,
            in: hero.inText,
            ch: hero.chText,
            ff: hero.ffText,
            ge: hero.geText,
            ko: hero.koText,
            kk: hero.kkText
        }
        var attrs = mAttr.split("/")
        var res = ""

        for(const a of attrs){
            if(a in attr){
                if(cat === 0){
                    res += attrName[a]
                }else if(cat === 1){
                    res += attr[a]
                }else if(cat === 2){
                    res += attr[a] - hero.stateModTalent - (enc===0 ? 0:hero.burden) - (par === 0 ? 0:hero.paralysis)
                }else if(cat === 3){
                    res += attr[a] - hero.stateModMagic
                }else{
                    res += attr[a] - hero.stateModAll
                }

                res += "/"
            }
        }
        return res.slice(0,-1)
    }

    function getMainCtAttrValue(pAttr){
        if(pAttr.length < 3){
            return getAttr(pAttr,1)
        }

        var attrs = pAttr.split("/")
        for(var i=0;i<attrs.length;++i){
            attrs[i] = getAttr(attrs[i],1)
        }
        return Math.max.apply(null, attrs)
    }

    function rollTalent(talent, obstacle=0, skillMod=0){
        var attrTest = talent.check.split("/")
        var skill = talent.level + skillMod
        var attr = {}

        attr = {
            mu: hero.mu,
            kl: hero.kl,
            in: hero.intu,
            ch: hero.ch,
            ff: hero.ff,
            ge: hero.ge,
            ko: hero.ko,
            kk: hero.kk
        }

        var roll1 = Math.floor((Math.random()*20)+1)
        var roll2 = Math.floor((Math.random()*20)+1)
        var roll3 = Math.floor((Math.random()*20)+1)
        var a = 0
        var b = 0

        // Kritischer Erfolg
        if(roll1 === 1){
            a++;
        }
        if(roll2 === 1){
            a++;
        }
        if(roll3 === 1){
            a++;
        }
        if(a===3){
            return qsTr("Magical success")
        }else if(a === 2){
            return qsTr("Perfect success")
        }

        // Kritischer Fehlschlag
        if(roll1 === 20){
            b++;
        }
        if(roll2 === 20){
            b++;
        }
        if(roll3 === 20){
            b++;
        }
        if(b===3){
            return qsTr("Critical error")
        }else if(b === 2){
            return qsTr("Catastrophic error")
        }

        var t1 = attr[attrTest[0]] + obstacle
        var t2 = attr[attrTest[1]] + obstacle
        var t3 = attr[attrTest[2]] + obstacle

        if(roll1 > t1){
            skill += t1-roll1;
        }
        if(roll2 > t2){
           skill += t2-roll2;
        }
        if(roll3 > t3){
            skill += t3-roll3;
        }

        if(skill >= 0){
            var q = Math.floor(skill/3)+1
            return qsTr("You succeeded with a quality %1 (%2).").arg(q).arg(skill)+"\n"+qsTr("Your roll was: ")+roll1+" vs "+t1+"/"+roll2+" vs "+t2+"/"+roll3+" vs "+t3
        }else{
            return qsTr("You failed")+"\n"+qsTr("Your roll was: ")+roll1+" vs "+t1+"/"+roll2+" vs "+t2+"/"+roll3+" vs "+t3
        }
    }

    function importHero(url){
        var xhr = new XMLHttpRequest;
        xhr.open("GET", url);
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){
                var response = xhr.responseText;
                var hero = JSON.parse(response)
                readHero(hero)
            }
        }
        xhr.send();
    }

    function resetHero(){
        hero.moveMod = 0
        hero.iniMod = 0
        hero.fatePointsMod = 0
        hero.confusion = 0
        hero.pain = 0
        hero.paralysis = 0
        hero.burden = 0
        hero.rapture = 0
        hero.stupor = 0
        hero.fear = 0
    }

    function readHero(data){
        resetHero()

        hero.hName = data.name+" "+data.pers.family
        hero.profession = data.professionName
        hero.hSize = data.pers.size
        hero.hWeight = data.pers.weight
        hero.raceId = data.r.substring(2)
        hero.avatar = data.avatar

        var attr = data.attr.values
        for(var i=0;i<8; i++){
            switch(attr[i].id){
            case "ATTR_1":
                mu = attr[i].value
                break;
            case "ATTR_2":
                kl = attr[i].value
                break;
            case "ATTR_3":
                intu = attr[i].value
                break;
            case "ATTR_4":
                ch = attr[i].value
                break;
            case "ATTR_5":
                ff = attr[i].value
                break;
            case "ATTR_6":
                ge = attr[i].value
                break;
            case "ATTR_7":
                ko = attr[i].value
                break;
            case "ATTR_8":
                kk = attr[i].value
                break;
            }
        }
        hero.leBought = data.attr.lp

        // Checking for Advantages/Disadvantages
        // Checking for ae (ADV_50), KE (ADV_12)
        var activable = data.activatable
        var getMainAttr = false
        if(activable['ADV_50']){
            hero.aeMod = 0
            hero.aeBought = data.attr.ae
            getMainAttr = true
        }else{
            hero.aeMod = -1
        }

        if(activable['ADV_12']){
            hero.keMod = 0
            hero.keBought = data.attr.ke
            getMainAttr = true
        }else{
            hero.keMod = -1
        }

        if(getMainAttr) {
            getMainAttrDialog.visible = true
        }

        // Movement
        if(activable['ADV_9']){ // nimble
            hero.moveMod += 1
        }else if(activable['DISADV_4']){
            hero.moveMod -= 1
        }

        // Fate fatePoint
        if(activable['ADV_14']){
            hero.fatePointsMod += 1
        }else if(activable['DISADV_31']){
            hero.fatePointsMod += 1
        }

        // Unyielding
        if(activable['ADV_54']){
            // Schmerzbelastung eins weniger implementieren
        }

        // END Checking Advantages/Disadvantages
        // Loading Skills
        var skills = data.talents

        // Resetting data
        for(i=0;i<page2.skillList.count;i++){
            page2.skillList.setProperty(i,"level",0)
        }
        for(var sKey in skills){
            var skill = skills[sKey]

            page2.skillView.setSkill(sKey, "level", skill)
        }

        // Load Combat Techniques
        var ct = data.ct
        for(i=0;i<pageCombat.ctList.count;i++){
            pageCombat.ctList.setProperty(i,"level",6)
        }
        for(sKey in ct){
            skill = ct[sKey]

            pageCombat.combatTalents.setSkill(sKey, "level", skill)
        }

        var belongings = data.belongings.items
        page3.itemList.clear()
        page3.bagList.clear()
        page3.bagList.append({
               "bagId": 0,
               "bagName": qsTr("Body"),
               "size": hero.maxLoad,
               "type": "body",
               "weight": 0,
               "price": 0,
               "load": 0,
               "where": "-",
               "dropped": false
        })
        page3.bagList.nextId = 1
        editItemWhereMenu()
        currentLoad = 0

        // First run to find bags
        var bags = ["@"]
        for (var key in belongings){
//            console.log(key)
            var item = belongings[key]
            var template = 0

            if('template' in item){
                template = item.template.substring(8)
            }

            if(template>88 && template <92 || template>201 && template <205){ //Needs to be checked if all kinds of bags are captured!
                switch(template){
                case 89: //deggar sheath
                    item.gr = 5
                    break;
                case 90: // quiver
                    item.gr = 10
                    break
                case 91: // scabbard
                    item.gr = 8
                    break
                case 202: // bumbag
                    item.gr = 2
                    break;
                case 204: // backpack
                    item.gr = 50
                }

                addBag(item);
                bags.push(item.name)
            }
        }

        // Second run to add items
        for (var iKey in belongings){
            var mItem = belongings[iKey]
            var mTemplate = 0

            if('template' in mItem){
                mTemplate = mItem.template.substring(8)
            }

            if(mTemplate>88 && mTemplate <92 || mTemplate>201 && mTemplate <205){
              // Bag already added
            }else{
                var weight = 0
                if('weight' in mItem){
                    weight = mItem.weight
                }

                var whereId = 0
                var id = bags.indexOf(mItem.where)
                if(id > 0){
                    whereId = id
                }

                if('reach' in mItem){// Check if weapon
                    page3.itemList.append({
                            "item": mItem.name,
                            "type": "weapon",
                            "amount": mItem.amount,
                            "weight": weight,
                            "price": mItem.price,
                            "whereId": whereId,
                            "damageDice": mItem.damageDiceNumber,
                            "damageFlat": mItem.damageFlat,
                            "damageBonus": mItem.primaryThreshold.threshold,
                            "reach": mItem.reach,
                            "at": mItem.at,
                            "pa": mItem.pa,
                            "ct": mItem.combatTechnique
                    })
                }else if('range' in mItem){ // Range weapons
                    var ammo = qsTr("Bolts")
                    if(mItem.ammunition === "ITEMTPL_75"){
                        ammo = qsTr("Arrows")
                    }

                    page3.itemList.append({
                            "item": mItem.name,
                            "type": "rangeWeapon",
                            "amount": mItem.amount,
                            "weight": weight,
                            "price": mItem.price,
                            "whereId": whereId,
                            "damageDice": mItem.damageDiceNumber,
                            "damageFlat": mItem.damageFlat,
                            "range": JSON.stringify(mItem.range),
                            "reload": mItem.reloadTime,
                            "ammunition": ammo,
                            "ct": mItem.combatTechnique
                    })
                }else if('armorType' in mItem){
                    page3.itemList.append({
                            "item": mItem.name,
                            "type": "armor",
                            "amount": mItem.amount,
                            "weight": weight,
                            "price": mItem.price,
                            "whereId": whereId,
                            "enc": mItem.enc,
                            "protection": mItem.pro,
                            "armorType": mItem.armorType
                    })
                    if(mItem.armorType%2 === 0 && whereId === 0){
                        hero.iniMod -= 1
                        hero.moveMod -= 1
                    }
                } else {
                    page3.itemList.append({
                            "item": mItem.name,
                            "type": "item",
                            "amount": mItem.amount,
                            "weight": weight,
                            "price": mItem.price,
                            "whereId": whereId
                    })
                }

                // Add weight of bag to the hero
                addWeight(weight, whereId)
            }
        }

        page3.itemList.sortItems()
    }

    function addBag(item){
        var where = qsTr("Body")
        var type = 'import'

        if('where' in item){
            where = item.where
        }
        if('type' in item){
            type = item.type
        }

        page3.bagList.append({
                       "bagId": page3.bagList.nextId,
                       "bagName": item.name,
                       "size": item.gr,
                       "type": type,
                       "weight": item.weight,
                       "price":item.price,
                       "load": 0,
                       "where": where,
                       "dropped": false
                       })

        // Add weight of bag to the hero
        addWeight(item.weight, 0)

        addItemWhereMenu(item.name, page3.bagList.nextId)

        page3.bagList.nextId++
    }

    function addItemWhereMenu(name, id){
        var mItem = Qt.createQmlObject('import QtQuick 2.12; import QtQuick.Controls 2.12; MenuItem { property int bagId}', page3.itemWhereMenu)
        mItem.text = name
        mItem.bagId = id
        page3.itemWhereMenu.addItem(mItem)
        var f = function(it){
            it.triggered.connect(function(){ page3.itemList.moveItem(it.bagId)})
        }
        f(mItem)
    }

    function editItemWhereMenu(task = "delete"){
        while(page3.itemWhereMenu.count > 1){
            page3.itemWhereMenu.removeItem(page3.itemWhereMenu.itemAt(1))
        }

        if(task === "new"){
            for(var j=1;j<page3.bagList.count;j++){
                var bag = page3.bagList.get(j)
                addItemWhereMenu(bag.bagName, bag.bagId)
            }
        }
    }

    function addWeight(weight, bagId){
        hero.currentLoad += weight
        page3.bagList.setProperty(0, "load", page3.bagList.get(0).load+weight)

        if(bagId > 0){
            page3.bagList.setProperty(bagId, "load", page3.bagList.get(bagId).load+weight)
        }
    }
}
