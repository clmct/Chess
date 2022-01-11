DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

if hash bundler 2>/dev/null;
then
    echo bundler is installed
else
    echo bundler is not installed, run setup.command
fi

sh xcodegen.command

bundle exec pod install
