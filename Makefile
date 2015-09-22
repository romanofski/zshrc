.zshrc: zshrc
	ln -s $(shell pwd)/$< $(HOME)/$@ 

.zsh-custom: zsh-custom
	ln -s $(shell pwd)/$< $(HOME)/$@

.zprofile: zprofile
	ln -s $(shell pwd)/$< $(HOME)/$@

install: .zshrc .zsh-custom .zprofile

uninstall:
	rm $(HOME)/.zshrc $(HOME)/.zsh-custom $(HOME)/.zprofile
