myfile="kill.file"
while [ ! -e $myfile ]; do 

temper=$((RANDOM % 20))
echo "Sending $temper request with 1 second intervals "
for server in [0..temper];
do
./sendMyRequestQueue.sh >/dev/null 2>&1 &
#sleep  $((RANDOM % 1))

done
sleep  $((RANDOM % 5))
done
