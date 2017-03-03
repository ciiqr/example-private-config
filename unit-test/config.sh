
__private_config()
{
	__priv_conf[deluge_password]=PasswordHere1234
	__priv_conf[foo]="' FOO '"

	local -a things=(
		Me You "Eternal Sadness"
		[10]="Darkness"
	)
	__priv_conf[things]="`array_serialize things`"
}
__private_config
