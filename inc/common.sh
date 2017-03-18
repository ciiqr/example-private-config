
# TODO: I should really consider having a repo with a set of common functions... to be used by all of these scripts...

source_if_exists()
{
    if [[ -f "$1" ]]; then
        source "$1"
    else
        return 1
    fi
}

array_serialize()
{
	# I found this suggested without removing the single quotes, but that doesn't work, so I'm guessing the single quotes aren't there in all versions of bash...
	local serialized="`declare -p "$1"`"
	serialized="${serialized#*=}"
	serialized="${serialized#\'}"
	serialized="${serialized%\'}"

	eval "echo '$serialized'"
}
array_unserialize()
{
	eval "$1=$2"
}
array_copy()
{
	local serialized="`array_serialize "$1"`"
	array_unserialize "$2" "$serialized"
}
array_get_first_set()
{
	# Get the array
	declare -A arr
	array_copy "$1" arr
	shift

	# Search for the keys
	for k in "$@"; do
		if [[ "${arr[$k]+isset}" == 'isset' ]]; then
			echo "${arr[$k]}"
			return 0
		fi
	done

	return 1
}
