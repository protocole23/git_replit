$user=$1
if [ $# -ne 1 ] then
  echo "인수 개수가 1개가 아닙니다"
  exit 1
fi



until  who | grep -w "$user"; do
    sleep 60
done

echo "$user 로그인함!"

  