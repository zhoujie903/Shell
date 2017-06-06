var fs = require('fs');

function createRandomPhones(min, max, count) {
    let phones = [];
    const d = max - min + 1;
    while (phones.length < count) {
        const randonNum = Math.floor(Math.random() * d + min);
        if (phones.includes(randonNum) === false) {
            phones.push(randonNum);
        }
    }
    return phones;   
}

//移动号码段
///////////////////////////////////////////////////
const r1340_1348 = {
    min:13400000000,
    max:13489999999,
    ratio:1
};

const r135_139 = {
    min:13500000000,
    max:13999999999,
    ratio:5
};

const r150_152 = {
    min:15000000000,
    max:15299999999,
    ratio:3
}; 

const r157_159 = {
    min:15700000000,
    max:15999999999,
    ratio:3
};

const r182_184 = {
    min:18200000000,
    max:18499999999,
    ratio:3
};

const r187_188 = {
    min:18700000000,
    max:18899999999,
    ratio:3
};
///////////////////////////////////////////////////


const totalCount = 3000;
const totalRatio = r1340_1348.ratio + r135_139.ratio + r150_152.ratio + r157_159.ratio + r182_184.ratio + r187_188.ratio;

//按各个手机号码段所占比例，生成总共totalCount个随机号码
let phones = [];
const mobileRanges = [r1340_1348, r135_139, r150_152, r157_159, r182_184, r187_188];
mobileRanges.forEach(function (item) {
    const min = item.min;
    const max = item.max;
    let count = Math.floor(item.ratio / totalRatio * totalCount); 
    let sorted = createRandomPhones(min, max, count);
    phones = phones.concat(sorted);
});

let file = 'sorted_rand.txt';

if( fs.existsSync(file) ) {
    fs.unlinkSync(file);
} 

//把随机号码排序并写入文件
let sorted = phones.sort(); 
sorted.forEach(function (item) {
    fs.appendFileSync(file, item + '|' + item + '\n');
});