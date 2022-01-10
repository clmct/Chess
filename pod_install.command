# найдем директорию, в которой лежит файл исполняемого скрипта
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# перейдем в нее
cd "$DIR"

# Проверка установки Bundler
if hash bundler 2>/dev/null;
then
    echo Bundler is installed
else
    echo Bundler is not installed, run setup.command
    exit 1
fi

# меняем версию ruby
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#rvm use 3.0

# найдем директорию, в которой лежит файл исполняемого скрипта
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# перейдем в нее
cd "$DIR"

# генерируем проект
#sh xcodegen.command

# подгрузим поды
#bundle install

# подгрузим поды
pod install
