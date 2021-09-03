
echo "Download .DER file from burpuite first"

echo "Please Enter The Certificate Name: "
read file
openssl x509 -inform DER -in $file -out cacert.pem
echo "Hash is: "
HASH=`openssl x509 -inform PEM -subject_hash_old -in cacert.pem |head -1`
echo $HASH
mv cacert.pem $HASH.0

adb remount
adb push $HASH.0 /sdcard/
echo "mv /sdcard/$HASH.0 /system/etc/security/cacerts/" | adb shell
echo "chmod 644 /system/etc/security/cacerts/$HASH.0"| adb shell

echo "Its Almost Done!!!!"

adb reboot

echo "Thank You!!!!!,Rebooting Now..."