#!bin/bash
# (If you need it, rewrite /etc/resolv.conf)

while getopts jhmsyv OPT; do
    case $OPT in
        j ) JAPANESE="TRUE" ;;
        h ) HELP="TRUE" ;;
		m ) MANUAL="TRUE" ;;
        s ) START="TRUE" ;;
        y ) ALL_YES="TRUE" ;;
		v ) DISPLAY_VERSION="TRUE" ;;
    esac
done

VERSION="0.3.0"

if [ "${DISPLAY_VERSION}" = "TRUE" ]; then
	echo "v${VERSION}";
	exit;
fi

if [ "${HELP}" = "TRUE" ]; then
    if [ "${JAPANESE}" = "TRUE" ]; then
        echo "これは何?"
        echo "  これはセイレーンのためのシェルスクリプトです。";
        echo "  これを使えばセイレーンを簡単に動かせます。";
        echo "  このシェルスクリプトは単独実行での環境構築を提供します。";
        echo "オプション";
        echo "  -j : 言語を日本語にします。";
        echo "  -h : ヘルプを表示します。";
        echo "  -s : 「サーバーをスタート」だけさせたい時にこのオプションを使用してください。";
        echo "  -y : 全ての質問に「はい」と答えたいときにこのオプションを使用してください。";
		echo "	-v : バージョンを表示ます。";
        echo "オプションの組み合わせ";
        echo "  -jと-hは併用できます。";
    else
        echo "WHAT IS THIS?";
        echo "  THIS IS A SHELLSCRIPT FOR SIRENE.";
        echo "  YOU CAN USE SIRENE EASILY BY USING THIS.";
        echo "  THIS SHELLSCRIPT PROVIDES A SINGLE EXECUTION ENVIROMENT SETUP";
        echo "OPTIONS";
        echo "  -j : SET THE LANGUAGE TO JAPANESE.";
        echo "  -h : THIS OPTION DISPLAY HELP.";
        echo "  -s : USE THIS OPTION WHEN YOU ONLY WANT TO START SERVER.";
        echo "  -y : USE THIS OPTION WHEN YOU WANT TO ANSWER \"YES\" TO ALL QUESTIONS";
		echo "	-v : THIS OPTIONS DISPLAY VERSION";
        echo "COMBINATION OF OPTIONS";
        echo "  -j AND -h CAN USE TOGETHER";
    fi
    exit;
fi

if [ "${START}" = "TRUE" ]; then
    cd sirene/;
    source ~/.profile;
    sudo ufw allow 8000;
    poetry run start;
    sudo ufw delete allow 8000;
    cd ..;
    exit;
fi

ALL_SUCCESS="TRUE"

function INFO () {
    echo -e "\e[32m COMMAND : '$1' WAS EXECUTED \e[m"
    echo -e "\e[m Press Enter to continue OR Press Ctrl+C to exit \e[m"
    if [ "${ALL_YES}" != "TRUE" ]; then
        read $USERINPUT
    fi
    if [ $? -ne 0 ]; then
		ALL_SUCCESS="FALSE"
		echo -e "\e[33m COMMAND : '$1' FAILED \e[m"
		read $USERINPUT
    fi
}

sudo apt update
INFO "sudo apt update"

sudo apt upgrade -y
INFO "sudo apt upgrade -y"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
INFO "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash"

echo "export NVM_DIR=\"\$HOME/.nvm\"" >> ~/.profile
INFO 'echo "export NVM_DIR=\"\$HOME/.nvm\"" >> ~/.profile'

echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"" >> ~/.profile
INFO "echo \"[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"\""

echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"" >> ~/.profile
INFO "echo \"[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"\" >> ~/.profile"

source ~/.profile
INFO "source ~/.profile"

source ~/.bashrc
INFO "source ~/.bashrc"

nvm install v14.17.1
INFO "install ~/.bashrc"

sudo apt update
INFO "sudo apt update"

sudo apt upgrade -y
INFO "sudo apt upgrade -y"

sudo apt install python3-pip -y
INFO "sudo apt install python3-pip -y"

sudo apt install build-essential libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev libopencv-dev tk-dev git -y
INFO "sudo apt install build-essential libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev libopencv-dev tk-dev git -y"

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
INFO "git clone https://github.com/pyenv/pyenv.git ~/.pyenv"

echo '' >> ~/.profile
INFO "echo \'\' >> ~/.profile"

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
INFO "echo \'export PYENV_ROOT=\"\$HOME/.pyenv\"\' >> ~/.profile"

echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
INFO "echo \'export PATH=\"\$PYENV_ROOT/bin:\$PATH\"\' >> ~/.profile"

echo 'eval "$(pyenv init --path)"' >> ~/.profile
INFO "echo \'eval \"\$(pyenv init --path)\"\' >> ~/.profile"

source ~/.profile
INFO "source ~/.profile"

pyenv install 3.8.14
INFO "pyenv install 3.8.14"

pyenv global 3.8.14
INFO "pyenv global 3.8.14"

git clone --recursive https://github.com/frodo821/sirene-server sirene
INFO "git clone --recursive https://github.com/frodo821/sirene-server sirene"

cd sirene/frontend/
INFO "cd sirene/frontend/"

npm install
INFO "npm install"

npm run build
INFO "npm run build"

cd ..
INFO "cd .."

curl -sSL https://install.python-poetry.org | python3 - --version 1.8.5
INFO "curl -sSL https://install.python-poetry.org | python3 - --version 1.8.5"

echo "export PATH=\"\$HOME/.poetry/bin:\$PATH\"" >> ~/.profile
INFO "echo \"export PATH=\"\$HOME/.poetry/bin:\$PATH\"\" >> ~/.profile"

source ~/.profile
INFO "source ~/.profile"

poetry env use python3.8
INFO "poetry env use python3.8"

poetry install
INFO "poetry install"

sudo apt install ufw -y
INFO "sudo apt install ufw -y"

sudo apt install libportaudio2 libportaudiocpp0 portaudio19-dev -y
INFO "sudo apt install libportaudio2 libportaudiocpp0 portaudio19-dev -y"

sudo ufw enable
INFO "sudo ufw enable"

if [ "${ALL_SUCCESS}" = "TRUE" ]; then
    echo "ALL COMMANDS WERE SUCCESSFUL.";
else 
    echo "SOME COMMAND FAILED";
    echo "PLEASE CONFIRM";
fi

