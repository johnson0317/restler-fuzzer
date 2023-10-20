#!/bin/bash
if [ "$1" != "local" ]
then
    echo "Retrieving API specs... "
    curl -o /app/openapi.json $1
    echo "Compiling API specs..."
    /RESTler/restler/Restler compile --api_spec /app/openapi.json & wait
else
    echo "Using local openapi file to compile."
    echo "Compiling API specs..."
    /RESTler/restler/Restler compile --api_spec /data/repo/openapi.json & wait
fi
/RESTler/restler/Restler test --host $2 --target_port $3 --grammar_file /Compile/grammar.py --dictionary_file /Compile/dict.json --settings /Compile/engine_settings.json --no_ssl & wait
/RESTler/restler/Restler fuzz-lean --host $2 --target_port $3 --grammar_file /Compile/grammar.py --dictionary_file /Compile/dict.json --settings /Compile/engine_settings.json --no_ssl & wait
/RESTler/restler/Restler fuzz --host $2 --target_port $3 --grammar_file /Compile/grammar.py --dictionary_file /Compile/dict.json --settings /Compile/engine_settings.json --no_ssl --time_budget $4 & wait
mkdir -p /artifacts & wait
cp /Fuzz/RestlerResults/experiment*/logs/main.txt /artifacts/ & wait
python3 merge_files.py
