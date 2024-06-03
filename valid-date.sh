#!/bin/bash

convert_month() {
    local month_input=$1
    case "${month_input,,}" in
        jan|january|1) echo "Jan" ;;
        feb|february|2) echo "Feb" ;;
        mar|march|3) echo "Mar" ;;
        apr|april|4) echo "Apr" ;;
        may|5) echo "May" ;;
        jun|june|6) echo "Jun" ;;
        jul|july|7) echo "Jul" ;;
        aug|august|8) echo "Aug" ;;
        sep|september|9) echo "Sep" ;;
        oct|october|10) echo "Oct" ;;
        nov|november|11) echo "Nov" ;;
        dec|december|12) echo "Dec" ;;
        *) echo "Invalid month" ;;
    esac
}

is_leap_year() {
    local year=$1
    if (( year % 4 != 0 )); then
        echo "false"
    elif (( year % 400 == 0 )); then
        echo "true"
    elif (( year % 100 == 0 )); then
        echo "false"
    else
        echo "true"
    fi
}

days_in_month() {
    local month=$1
    local year=$2
    case $month in
        Jan) echo 31 ;;
        Feb) 
            if [ "$(is_leap_year $year)" == "true" ]; then
                echo 29
            else
                echo 28
            fi
            ;;
        Mar) echo 31 ;;
        Apr) echo 30 ;;
        May) echo 31 ;;
        Jun) echo 30 ;;
        Jul) echo 31 ;;
        Aug) echo 31 ;;
        Sep) echo 30 ;;
        Oct) echo 31 ;;
        Nov) echo 30 ;;
        Dec) echo 31 ;;
        *) echo "0" ;;
    esac
}

if [ "$#" -ne 3 ]; then
    echo "입력값 오류"
    exit 1
fi

month=$(convert_month $1)
day=$2
year=$3

if [ "$month" == "Invalid month" ]; then
    echo "$1은 유효하지 않은 월입니다."
    exit 1
fi

valid_days=$(days_in_month $month $year)

if ! [[ "$day" =~ ^[0-9]+$ ]]; then
    echo "날짜는 숫자여야 합니다: $1 $day $year"
    exit 1
elif (( day < 1 || day > valid_days )); then
    echo "$1 $day $year는 유효하지 않습니다."
    exit 1
fi

echo "$month $day $year" 