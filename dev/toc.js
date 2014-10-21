exports.parseTocFile = function(content,outputTocOptions){

    var metainfo = {} ;
    var lines = content.toString().split("\n");

    for(var i=0;i<lines.length;i++){
		var line = lines[i].trim() ;

		if(!line){
		    continue ;
		}

		// config option
		var res = /##\s*([^:]+):\s*(.+)$/.exec(line) ;
		if(res && res[1] ){
			if( !outputTocOptions || outputTocOptions[res[1]] ){
				metainfo[ res[1] ] = res[2] ;
			}
		}
    }

    return metainfo
}