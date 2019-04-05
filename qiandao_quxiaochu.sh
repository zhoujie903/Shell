#!/bin/sh

# 趣消除App的签到和大装盘地自动化
# 测试时间：2019-04-05
# App版本：1.1.2
# App地址：https://itunes.apple.com/cn/app/id1449545954

HOST='Host: king.hddgood.com'
ACCEPT='Accept: application/json, text/plain, */*'
Accept_Language='Accept-Language: zh-cn'
Origin='Origin: https://king.hddgood.com'
User_Agent='User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 12_1_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/16D57/; quxiaochu/ios v1.1.2'
Referer='Referer: https://king.hddgood.com/'

# 这些变量的值可以通过像Charles抓包软件获得
# 账号变量
# ------------------------------------------------
# 每个账号不同；同一个账号每次是不是一样呢？
A_Token_Header_13456774460='A-Token-Header: PjFMVVRRV0ZCH0JWDlJXIhpWB1c='
A_Token_Header_19965412404='A-Token-Header: OzdCV1BQV0RLH0JWDlIMc0pTWlQ='

# 这里的Cookie好像很奇怪：没区分账户
Cookie_13456774460='Cookie: UM_distinctid=16947f46ccd79-0e531e04caae4e8-73275048-4a640-16947f46cce2e2; cn_1276022107_dplus=%7B%22distinct_id%22%3A%20%2216947f46ccd79-0e531e04caae4e8-73275048-4a640-16947f46cce2e2%22%2C%22sp%22%3A%20%7B%22%24recent_outside_referrer%22%3A%20%22%24direct%22%7D%2C%22initial_view_time%22%3A%20%221551686237%22%2C%22initial_referrer%22%3A%20%22%24direct%22%2C%22initial_referrer_domain%22%3A%20%22%24direct%22%2C%22%24_sessionid%22%3A%20402%2C%22%24_sessionTime%22%3A%201554368804%2C%22%24dp%22%3A%200%2C%22%24_sessionPVTime%22%3A%201554368804%2C%22%24recent_outside_referrer%22%3A%20%22%24direct%22%7D; CNZZDATA1276022107=1035459509-1551686237-%7C1554367164; _ga=GA1.2.1747575593.1553400628'
Cookie_19965412404='Cookie: UM_distinctid=16947f46ccd79-0e531e04caae4e8-73275048-4a640-16947f46cce2e2; cn_1276022107_dplus=%7B%22distinct_id%22%3A%20%2216947f46ccd79-0e531e04caae4e8-73275048-4a640-16947f46cce2e2%22%2C%22sp%22%3A%20%7B%22%24recent_outside_referrer%22%3A%20%22%24direct%22%7D%2C%22initial_view_time%22%3A%20%221551686237%22%2C%22initial_referrer%22%3A%20%22%24direct%22%2C%22initial_referrer_domain%22%3A%20%22%24direct%22%2C%22%24_sessionid%22%3A%20402%2C%22%24_sessionTime%22%3A%201554368804%2C%22%24dp%22%3A%200%2C%22%24_sessionPVTime%22%3A%201554368804%2C%22%24recent_outside_referrer%22%3A%20%22%24direct%22%7D; CNZZDATA1276022107=1035459509-1551686237-%7C1554367164; _ga=GA1.2.1747575593.1553400628'

UUID_13456774460='472251'
UUID_19965412404='633278'
# ------------------------------------------------


# 接口
# ------------------------------------------------
# 接口king/daily_sign
king_daily_sign='https://king.hddgood.com/king_api/v1/king/daily_sign'

# 接口king/daily_luckydraw
king_daily_luckydraw='https://king.hddgood.com/king_api/v1/king/daily_luckydraw'

# 接口coin/lucky_draw   大转盘Go并收集金币   
coin_lucky_draw='https://king.hddgood.com/king_api/v1/coin/lucky_draw'
# ------------------------------------------------



sign() {
    # 每小时签到并收集金币
    # sign(1:uid, 2:A_Token_Header, 3:Cookie)

    echo "sign ${1}" 

    # 签到
    curl -H "${HOST}" -H "${ACCEPT}" -H "${Accept_Language}" -H "${Origin}" -H "${User_Agent}" -H "${Referer}" \
    -H "${2}" \
    -H "${3}" \
    --data "uid=${1}&channel=&version=1.1.2&os=ios&web_ver=20190261" --compressed "${king_daily_sign}"
    echo ''

    # 收集金币
    curl -H "${HOST}" -H "${ACCEPT}" -H "${Accept_Language}" -H "${Origin}" -H "${User_Agent}" -H "${Referer}" \
    -H "${2}" \
    -H "${3}" \
    --data "uid=${1}&channel=&version=1.1.2&os=ios&web_ver=20190261" --compressed "${king_daily_luckydraw}"
    echo ''
}

coin_lucky() {
    # 大转盘Go并收集金币
    # coin_lucky(1:uid, 2:A_Token_Header, 3:Cookie) 

    echo "大转盘Go ${1}"

    curl -H "${HOST}" -H "${ACCEPT}" -H "${Accept_Language}" -H "${Origin}" -H "${User_Agent}" -H "${Referer}" \
    -H "${2}" \
    -H "${3}" \
    --data "uid=${1}" --compressed "${coin_lucky_draw}"
    echo ''   
}

helper_Sign_and_Coin_lucky() {
    # 辅助方法
    # (1:uid, 2:A_Token_Header, 3:Cookie) 

    sign "${1}" "${2}" "${3}"
    coin_lucky "${1}" "${2}" "${3}"    
}


helper_Sign_and_Coin_lucky "${UUID_13456774460}" "${A_Token_Header_13456774460}" "${Cookie_13456774460}"

helper_Sign_and_Coin_lucky "${UUID_19965412404}" "${A_Token_Header_19965412404}" "${Cookie_19965412404}"
