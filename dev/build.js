#! /usr/bin/env node

var q = require("q") ;
var fs = require("fs") ;

var srcdir = __dirname+"/../Interface/AddOns" ;

q.denodeify(fs.readdir)(srcdir)
.then(function(){
    console.log(arguments) ;
})



.then(null,console.error) ;


