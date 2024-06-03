$user
if [ $# -ne 1 ] then
  echo "인수 개수가 1개가 아닙니다"
  exit 1
fi

logincheck() {
  while true; do
    if who | grep -q "^$user "; then
      echo "$user 로그인함!"
      break
    fi

    sleep 60
  done
}
  