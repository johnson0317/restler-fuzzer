#!/bin/sh
curl -o $1 $2
/RESTler/restler/Restler compile --api_spec /app/openapi.json & wait
/RESTler/restler/Restler test --host $3 --target_port $4 --grammar_file /Compile/grammar.py --dictionary_file /Compile/dict.json --settings /Compile/engine_settings.json --no_ssl & wait
/RESTler/restler/Restler fuzz-lean --host $3 --target_port $4 --grammar_file /Compile/grammar.py --dictionary_file /Compile/dict.json --settings /Compile/engine_settings.json --no_ssl & wait
/RESTler/restler/Restler fuzz --host $3 --target_port $4 --grammar_file /Compile/grammar.py --dictionary_file /Compile/dict.json --settings /Compile/engine_settings.json --no_ssl --time_budget $5