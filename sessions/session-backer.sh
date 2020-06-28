#
# Move <session-file>.vim to some dir and run this script
# backup will take a password for each file and encrypt it
# along with assigning a random alphanumeric name.
#
# call #restore() and enter password to decrypt files and
# restore the original filename.
#

backup(){
  sessions=$(ls *.vim)
  for session in $sessions;
  do
    # save the filename by appending it to the file.
    echo $session >> $session;
    # generate a new random alhpanumeric filename.
    filename=$(cat /dev/urandom | LC_ALL=C tr -dc a-zA-Z0-9 | fold -w 12 | head -n 1);
    # encrypt our file and assign it our random filename.
    echo "password: "
    openssl enc -aes-256-cbc -pass stdin -in $session -out $filename.enc;
    # remove the saved filename
    sed -i '' -e '$d ' $session;
    # if args remove the unencryted files
    #[ -z !"$1" ] && rm $session
    rm $session
  done
}

restore(){
  files=$(ls *.enc)
  for session in $files;
  do
    # strip the file extension
    tempfile=${session%.*}.txt;
    echo "password: "
    openssl enc -d -aes-256-cbc -pass stdin -in $session -out $tempfile
    # recover the original filename
    filename=$(tail -n 1 $tempfile)
    sed -i '' -e '$ d' $tempfile
    mv "$tempfile" "$filename"
    rm $session
  done

}

"$@"
