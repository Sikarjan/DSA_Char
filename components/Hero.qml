import QtQuick 2.0
import Qt.labs.settings 1.1

Item {
    id: hero
    property string muText: qsTr("COU")
    property int mu: 8
    property int muMod: mu-attrMods
    property string klText: qsTr("SGC")
    property int kl: 8
    property int klMod: kl-attrMods
    property string chText: qsTr("CHA")
    property int ch: 8
    property int chMod: ch-attrMods
    property string inText: qsTr("INT")
    property int intu: 15
    property int inMod: intu-attrMods
    property string ffText: qsTr("DEX")
    property int ff: 8
    property int ffMod: ff-attrMods
    property string geText: qsTr("AGE")
    property int ge: 8
    property int geMod: ge-attrMods
    property string kkText: qsTr("STR")
    property int kk: 8
    property int kkMod: kk-attrMods
    property string koText: qsTr("CON")
    property int ko: 8
    property int koMod: ko-attrMods

    property int leMod: 2
    property int leBought: 0
    property int leMax: ko+ko+leMod+leBought
    property int le: leMax

    property string mainAttr: "intu"

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
    property int dodge: hero.ge/2+dodgeMod
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

    property string hName: " "
    property int raceId: 0
    property string profession: " "
    property int hSize: 0
    property int hWeight: 0
    property string avatar: ""

    property int attrMods: confusion+pain+burden+paralysis+rapture+stupor
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

    function rollTalent(talent, obstacle=0, skillMod=0, mode="mod"){
        var attrTest = talent.check.split(",")
        var skill = talent.level + skillMod
        var attr = {}

        if(mode==="mod"){
            attr = {
                mu: hero.muMod,
                kl: hero.klMod,
                in: hero.inMod,
                ch: hero.chMod,
                ff: hero.ffMod,
                ge: hero.geMod,
                ko: hero.koMod,
                kk: hero.kkMod
            }
        }else{
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

    function readHero(data){
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

        // Checking for ae (ADV_50), KE (ADV_12)
        var activable = data.activatable
        if(activable['ADV_50']){
            hero.aeMod = 0
            hero.aeBought = data.attr.ae
            // mainAttr ???
        }
        if(activable['ADV_12']){
            hero.keMod = 0
            hero.keBought = data.attr.ke
            // mainAttr ???
        }

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

                page3.itemList.append({
                                "item": mItem.name,
                                "amount": mItem.amount,
                                "weight": weight,
                                "price": mItem.price,
                                "whereId": whereId
                                })
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
