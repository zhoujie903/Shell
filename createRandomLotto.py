# 如果你需要不替换地（即不重复地）随机选择一个元素的样本，可以使用random.sample:

import random


class Lotto(object):
    def __init__(self, first, last):
        self.first = first
        self.last = last
        self.item = {}
        self.createItem()

    def __str__(self):
        string = ""
        for n in self.item["first"]:
            string += "%02d " % (n)
        string += "- "
        for n in self.item["last"]:
            string += "%02d " % (n)
        return string

    def createItem(self):
        """创建一注彩票"""
        r = range(1, self.first[0])
        lottery_first = random.sample(r, self.first[1])
        lottery_first.sort()

        r = range(1, self.last[0])
        lottery_last = random.sample(r, self.last[1])
        lottery_last.sort()

        self.item["first"] = lottery_first
        self.item["last"] = lottery_last


# 双色球
class ShuangSeQiu(Lotto):
    def __init__(self):
        self.first = (34, 6)
        self.last = (17, 1)
        super().__init__(self.first, self.last)    

# 大乐透
class DaLeTou(Lotto):
    def __init__(self):
        self.first = (36, 5)
        self.last = (13, 2)
        super().__init__(self.first, self.last)


def createLotto(count=5):
    """创建count注彩票"""
    for i in range(count):
        item = ShuangSeQiu()
        print(item)


def main():
    createLotto(5)


if __name__ == "__main__":
    main()
