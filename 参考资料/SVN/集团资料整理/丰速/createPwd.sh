#!/usr/local/bin/expect -f

# Check
if { $argc<2 } {
        send_user "usage: $argv0  \n"
        exit
}

set user1 [lindex $argv 0]
set password1 [lindex $argv 1]

spawn echo $user1
spawn echo $password1

spawn /usr/local/apache/bin/htpasswd -m /app/SVN/auth/passwd $user1
set timeout 5

expect {
"New password*" { send "$password1\r"; exp_continue}
"Re-type new password*" { send "$password1\r" }
}

set timeout 5
expect "Adding*" 
send "\r"
send "exit\r"
