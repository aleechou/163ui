
var co = require('co')
var thunkify = require('thunkify')
var fs = require('fs')
var child_process = require('child_process')
var toc = require('./toc.js')
require('./dateformat.js')

var readdir = thunkify(fs.readdir)
var fsstat = thunkify(fs.stat)
var fsstat = thunkify(fs.stat)
var readFile = thunkify(fs.readFile)
var writeFile = thunkify(fs.writeFile)
var exec = thunkify(child_process.exec)



var addonsDir = __dirname + "/../Interface/AddOns/"
var ignores = { "!!!163UI.3dcodecmd!!!-src":1 }

co(function*(){

	var filenameList = yield readdir(addonsDir)
	var addonNames = []

	var updated = false

	for(var i=0;i<filenameList.length;i++){

		var filename = filenameList[i]
		if(ignores[filename])
			continue

		if( !(yield fsstat(addonsDir+filename)).isDirectory() ){
			continue
		}

		var tocpath = addonsDir+filename+"/"+filename+".toc"
		if( !(yield fsstat(tocpath)).isFile() ){
			continue
		}

		var tocContent = (yield readFile(tocpath)).toString()
		var tocmeta = toc.parseTocFile(tocContent,{"X-163UI-Version":1})

		var output = yield exec("git log -10 --pretty=\"%at:%s\" \""+addonsDir+filename+"\"")

		var lastUpdateTime
		if(!output.trim()){
			lastUpdateTime = Date.now()
		}
		else {

			var lines = output.toString().split("\n")
			for(var l=0;l<lines.length;l++){
				var slices = lines[l].split(":")
				// console.log(slices)
				if( slices[1]=="update X-163UI-Version" ){
					continue
				}
				lastUpdateTime = parseInt(slices[0].trim())
				break
			}
		}

		

		var lastUpdateTime = new Date(lastUpdateTime*1000)

		var xversion = lastUpdateTime.Format("yyyyMMddhhmmss")

		if( !tocmeta["X-163UI-Version"] || tocmeta["X-163UI-Version"]=="NaNaNaNaNaNaN" || tocmeta["X-163UI-Version"].length<14 || tocmeta["X-163UI-Version"]<xversion){
			console.log("update X-163UI-Version:[",filename,"]",tocmeta["X-163UI-Version"],">",xversion)

			newtocContent = tocContent.replace(/##\s*(X\-)?163UI\-Version\s*:\s*[\d\\\/\-]+/g,"## X-163UI-Version: "+xversion) ;
			//console.log(tocContent)

			yield writeFile(tocpath,newtocContent)

			yield exec("git add \""+tocpath+"\"")

			updated = true
		}
	}

	if(updated){
		yield exec("git commit -m 'update X-163UI-Version'",{cwd:__dirname})
		yield exec("git push -u origin",{cwd:__dirname})
	}

})()

