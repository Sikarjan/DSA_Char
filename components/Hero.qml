import QtQuick 2.0

Item {
    property string muText: qsTr("COU")
    property int mu: 8
    property int muMod: mu-burden-pain
    property string klText: qsTr("SGC")
    property int kl: 8
    property int klMod: kl-burden-pain
    property string chText: qsTr("CHA")
    property int ch: 8
    property int chMod: ch-burden-pain
    property string inText: qsTr("INT")
    property int intu: 15
    property int inMod: intu-burden-pain
    property string ffText: qsTr("DEX")
    property int ff: 8
    property int ffMod: ff-burden-pain
    property string geText: qsTr("AGE")
    property int ge: 8
    property int geMod: ge-burden-pain
    property string kkText: qsTr("STR")
    property int kk: 8
    property int kkMod: kk-burden-pain
    property string koText: qsTr("CON")
    property int ko: 8
    property int koMod: ko-burden-pain

    property int leMod: 2
    property int leMax: ko+ko+leMod
    property int le: leMax

    property int aspMod: 20
    property string mainAttr: "intu"
    property int aspMax: aspMod > 0 ? eval(mainAttr)+aspMod:0
    property int asp: aspMax

    property int burden: 0
    property int pain: 0

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

    function rollTalent(prop1, prop2, prop3, skill){
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

        if(roll1 > prop1){
            skill += prop1-roll1;
        }
        if(roll2 > prop2){
           skill += prop2-roll2;
        }
        if(roll3 > prop3){
            skill += prop3-roll3;
        }

        if(skill >= 0){
            var q = Math.floor(skill/3)+1
            return qsTr("You succeeded with a quality ")+q+"\n"+qsTr("Your roll was: ")+roll1+"/"+roll2+"/"+roll3
        }else{
            return qsTr("You failed")+"\n"+qsTr("Your roll was: ")+roll1+"/"+roll2+"/"+roll3
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

    function readHero(hero){
        var attr = hero.attr.values

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
    }
}
