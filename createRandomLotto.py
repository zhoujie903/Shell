# 如果你需要不替换地（即不重复地）随机选择一个元素的样本，可以使用random.sample:

import random


def output(item):
    for n in item["firt"]:
        print("%02d " % (n), end="")
    print(" - ", end="")
    for n in item["last"]:
        print("%02d " % (n), end="")
    print("\n")


def createItem():
    """创建一注彩票"""
    lottery_36 = range(1, 36)
    lottery_first = random.sample(lottery_36, 5)
    lottery_first.sort()

    lottery_12 = range(1, 13)
    lottery_last = random.sample(lottery_12, 2)
    lottery_last.sort()

    return {"firt": lottery_first, "last": lottery_last}


def createLotto(count=5):
    """创建count注彩票"""
    for i in range(count):
        item = createItem()
        output(item)


createLotto()
