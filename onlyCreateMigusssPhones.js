#!/usr/bin/env node
//需要安装node_xj:  npm install xls-to-json

node_xj = require("xls-to-json");

var fs = require('fs');
var path = require('path');

var walk = function (dir, done) {
    var results = [];
    fs.readdir(dir, function (err, list) {
        if (err) return done(err);
        var i = 0;
        (function next() {
            var file = list[i++];
            if (!file) return done(null, results);
            file = dir + '/' + file;
            fs.stat(file, function (err, stat) {
                if (stat && stat.isDirectory()) {
                    walk(file, function (err, res) {
                        results = results.concat(res);
                        next();
                    });
                } else {
                    results.push(file);
                    next();
                }
            });
        })();
    });
};

walk(process.cwd(), function (err, files) {

    var allPhones = [];
    files.forEach(function (file) {
        var ext = path.extname(file);
        if (ext === '.xls') {

            node_xj({
                input: file,  // input xls 
                output: null, // output json 
                sheet: "数据"  // specific sheetname 
            }, function (err, result) {
                if (err) {
                    console.error(err);
                } else {
                    result.forEach(function (person) {
                        allPhones.push(person["手机"]);
                    });
                }
            });
        }
    });

    var sorted_all_file = 'sorted_all.txt';
    if (fs.existsSync(sorted_all_file)) {
        fs.unlinkSync(sorted_all_file);
    }

    setTimeout(function () {
        function onlyUnique(value, index, self) {
            return self.indexOf(value) === index;
        }
        var sorted = allPhones.sort();
        var unique = sorted.filter(onlyUnique);
        unique.forEach(function (item) {
            fs.appendFileSync(sorted_all_file, item + '|' + item + '\n');
        });

    }, 5 * 1000);
});
