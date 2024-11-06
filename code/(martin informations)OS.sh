#) 
 echo -e "La version de cette OS est : $(cat /etc/os-release | grep -v "NAME" | grep -v "PRETTY_NAME" | grep -v "ID" | grep -v "ID_LIKE" | grep -v "HOME_URL" | grep -v "SUPPORT_URL" | grep -v "BUG_REPORT_URL" | grep -v "PRIVACY_POLICY_URL" | grep -v "UBUNTU_CODENAME")" >> ~/Documents/"info_$target_$FORMATTED_DATE.txt"
