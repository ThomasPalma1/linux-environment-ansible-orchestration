operational_system := $(shell uname)
package_manager :=

ifeq ($(operational_system), Linux)
    ifeq ($(shell command -v dnf 2> /dev/null), )
        package_manager := apt
    else
        package_manager := dnf
    endif
endif

install:
    ifdef package_manager
        ifeq ($(package_manager), apt)
            sudo apt update -y
            sudo apt install ansible -y
        else
            sudo dnf update -y
			sudo dnf install epel-release -y
            sudo dnf install ansible -y
        endif
    else
        @echo "Unsupported operating system: $(operational_system)"
        @exit 1
    endif
