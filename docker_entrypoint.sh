#!/bin/sh

set -e

echo "=== BOWNLING CALCULATOR ENTRYPOINT ==="

COMMAND="$1"

echo "=== BUNDLING ==="
bundle check || bundle install --jobs 20 --retry 5

case "$COMMAND" in
  calc_test)
    echo "=== RUNNING PROGRAM USING TEST FILE ==="
    ruby main.rb "spec/examples/template.txt"
    ;;
  calc)
    echo "=== RUNNING CALCULATOR USING FILE PATH==="
    FILE_PATH="$2"
    ruby main.rb "$FILE_PATH"
    ;;
  test)
    echo "=== RUNNING TEST SUITE ==="
    rspec spec
    ;;
  lint)
    echo "=== RUNNING LINTER ==="
    rubocop -a
    ;;
  *)
    echo "=== RUNNING COMAND  $*==="
    sh -c "$*"
    ;;
esac