# 如果你需要不替换地（即不重复地）随机选择一个元素的样本，可以使用random.sample:

import random


def createItem():
    """创建一注彩票"""
    lottery_36 = range(1, 36)
    front_5 = random.sample(lottery_36, 5)
    front_5 = sorted(front_5)

    lottery_12 = range(1, 13)
    end_2 = random.sample(lottery_12, 2)
    end_2 = sorted(end_2)
    print("%02d %02d %02d %02d %02d - %02d %02d" %
          (front_5[0], front_5[1], front_5[2], front_5[3], front_5[4], end_2[0], end_2[1]))



def createLotto(count=5):
    """创建count注彩票"""
    for i in range(count):
        createItem()


createLotto()
