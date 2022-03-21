#!/bin/bash

##
# BASH menu script for displaying system information:
#   - Current Memory usage
#   - Current CPU load
#   - Total Number of TCP connections 
#   - Current Kernel version
##

# This variable will set the server_name with the hostname of the local machine
server_name=$(hostname)

# This function is building a memory check
function memory_info() {   # <--- new function call, function name, starts function with {
  # prints a blank line
  echo ""
  # prints the following statement with the server_name variable of the local machines host name
	echo "Memory usage on ${server_name} is: "
  # uses the linux command for displaying the RAM utilization
	free -h
  # prints a blank line
	echo ""
#ends the function instructions with }
}

# This function is building a CPU check
function cpu_info() { # <--- new function call, function name, starts function with {
  # prints a blank line
  echo ""
  # prints the following statement with the server_name variable of the local machines host name
	echo "CPU load on ${server_name} is: "
  # prints a blank line
  echo ""
  # uses the linux command for displaying the CPU information
	uptime
  # prints a blank line
  echo ""
#ends the function instructions with }
}

# This function is building the display print out of the total amoutn of TCP connections
function tcp_info() { # <--- new function call, function name, starts function with {
  # prints a blank line
  echo ""
  # prints the following statement with the server_name variable of the local machines host name 
	echo "TCP connections on ${server_name}: "
  # prints a blank line
  echo ""
  # uses the linux cat command against the listening TCP sockets and uses the linx wc (word count) and adds up the value of total connections 
	cat  /proc/net/tcp | wc -l
  # prints a blank line
  echo ""
#ends the function instructions with }
}

# This function is building the display print out of the kernel version of the local machine
function kernel_info() { # <--- new function call, function name, starts function with {
  # prints a blank line
  echo ""
  # prints the following statement with the server_name variable of the local machines host name 
	echo "Kernel version on ${server_name} is: "
	# prints a blank line
  echo ""
	# uses the linux uname command with the option of -r to display kernel version of the linux machine 
  uname -r
  # prints a blank line
  echo ""
#ends the function instructions with }
}

# This function calls all the other functions built above into one easy display print out.
function all_info() { # <--- new function call, function name, starts function with {
  # calls the memory_info function
	memory_info
  # calls the cpu_info function
	cpu_info
  # call the tcp_info function
	tcp_info
  # calls the kernel_info function
	kernel_info
#ends the function instructions with }
}

##
# Color Variables assigned to easy to read words
# Color	Codes
# Black	 30
# Red    31
# Green  32
# Brown  33
# Blue	 34
# Purple 35
# Cyan	 36
# clear  0    <--- Resets colors back to default, normally white
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions for clean and less code
##

# Builds ColorGreen function and makes text green and then resets to default after print out
ColorGreen(){ # <--- new function call, function name, starts function with {
  # colors the selected text green and then resets.  -n means new line will happen and -e means text break will happen
	echo -ne $green$1$clear
#ends the function instructions with }
}
# Builds ColorBlue function and makes text green and then resets to default after print out
ColorBlue(){ # <--- new function call, function name, starts function with {
  # colors the selected text blue and then resets.  -n means new line will happen and -e means text break will happen
	echo -ne $blue$1$clear
#ends the function instructions with }
}

# Builds Menu function for displaying options as numbers for selection. Based on selection, results will feed back in a interactive matter
menu(){ # <--- new function call, function name, starts function with {
# prints out the menu 
echo -ne "
Basic Menu Setup 
$(ColorGreen '1)') Total Memory usage
$(ColorGreen '2)') Total CPU load
$(ColorGreen '3)') Total Number of TCP connections 
$(ColorGreen '4)') Current Kernel version
$(ColorGreen '5)') Check All Options
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        # takes input from the user and executes the desired option and assigns it to the variable input of "a"
        read a
        # case statement for if variable "a" is 1, 2, 3, 4 or 5 execute assigned function 
        case $a in
          # calls memory_info function and after execution, calls menu system function again
	        1) memory_info ; menu ;;
          # calls cpu_info function and after execution, calls menu system function again 
	        2) cpu_info ; menu ;;
          # calls tcp_info function and after execution, calls menu system function again
	        3) tcp_info ; menu ;;
          # calls kernel_info function and after execution, calls menu system function again
	        4) kernel_info ; menu ;;
          # calls all_info function and after execution, calls menu system function again
	        5) all_info ; menu ;;
    # if the input is 0, then the menu script will close out
		0) exit 0 ;;
    # if any input is not 1, 2, 3, 4, 5 or 0, then print statement below and executes esac command below
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        #  esac will continue waiting input and execute the desired request.
        esac  # esac is case spelled backwards easter egg I suppose. This ends selectable options for items found within the case statement
#ends the function instructions with }
}

# Calls the menu function for execution
menu
