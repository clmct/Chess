DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
if hash xcodegen 2>/dev/null; 
then
    echo xcodegen is installed
else    
    echo xcodegen is not installed, run setup.command
fi
xcodegen generate
echo "Xcodegen generated"
