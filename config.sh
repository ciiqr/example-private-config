
__private_config()
{
	local source_dir="$(dirname "${BASH_SOURCE[0]}")"
	local __pc_ext_var="$1"
	eval 'declare -a __pc_categories=("${'"$2"'[@]}") '
	local -A __priv_conf=()

	. "$source_dir/inc/common.sh"

	# Source categories
	local category
	for category in "${__pc_categories[@]}"; do
		source_if_exists "$source_dir/$category/config.sh"
	done

	array_copy __priv_conf "$__pc_ext_var"
}

declare -A "$1"

__private_config "$@"
unset -f __private_config
