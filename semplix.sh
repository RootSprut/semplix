#!/bin/bash

clear

if ! command -v swaks &> /dev/null; then
    echo "Installing swaks..."
    sudo apt update
    sudo apt install -y swaks > /dev/null 2>&1
fi

echo -e "\033[1;34m"
echo "                                       @@@@@@@@    .d8888b.                                  888 d8b                         .d8888b.        .d8888b.   "
echo "                                  @@@@@@@@@@@@    d88P  Y88b                                 888 Y8P                        d88P  Y88b      d88P  Y88b  "
echo "                             @@@@@@@@@@@@@@@@@    Y88b.                                      888                                   888           .d88P  "
echo "                        @@@@@@@@@@@@'  @@@@@@@     'Y888b.    .d88b.  88888b.d88b.  88888b.  888 888 888  888      888  888      .d88P          8888'   "
echo "                    @@@@@@@@@@@@@@'  #@@@@@@@         'Y88b. d8P  Y8b 888 '888 '88b 888 '88b 888 888  Y8bd8P'      888  888  .od888P'            'Y8b.  "
echo "              @@@@@@@@@@@@@@@@    @@@@@@@@@@@           '888 88888888 888  888  888 888  888 888 888   X88K        Y88  88P d88P'           888    888  "
echo "         @@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@      Y88b  d88P Y8b,     888  888  888 888 d88P 888 888  d8''8b        Y8bd8P  888'       d8b  Y88b  d88P  "
echo "    #@@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@@@@       'Y8888P'   'Y8888  888  888  888 88888P'  888 888 888  888        Y88P   888888888  Y8P   'Y8888P'   "
echo " @@@@@@@@@@@@@@@@@@@@       @@@@@@@@@@@@@@@@                                        888                                                                 "
echo "   #@@@@@@@@@@@@@@        @@@@@@@@@@@@@@@@@                                         888                                                                 "
echo "         @@@@@@        :@@@@@@@@@@@@@@@@@@@                                         888                                                                 "
echo "             @%      %@@@@@@@@@@@@@@@@@@@@                                                                                                              "
echo "             .@    @@@@@@@@@@@@@@@@@@@@@@@         ______  __   __       ______  _____   _____  _______ _______  _____   ______ _     _ _______         "
echo "              @%   @@@@@@@@@@@@@@@@@@@@@@@         |_____]   \_/        |_____/ |     | |     |    |    |______ |_____] |_____/ |     |    |            "
echo "               @  =@@@@@@@@@@@@@@@@@@@@@@'         |_____]    |         |    \_ |_____| |_____|    |    ______| |       |    \_ |_____|    |            "
echo "               %@ @@@@@@% @@@@@@@@@@@@@@@                                                                                                               "
echo "                @.@@@@%      @@@@@@@@@@@'          ============================================================================================         "
echo "                 @@@@          %@@@@@@@@                                                                                                                "
echo "                                  @@@@@@                                                                                                                "
echo ""
echo -e "\033[0m"

sleep 1

echo -e "\033[1:13m"
echo "IMPORTANT:                    For proper operation, it is recommended to use the following email services: gmail, yandex, outlook, and yahoo                   :IMPORTANT"
echo "IMPORTANT:                             To work, you must create app passwords for your emails and enable the IMAP or SMTP feature                              :IMPORTANT"
echo "IMPORTANT: To get started, create an accountsfsx.conf folder on your desktop and add the email addresses and app passwords, like example@test.com:app_password :IMPORTANT"
echo -e "\033[1:0m"

sleep 1

echo -e "\033[1:13m"
echo "===========================information=========================="
echo "                      created by RootSprut"
echo "                    your semplix version 2.3"
echo "                  Telegram:https://t.me/semplix"
echo "            GitHub:https://github.com/rootsprut/semplix"
echo -e "\033[1:0m"

sleep 1

echo -e "\033[1;34m"
echo "====================Complaint Type Selection===================="
echo "        1. Report content violation (abuse@telegram.org)"
echo "       2. Report copyright infringement (dmca@telegram.org)"
echo "                        Or (Q) to Quit"
echo -e "\033[0m"

   while true; do
       echo -ne "\033[1:13m"
       read -p "==================Enter complaint type (1 or 2), (Q) to Quit >>>" choice
       echo ""
       echo -ne "\033[0m"

    case $choice in
        1)
            complain_email="abuse@telegram.org"
            subject="Content Violation Report"
            break
            ;;
        2)
            complain_email="dmca@telegram.org"
            subject="DMCA Copyright Infringement Notice"
            break
            ;;
        Q)
           echo -e "\033[1;34m===============================================================================QUIT=SEMPLIX===============================================================================\033[0m"
           exit 0
           ;;
        q)
           echo -e "\033[1;34m===============================================================================QUIT=SEMPLIX===============================================================================\033[0m"
           exit 0
           ;;
        *)
           echo -e "\033[1;31m============Invalid choice! Please enter 1, 2 or (Q)============\033[0m"
           echo ""
           ;;
    esac
done

echo -ne "\033[1;34m"
read -p "==Enter massage URL, like this: https://t.me/massageurl/0000 >>>" massage_url
echo ""
echo -ne "\033[0m"

ACC_FILE="$HOME/Desktop/accountsfsx.conf"

if [ ! -f "$ACC_FILE" ]; then
    echo -e "\033[1;31m"
    echo "=================================================================="
    echo "ERROR: File accountsfsx.conf not found on Desktop!"
    echo "Create $ACC_FILE with contents:"
    echo "your_email@gmail.com:your_app_password"
    echo -e "\033[0m"
    exit 1
fi

if [ "$complaint_type" = "1" ]; then
    MSG="Hello, this Telegram user: $message_url has violated the rules of your platform by posting inappropriate content. I hope you will review the information I have provided and take appropriate action to remove this content."
else
    MSG="Hello, I am writing to report a copyright infringement. The content at $message_url violates my intellectual property rights under the DMCA. Please remove this infringing material immediately."
fi

success_send=0
fail_send=0

while IFS=: read -r email password; do
    [[ "$email" =~ ^# ]] && continue
    [ -z "$email" ] && continue

    echo -e "\033[1;34mSending complain from $email\033[0m"

    domain="${email#*@}"
    case $domain in
        gmail.com)
            server="smtp.gmail.com"
            port=587
            tls_options=("--tls")
            ;;
        yandex.ru)
            server="smtp.yandex.ru"
            port=465
            tls_options=("--tls-on-connect")
            ;;
        outlook.com|hotmail.com)
            server="smtp.office365.com"
            port=587
            tls_options=("--tls")
            ;;
        yahoo.com)
            server="smtp.mail.yahoo.com"
            port=465
            tls_options=("--tls-on-connect")
            ;;
        *)
            echo -e "\033[1;13mUsing default SMTP (Gmail)\033[0m"
            server="smtp.gmail.com"
            port=587
            tls_options=("--tls")
            ;;
    esac
    echo -e "\033[1;13mUsing server: $server:$port\033[0m"

    swaks \
        --to "$complain_email" \
        --from "$email" \
        --server "$server" \
        --port $port \
        --auth LOGIN \
        --auth-user "$email" \
        --auth-password "$password" \
        "${tls_options[@]}" \
        --header "Subject: Violation Report" \
        --body "$MSG" \
        --timeout 60 \
        --silent 3 > /dev/null 2>&1

    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo -e "\033[1;32m✓ Complain successfully sent!\033[0m"
        echo ""
        success_send=$((success_send + 1))
    else
        echo -e "\033[1;31m✗ Complain sending failed (code: $exit_code)\033[0m"
        echo ""
        fail_send=$((fail_send + 1))
    fi

    sleep 1
done < "$ACC_FILE"

echo -e "\n\033[1;34m=================== Complaint Sending Reports ==================== "
echo -e "\033[1;32m                       Successfully sent: $success_send"
echo -e "\033[1;31m                         Failed to send: $fail_send"
echo -e "\033[1;34m==================================================================\033[0m"
