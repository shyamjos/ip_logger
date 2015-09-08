 #!/bin/bash
check_internet() {

#fetch public ip using ipecho.net

pub_ip=$(wget -qO- http://ipecho.net/plain)

if [[ "$pub_ip" == "" ]]; then

#this script will exit if this condition fails

        echo "i killed myself , unable to access ipecho.net "

        exit 1
else
        echo "Fetching public ip.."

fi

}

check_internet

#fetch public ip using ipecho.net

get_ip(){
	
wget -qO- http://ipecho.net/plain ; echo
}

#set fetched ip as current ip 

cur_ip=$(get_ip)

log_ip(){

#loads last ip from ip_file.txt file

   ip_file=`cat ip_file.txt`

#check if ip is changed

if [ "$cur_ip" == "$ip_file" ]
	
then
	
echo "IP not changed since last update";

else 
# add ip to the db if it is changed
echo "IP changed to : $cur_ip"
echo "$cur_ip" > "ip_file.txt"
#insert into DB
mysql  --user=root --password=root ip_logger << EOF
insert into log_ip (ip) values('$cur_ip');
EOF
echo "New IP : $cur_ip added to DB"	
fi
}
#main function
log_ip