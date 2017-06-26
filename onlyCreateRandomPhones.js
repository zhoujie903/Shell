var fs = require('fs');

const createRandomPhones = (min, max, count) => {
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
class RangePhone {
    constructor(min, max, ratio) {
        // this.min = min;
        // this.max = max;
        // this.ratio = ratio;
        Object.assign(this, {min, max, ratio});
    }
} 

const r1340_1348 = new RangePhone(13400000000, 13489999999, 1);

const r135_139 = new RangePhone(13500000000, 13999999999, 5);

const r150_152 = new RangePhone(15000000000, 15299999999, 3);

const r157_159 = new RangePhone(15700000000, 15999999999, 3);

const r182_184 = new RangePhone(18200000000, 18499999999, 3);

const r187_188 = new RangePhone(18700000000, 18899999999, 2);

///////////////////////////////////////////////////

const mobileRanges = [r1340_1348, r135_139, r150_152, r157_159, r182_184, r187_188];

const totalCount = 3000;
const totalRatio = mobileRanges.reduce( (accumulator, currentValue) => {return accumulator + currentValue.ratio },0);

//按各个手机号码段所占比例，生成总共totalCount个随机号码
let phones = [];

mobileRanges.forEach( (item) => {
    const {min, max} = item;//对象的解构赋值
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
    fs.appendFileSync(file, `${item}|${item}\n`);//``//模板字符串 
});