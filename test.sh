#!/usr/bin/env bash

# Example Configs
# categories=(personal frontend sublime development 'hi hi' server-data)
categories=("unit-test")

# This script's directory
script_directory="$(dirname "${BASH_SOURCE[0]}")"
private_config_dir="$script_directory"

# Source private config
. "$private_config_dir/config.sh" priv_conf categories

# Get values
if [[ "${priv_conf[foo]}" != "' FOO '" ]]; then
	echo "foo: ${priv_conf[foo]}"
fi

if [[ "${priv_conf[deluge_password]}" != "PasswordHere1234" ]]; then
	echo "deluge_password: ${priv_conf[deluge_password]}"
fi

# Get array values
if [[ "${priv_conf[things]}" != '([0]="Me" [1]="You" [2]="Eternal Sadness" [10]="Darkness")' ]]; then
	echo "things(string): ${priv_conf[things]}"
fi

declare -a expected_things=(
	Me You "Eternal Sadness"
	[10]="Darkness"
)

array_unserialize things "${priv_conf[things]}"

if [[ "${#things[@]}" != "${#expected_things[@]}" ]]; then
	echo "things(count): ${priv_conf[things]}"
	echo "expected_things(count): ${expected_things}"
fi

for i in "${!things[@]}"; do
	if [[ "${things[$i]}" != "${expected_things[$i]}" ]]; then
		echo "$i: ${things[$i]}"
	fi
done

if [[ "`array_get_first_set things 11 23 10 2`" != "Darkness" ]]; then
	echo "array_get_first_set things 11 23 10 2: `array_get_first_set things 11 23 10 2`"
fi

if [[ "`array_get_first_set priv_conf this foo too`" != "' FOO '" ]]; then
	echo "array_get_first_set priv_conf this foo too: `array_get_first_set priv_conf this foo too`"
fi

if [[ "`array_get_first_set priv_conf deluge_username common_username || echo bob`" != "bob" ]]; then
	echo "array_get_first_set priv_conf deluge_username common_username || echo bob: `array_get_first_set priv_conf deluge_username common_username || echo bob`"
fi
