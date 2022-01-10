#!/usr/bin/env bash

# меняем версию ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 3.0

# найдем директорию, в которой лежит файл исполняемого срипта
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# перейдем в нее
cd "$DIR"

# установка Bundler, если необходимо
if hash bundler 2>/dev/null;
then
    echo Bundler is installed
else
    sudo gem install bundler
fi

# установка HomeBrew, если необходимо
if hash brew 2>/dev/null;
then
    echo HomeBrew is installed
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# установка xcodegen, если необходимо
if hash xcodegen 2>/dev/null;
then
    echo xcodegen is installed
else
    brew install xcodegen
fi

# Устанавливаем ruby зависимости.
# Cocoapods
bundle install
