#! /usr/bin/env node

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
var targetdir
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

var indexjson = require("./index.json") 
var addonsJson = require("./addons-index.json")
addonsJson.addons = []
if(!addonsJson.ignore) addonsJson.ignore = {}

// 过滤并加载插件包
fs.readdirSync(srcdir)
.reduce(function(addons,filename){
	(!addonsJson.ignore[filename])
    	&& fs.statSync(srcdir+"/"+filename).isDirectory()
		&& fs.existsSync(srcdir+"/"+filename+"/"+filename+".toc")
		&& addons.push( parseToc(filename) )
    return addons
},addonsJson.addons)

Steps()

	// 确定输出目录
	.step(function(){
		var targetDirName = new Date().Format("yyyyMMdd")

		fs.readdir(packagesdir,this.holdButThrowError(function(err,names){

			var idx = "01"
			names.forEach(function(fname){
				if( fname.substr(0,targetDirName.length) == targetDirName ){
					idx = parseInt(fname.substr(targetDirName.length)) + 1
					return false
				}
			})

			idx = idx.toString()
			idx.length==1 && (idx="0"+idx)

			targetDirName+= idx
			targetdir = packagesdir + '/' + targetDirName
			addonsJson.lastVersion = targetDirName
			addonsJson.addonsDirUrl = addonsJson.packagesUrl + '/' + targetDirName

			fs.exists(targetdir,this.hold(function(exists){
				if(!exists){
				    fs.mkdir(targetdir,this.holdButThrowError())
				    console.log("create target dir",targetdir)
				}
			}))
		}))
	})
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
	// 打包扩展
	.step(function(){

		this.each(addonsJson.addons,function(i,addon){

    		var tarpath = targetdir+"/"+addon.name+".zip" ;

    		child_process.execFile(
    			"zip", [tarpath,"-r","."], {cwd: srcdir+"/"+addon.name}, this.hold()
    		)

    		this
	    		.step(function(err,stdout,stderr){
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
	    fs.writeFileSync(addonsIndexJson,JSON.stringify(addonsJson,null,2))
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

	// 处理 history.md/.html
	.step(function(){
		fs.readFile(__dirname+"/../history.md",this.holdButThrowError())
	})
	.step(function(err,buff){
		fs.writeFile(__dirname+"/workdir/history.md",buff,this.holdButThrowError())
	})
	.step(function(){
		child_process.exec(
			"md2html history.md > history.html",{cwd:__dirname+"/workdir"}, this.holdButThrowError()
		)
	})


	.catch(function(error){
	    console.error(error)
	    console.error(error.stack)
	})

	.done(function(){

		console.log("\n-----------")
		console.log("new packages folder is:",targetdir)
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
		if(res && res[1]){
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



// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}