#! /usr/bin/env node

var q = require("q")
var fs = require("fs")
var crypto = require('crypto')
var zipdir = require("zip-dir")
var EasyZip = require('easy-zip').EasyZip





var srcdir = __dirname+"/../Interface/AddOns"
var workdir = __dirname+"/workdir"
var packagesdir = workdir + "/packages"
var addonsIndexJson = workdir + "/addons-index.json"
var addonsIndexTar = workdir + "/addons-index.zip"


// 检查 workdir 是否存在
if( !fs.existsSync(workdir) || !fs.statSync(workdir).isDirectory() ){
    console.error("can not found workdir, please link to.")
    console.log("nothing to do.")
    process.exit()
}
// 创建 packages 目录
if( !fs.existsSync(packagesdir) ){
    fs.mkdir(packagesdir)
    console.log("create packages dir",packagesdir)
}

var indexjson = {}
var addonsJson = {
    addons: []
}

fs.readdirSync(srcdir)
.reduce(function(addons,filename){
    fs.statSync(srcdir+"/"+filename).isDirectory()
	&& fs.existsSync(srcdir+"/"+filename+"/"+filename+".toc")
	&& addons.push( parseToc(filename) )
    return addons
},addonsJson.addons)


.reduce(function(seq,addon){

    var tarpath = packagesdir+"/"+addon.name+".zip" ;

    return seq
	.then(function(){
	    return q.nbind(fs.exists) (tarpath)
	})
	.then(null,function(){
	    console.log("deleting old addon package",addon.name,"...")
	    return q.nbind(fs.unlink) (tarpath)
	})
	.then(function(){
	    return q.nbind(zipdir) (srcdir+"/"+addon.name,tarpath)
	})
	.then(function(){
	    console.log("packed addon",addon.name) ;
	})
},q())

.then(function(){
    console.log("make addons-index.json file ...",addonsIndexJson)
    fs.writeFileSync(addonsIndexJson,JSON.stringify(addonsJson))

    return q.nbind(fs.exists) (addonsIndexTar)
})
.then(null,function(e){

    if(e!=true)
	throw e

    console.log("delete addons-index.tar.gz")
    return q.nbind(fs.unlink) (addonsIndexTar)
})
.then(function(){
    console.log("compress addons-index.json file to addons-index.zip ...")

    var deferred = q.defer()

    var zip = new EasyZip()
    zip.addFile("addons-index.json",addonsIndexJson,function(){
	zip.writeToFile(addonsIndexTar,function(){
	    deferred.resolve()
	})
    })
   
    return deferred.promise
})
.then(function(){
    // md5 tar.gz file
    return q.nbind(md5file) (addonsIndexTar)
})
.then(function(md5v){
    indexjson.addonsIndex = "addons-index.zip"
    indexjson.addonsIndexMD5 = md5v
})
.then(function(){
    return q.nbind(fs.writeFile) (workdir+"/index.json", JSON.stringify(indexjson,null,4))
})
.then(function(){
    console.log("created index.json file.")
})
.then(null,function(error){
    console.error(error) ;
    console.error(error.stack) ;
})



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
	if(res){
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
	    fs.readFileSync(filepath).toString()
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

