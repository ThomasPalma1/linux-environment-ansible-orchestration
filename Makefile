operational_system := $(shell uname)
package_manager :=
playbook := playbook/playbook-dev-workstation-setup.yml
python_version := 3.11.3
python_archive := Python-$(python_version).tgz
python_url := https://www.python.org/ftp/python/$(python_version)/$(python_archive)

ifeq ($(operational_system), Linux)
        ifeq ($(shell command -v dnf 2> /dev/null), )
                package_manager := apt
        else
                package_manager := dnf
        endif
endif

install:
ifeq ($(package_manager), apt)
        sudo apt update -y
        sudo apt install ansible -y
else ifeq ($(package_manager), dnf)
	sudo dnf update -y

	sudo dnf groupinstall -y "Development Tools"
	sudo dnf install zlib-devel libffi-devel openssl-devel -y

	sudo wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tar.xz && \
  	sudo tar -xf Python-3.11.0.tar.xz && \
       	cd Python-3.11.0 && \
       	sudo ./configure --enable-optimizations && \
       	sudo make -j $(nproc) && \
       	sudo make altinstall && \
       	pip3.11 install ansible

else
	@echo "Unsupported operating system: $(operational_system)"
	@exit 1
endif
	@sleep 3
	@echo "Running playbook..."
	@ansible-playbook $(playbook)
