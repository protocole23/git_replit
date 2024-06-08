#!/bin/bash

PHONEBOOK_FILE="phonebook.txt"

declare -A AREA_CODES=(
    ["02"]="서울"
    ["051"]="부산"
    ["053"]="대구"
    ["032"]="인천"
    ["062"]="광주"
)

get_region() {
    local phone_number="$1"
    for code in "${!AREA_CODES[@]}"; do
        if [[ "$phone_number" == $code* ]]; then
            echo "${AREA_CODES[$code]}"
            return
        fi
    done
    echo "기타"
}

validate_phone_number() {
    local phone_number="$1"
    if [[ "$phone_number" =~ ^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$ ]]; then
        return 0
    else
        return 1
    fi
}

if [ "$#" -ne 2 ]; then
    echo "사용법: $0 이름 전화번호"
    exit 1
fi

name="$1"
phone_number="$2"

if ! validate_phone_number "$phone_number"; then
    echo "잘못된 전화번호 형식입니다. 올바른 형식: 000-0000-0000"
    exit 1
fi

region=$(get_region "$phone_number")

updated=false
if [ -f "$PHONEBOOK_FILE" ]; then
    while read -r line; do
        IFS=' ' read -r existing_name existing_phone existing_region <<< "$line"
        if [ "$existing_name" == "$name" ]; then
            if [ "$existing_phone" == "$phone_number" ]; then
                echo "이미 존재하는 항목입니다: $name $phone_number $region"
                exit 0
            else
                echo "다른 전화번호로 업데이트합니다: $name $phone_number $region"
                updated=true
                echo "$name $phone_number $region"
            fi
        else
            echo "$line"
        fi
    done < "$PHONEBOOK_FILE" > temp.txt
else
    touch temp.txt
fi

if ! $updated; then
    echo "$name $phone_number $region" >> temp.txt
fi

mv temp.txt "$PHONEBOOK_FILE"
echo "추가/업데이트 완료: $name $phone_number $region"
