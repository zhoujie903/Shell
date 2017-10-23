//过滤规则：前区中有4个连号时，丢弃
const filter_sequential4 = (item) => {
    //console.log("filter_sequential4");
    let a = item.firt;
    let seq4 = a[0] + 3 == a[3] || a[1] + 3 == a[4];
    let seq5 = a[0] + 4 == a[4]; 
    if (seq4 || seq5) {
        return null;
    }
    return item;
}

const filter_Empty = (item) => {
    console.log("filter_Empty");
    return item;
}

//过滤规则：前区中都小于10，丢弃
const filter_LessThan10 = (item) => {
    //console.log("filter_LessThan10");
    if(item.firt[4] <= 10) {
        return null;
    }
    return item;
}

//过滤规则：[10, 20)，丢弃
const filter_Between10And20 = (item) => {
    //console.log("filter_Between10And20");
    if(item.firt[0] >= 10 && item.firt[4] <= 19) {
        return null;
    }
    return item;
}

const rules = [
    filter_sequential4, 
    filter_LessThan10, 
    filter_Between10And20,];
const filter = (rules, item) => {

    for (var index = 0; index < rules.length; index++) {
        var element = rules[index];
        let r = element(item);
        if (r === null) {
            return null;
        }
    }
    return item;
}

//按数字大小排序
const sortByNumbers = (a, b) => {
    return a - b;
}

const createRandomNumbers = (min, max, count) => {
    let numbers = [];
    const d = max - min + 1;
    while (numbers.length < count) {
        const randonNum = Math.floor(Math.random() * d + min);
        if (numbers.includes(randonNum) === false) {
            numbers.push(randonNum);
        }
    }
    return numbers;    
} 

//创建一注彩票
function createItem() 
{
    let lottery_first = createRandomNumbers(1, 35, 5);
    lottery_first = lottery_first.sort(sortByNumbers);

    let lottery_last = createRandomNumbers(1,12, 2);
    lottery_last = lottery_last.sort(sortByNumbers);

    let item = {};
    item.firt = lottery_first;
    item.last = lottery_last; 
    return item;
};

//创建count彩票
const createLotto = (count) => {
    let numbers = [];
    let c = count;
    while (c > 0) {
        let item = createItem(); 
        item = filter(rules, item);
        if ( item !== null) {
            numbers.push(item);
            c = c - 1;
        }        
    }

    return numbers
}

function padNumber(value) {
    return  value < 10 ? "0" + value : value;
}

//生成彩票，并格式化输出
//////////////////////////////////////////////////////////////////
console.time("用时:")
let a = createLotto(3);
a.forEach(function (item) {
    let n1 = padNumber(item.firt[0]);
    let n2 = padNumber(item.firt[1]); 
    let n3 = padNumber(item.firt[2]);
    let n4 = padNumber(item.firt[3]);
    let n5 = padNumber(item.firt[4]); 
    let n6 = padNumber(item.last[0]);
    let n7 = padNumber(item.last[1]); 
    console.log("%s %s %s %s %s + %s %s", n1, n2, n3, n4, n5, n6, n7);
});
console.timeEnd("用时:")
//////////////////////////////////////////////////////////////////
