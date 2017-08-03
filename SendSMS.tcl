#!/bin/sh
# \
exec tclsh "$0" ${1+"$@"}
package require Expect

set timeout 5

#1 Read Configuration file configure.txt

set fp [open "configure.txt" r]
set lines [split [read $fp] "\n"]

# 1.1 IP
set line [lindex $lines 0]
set param_value [split $line "="]
set ip [lindex $param_value 1]
puts $ip

# 1.2 Port
set line [lindex $lines 1]
set param_value [split $line "="]
set port [lindex $param_value 1]
puts $port

# 1.3 Prefix
set line [lindex $lines 2]
set param_value [split $line "="]
set prefix [lindex $param_value 1]
puts $prefix

# 1.4 Counter File Name
set line [lindex $lines 3]
set param_value [split $line "="]
set counter_file [lindex $param_value 1]
puts $counter_file

# 1.5 Address Book File Name
set line [lindex $lines 4]
set param_value [split $line "="]
set ad_file [lindex $param_value 1]
puts $ad_file

# 1.6 Message file name
set line [lindex $lines 5]
set param_value [split $line "="]
set msg [lindex $param_value 1]
puts $msg
close $fp

#2 Test the connection

spawn nc -s $ip $ip $port
expect "Welcome to SMSDroid. Please enter your password:*"
expect "*"


sleep 1

set password "message"
exp_send "$password\r\n"
expect "Thank you! Enter help for help!*"
puts "got it before *"
expect "*"
puts "got it after *"
sleep 1
puts "got it"
#3 Read the last count file count.txt

set fp [open $counter_file r]
set counter [read $fp]
close $fp
puts $counter

#4 Main Loop. Next release : from count - 1 to count + 31. Store time stamp

#4.1 Read address book
set fp [open $ad_file r]
set lines [split [read $fp] "\n"]
close $fp

#4.2 Read message. and send it. Max 97 messages. at a time. One can change the max number in below line. 


for {set i 1} {$i <= 97} {incr i 1} {
	set line [lindex $lines $counter]
	set entry [split $line ","]
	set name [lindex $entry 1]
	set number [lindex $entry 0]
	if {$number eq ""} {
		break
	}
	incr counter
	set cmd [concat "sendsms " $number $prefix $name $msg]
	exp_send "$cmd\r\n"
	expect "OK!*"
	puts "$i"
	sleep 7
}

set fp [open $counter_file w]
puts $fp [expr $counter]
close $fp


#5 Wait for 1 hour. Next release

#6 Go to 4. Next release

#8 Close the PID. 
puts $spawn_id
close $spawn_id
