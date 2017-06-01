var fs = require('fs');

function createRandomPhones(min, max, count) {
    var phones = [];
    var d = max - min + 1;
    while (phones.length < count) {
        var randonNum = Math.floor(Math.random() * d + min);
        if (phones.indexOf(randonNum) < 0) {
            phones.push(randonNum);
        }
    }
    return phones;   
}

//移动号码段
///////////////////////////////////////////////////
var r1340_1348 = {
    min:13400000000,
    max:13489999999,
    ratio:1
};

var r135_139 = {
    min:13500000000,
    max:13999999999,
    ratio:5
};

var r150_152 = {
    min:15000000000,
    max:15299999999,
    ratio:3
}; 

var r157_159 = {
    min:15700000000,
    max:15999999999,
    ratio:3
};

var r182_184 = {
    min:18200000000,
    max:18499999999,
    ratio:3
};

var r187_188 = {
    min:18700000000,
    max:18899999999,
    ratio:3
};
///////////////////////////////////////////////////


var totalCount = 3000;
var totalRatio = r1340_1348.ratio + r135_139.ratio + r150_152.ratio + r157_159.ratio + r182_184.ratio + r187_188.ratio;

//按各个手机号码段所占比例，生成总共totalCount个随机号码
var phones = [];
var mobileRanges = [r1340_1348, r135_139, r150_152, r157_159, r182_184, r187_188];
mobileRanges.forEach(function (item) {
    var min = item.min;
    var max = item.max;
    var count = Math.floor(item.ratio / totalRatio * totalCount); 
    var sorted = createRandomPhones(min, max, count);
    phones = phones.concat(sorted);
});

var file = 'sorted_rand.txt';

if( fs.existsSync(file) ) {
    fs.unlinkSync(file);
} 

//把随机号码排序并写入文件
var sorted = phones.sort(); 
sorted.forEach(function (item) {
    fs.appendFileSync(file, item + '|' + item + '\n');
});