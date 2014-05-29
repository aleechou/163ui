#! /usr/bin/env node

if(!process.argv[2]){
	console.log("miss child dir name of packages")
	process.exit()
}
var targetDirName = process.argv[2]

var q = require("q")
var fs = require("fs")
var crypto = require('crypto')
var zipdir = require("zip-dir")
var EasyZip = require('easy-zip').EasyZip
var child_process = require("child_process")
var Steps = require("ocsteps")





var srcdir = __dirname+"/../Interface/AddOns"
var workdir = __dirname+"/workdir"
var packagesdir = workdir + "/packages"
var targetdir = packagesdir + '/' + targetDirName
var addonsIndexJson = workdir + "/addons-index.json"
var addonsIndexTar = workdir + "/addons-index.zip"


// 检查 workdir 是否存在
if( !fs.existsSync(workdir) || !fs.statSync(workdir).isDirectory() ){
    console.error("can not found workdir, please link to.")
    console.log("nothing to do.")
    process.exit()
}
// 创建 packages/target 目录
if( !fs.existsSync(packagesdir) ){
    fs.mkdir(packagesdir)
    console.log("create packages dir",packagesdir)
}
if( !fs.existsSync(targetdir) ){
    fs.mkdir(targetdir)
    console.log("create target dir",targetdir)
}

var indexjson = require("./index.json") 
var addonsJson = require("./addons-index.json")
addonsJson.addons = []
addonsJson.addonsDirUrl+= "/" + targetDirName
if(!addonsJson.ignore) addonsJson.ignore = {}

fs.readdirSync(srcdir)
.reduce(function(addons,filename){
	(!addonsJson.ignore[filename])
    	&& fs.statSync(srcdir+"/"+filename).isDirectory()
		&& fs.existsSync(srcdir+"/"+filename+"/"+filename+".toc")
		&& addons.push( parseToc(filename) )
    return addons
},addonsJson.addons)


Steps()
/*
	// 清除 packages
	.step(function(){
    	child_process.execFile("rm", ["-r",packagesdir], {}, this.hold())
	})
	.step(function(err){
		if(err){
			console.log("can not clear packages folder")
			console.log(err)
		}
		else {
			fs.mkdir(packagesdir,this.holdButThrowError())
		}
	})
*/

	.step(function(){

		this.each(addonsJson.addons,function(i,addon){

    		var tarpath = targetdir+"/"+addon.name+".zip" ;

    		child_process.execFile(
    			"zip", [tarpath,"-r","."], {cwd: srcdir+"/"+addon.name}, this.hold()
    		)

    		this
	    		.step(function(err,stdout,stderr){
	    			//console.log(stdout.toString())
	    			//console.log(stderr.toString())
	    			if(err){
	    				this.terminate()
	    				return
	    			}

			    	console.log("packed addon",addon.name)
			    	md5file(tarpath,this.holdButThrowError())
	    		})
	    		.step(function(err,md5){
		    		addon.pkgmd5 = md5
		    		fs.stat(tarpath,this.holdButThrowError())
	    		})
	    		.step(function(err,stats){
				    addon.pkglen = stats.size
				    console.log("  >",addon.pkgmd5,addon.pkglen)
	    		})

		})
	})


	.step(function(){
	    console.log("make addons-index.json file ...",addonsIndexJson)
	    addonsJson.ignore = undefined
	    fs.writeFileSync(addonsIndexJson,JSON.stringify(addonsJson))
	    fs.exists(addonsIndexTar,this.hold())
	})
	.step(function(exists){
		if(exists){
		    console.log("delete addons-index.zip")
		    fs.unlink (addonsIndexTar,this.holdButThrowError())
		}
	})
	.step(function(){
	    console.log("compress addons-index.json file to addons-index.zip ...")
	    var release = this.hold()
	    var zip = new EasyZip()
	    zip.addFile("addons-index.json",addonsIndexJson,function(){
			zip.writeToFile(addonsIndexTar,function(){
			    release()
			})
	    })
	})
	.step(function(){
	    // md5 tar.gz file
	    return md5file(addonsIndexTar,this.holdButThrowError())
	})
	.step(function(err,md5v){
	    indexjson.addonsIndex = "addons-index.zip"
	    indexjson.addonsIndexFilename = "addons-index.json"
	    indexjson.addonsIndexMD5 = md5v
		indexjson.buildTime = (new Date).toString()

	    fs.writeFile (workdir+"/index.json", JSON.stringify(indexjson,null,4),this.holdButThrowError())
	})
	.step(function(){
	    console.log("created index.json file.")
	})

	.catch(function(error){
	    console.error(error)
	    console.error(error.stack)
	})

	.done(function(){
		console.log("done")
	}) ()



function parseToc(addonName){

    var addonDir = srcdir+"/"+addonName ;
    var content = fs.readFileSync(addonDir+"/"+addonName+".toc").toString() ;
    var lines = content.split("\n");

    var toc = {
		name: addonName
		, metainfo: {}
		, files: {}
    } ;

    for(var i=0;i<lines.length;i++){
		var line = lines[i].trim() ;

		if(!line){
		    continue ;
		}

		// config option
		var res = /##\s*([^:]+):\s*(.+)$/.exec(line) ;
		if(res/* && res[1]=="163UI-Version"*/){
		toc.metainfo[ res[1] ] = res[2] ;
		}
    }

    function findfiles(subdir){
		fs.readdirSync(addonDir+"/"+subdir).map(function(filename){
		    if(filename=='.' || filename=='..')
				return ;
		    if( fs.statSync(addonDir+"/"+subdir+filename).isDirectory() ){
				findfiles(subdir+filename+"/") ;
		    }
		    else{
				toc.files[ subdir+filename ]
				    = md5fileSync( addonDir+"/"+subdir+filename ) ;
		    }
		}) ;
    }

    findfiles("") ;
    
    //console.log("found files:",Object.keys(toc.files).length) ;

    return toc ;
}

function md5fileSync(filepath){
    return crypto.createHash('md5')
	.update(
	    fs.readFileSync(filepath)
	)
	.digest('hex') ;
}

function md5file(filepath,cb){

    var s = fs.ReadStream(filepath);
    var shasum = crypto.createHash('md5')
    s.on('data', function(d) { shasum.update(d); })
    s.on('end', function() {
	cb && cb(null,shasum.digest('hex'))
    })
    s.on('error',function(err){
	cb && cb(err)
    })

}


