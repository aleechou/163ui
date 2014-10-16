#! /usr/bin/env node

var q = require("q")
var fs = require("fs")
var crypto = require('crypto')
var zipdir = require("zip-dir")
var EasyZip = require('easy-zip').EasyZip
var child_process = require("child_process")
var Steps = require("ocsteps")
var _path = require("path")
var ArgumentParser = require("argparse").ArgumentParser

var parser = new ArgumentParser()
parser.addArgument(['-p','--offline-package'],{nargs:0,help:"pack offline pakcage"})
var args = parser.parseArgs()


var srcdir = __dirname+"/../Interface/AddOns"
var workdir = __dirname+"/workdir"
var packagesdir = workdir + "/packages"
var offlinedir = workdir + "/offline"
var targetDirName = process.argv[2] 
var datenum
var targetdir = packagesdir
var addonsIndexJson = workdir + "/addons-index.json"
var addonsIndexTar = workdir + "/addons-index.zip"
var outputTocOptions = {
	'Version': 1
	, 'X-163UI-Version': 1
	, 'Title': 1
	, 'Title-zhCN': 1
	, 'Note': 1
	, 'Note-zhCN': 1
}

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

// 读取 config.json
try{
	var config = require("./config.json")
	if(config["addons-index"]){
		for(var key in config["addons-index"])
			addonsJson[key] = config["addons-index"][key]
	}
}catch(e) {
	config = {}
}

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
/*
	// 确定输出目录
	.step(function(){
		if(!targetDirName){
			targetDirName = new Date().Format("yyyyMMdd")
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
			}))
		}
	})
	.step(function(){
		targetdir = packagesdir + '/' + targetDirName
		addonsJson.lastVersion = targetDirName
		addonsJson.addonsDirUrl = addonsJson.packagesUrl + '/' + targetDirName

		fs.exists(targetdir,this.hold(function(exists){
			if(!exists){
			    fs.mkdir(targetdir,this.holdButThrowError())
			    console.log("create target dir",targetdir)
			}
		}))
	})
*/

	.step(function(){
		mkU1PackageMeta(addonsJson.client.Windows,this.hold())
	})
	.step(function(){
		mkU1PackageMeta(addonsJson.client.OSX,this.hold())
	})

	// 清除 packages
	.step(function(){
    	child_process.execFile("rm", ["-r",packagesdir], {}, this.hold(console.error))
	})
	.step(function(err){
		fs.mkdir(packagesdir,this.hold(console.error))
	})

	// 打包插件
	.step(function(){

		this.each(addonsJson.addons,function(i,addon){

    		var tarpath = targetdir+"/"+addon.name+".zip" ;
    		console.log(tarpath)

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

	// 打包离线包
	.step(function(){
		datenum = new Date().Format("yyyy.MM.dd")
		fs.readdir(offlinedir,this.holdButThrowError(function(err,names){
			var idx = "01"
			names.forEach(function(fname){
				var res = /^163ui\-offline\-([^\-]+)\-(\d+)\.rar$/.exec(fname)
				if(res && datenum==res[1]){
					idx = parseInt(res[2])+1
				}
			})

			idx = idx.toString()
			idx.length<=1 && (idx="0"+idx)

			datenum+= "-"+idx
		}))
	})
	.step(function(){
		var ignoreAddOns = ""
		for(var addonName in addonsJson.ignore){
			ignoreAddOns+= " -x"+addonName //.replace(/\!/g,"\\!")
		}
		var release = this.hold()
		var proc = child_process.spawn("sh", [
			__dirname+"/mk-offline-pkg"
			, datenum
			, "workdir/"+addonsJson.client.Windows.portableFile
			, ignoreAddOns
		])
		proc.stdout.on('data',function(data){process.stdout.write(data.toString())})
		proc.stderr.on('data',function(data){process.stdout.write(data.toString())})
		proc.on('close',function(){release()});
	})
	.step(function(){
		addonsJson.offlinePackageUrl = addonsJson.downloadUrlPrefix + "/offline/163ui-offline-"+datenum+".rar"
		addonsJson.fullOfflinePackageUrl = addonsJson.downloadUrlPrefix + "/offline/163ui-full-offline-"+datenum+".rar"
		addonsJson.lastReleaseDate = new Date().Format("yyyy/MM/dd")
	})


	.step(function(){

		addonsJson.addonsDirUrl = addonsJson.packagesUrl

		// 清理一些不需要发布的信息
		delete addonsJson.client.Windows["upgraderFile"]
		delete addonsJson.client.Windows["portableFile"]
		delete addonsJson.client.OSX["upgraderFile"]
		delete addonsJson.client.OSX["portableFile"]
		delete addonsJson.downloadUrlPrefix
		delete addonsJson.packagesUrl
		delete addonsJson.ignore

	    console.log("make addons-index.json file ...",addonsIndexJson)
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
			"md2html -f history.md > history.html",{cwd:__dirname+"/workdir"}, this.holdButThrowError()
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


function mkU1PackageMeta(meta,cb){

	meta.upgraderFilename = _path.basename(meta["upgraderFile"])

	Steps(
		function(){
			md5file("workdir/"+meta["upgraderFile"],this.holdButThrowError(function(err,md5){
				meta["upgraderMD5"] = md5
			}))
		}
		, function(){
			md5file("workdir/"+meta["portableFile"],this.holdButThrowError(function(err,md5){
				meta["portableMD5"] = md5
			}))

		}
		, function(){
			fs.stat("workdir/"+meta["portableFile"],this.hold(function(err,stats){
				meta["size"] = Math.floor(stats.size / 1024 / 1024)+"M"
			}))
		}
		, function(){
			meta["upgraderUrl"] = addonsJson.downloadUrlPrefix + "/" + meta["upgraderFile"]
			meta["portableUrl"] = addonsJson.downloadUrlPrefix + "/" + meta["portableFile"]
		}
	)
	.done(cb) ()
}


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
		if(res && res[1] && outputTocOptions[res[1]] ){
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

    //findfiles("") ;
    
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