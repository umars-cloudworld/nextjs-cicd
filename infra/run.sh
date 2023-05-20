#!/bin/bash

echo "Welcome to Terraform Ninja Mode! Let's Make Magic Happen!"
while [ true ]
do 
        echo "Choose your terraform command:
        0 - Init
        1 - Plan
        2 - Apply
        3 - Destroy
        4 - Validate
        5 - Formate Code
        6 - Refresh
        7 - Exit"

        read class

        case $class in
                0)
                        terraform init
                        ;;
                1)
                        terraform plan
                        ;;
                2)
                        terraform apply --auto-approve
                        ;;
                3)
                        terraform destroy --auto-approve
                        ;;
                4)
                        terraform validate
                        ;;
                5)
                        terraform fmt --recursive
                        ;;
                6)
                        terraform refresh
                        ;;
                7)
                        echo "Thanks for your time buddy!"
                        exit
                        ;;

        esac
done

