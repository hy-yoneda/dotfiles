if [ -f "${HOME}/.dev_profile" ] ; then
	source "${HOME}/.dev_profile"
fi

if [ -f "${HOME}/.profile.local" ] ; then
	source "${HOME}/.profile.local"
fi

#if [ -f "${HOME}/.bash_profile" ] ; then
#	source "${HOME}/.bash_profile"
#fi

if [ -n "${HOME}/usr/local/bin" ] ; then
	export PATH=${HOME}/usr/local/bin:$PATH
fi

alias vi='vim'
