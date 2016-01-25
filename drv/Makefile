MOD_NAME=uio_pruss
obj-m += $(MOD_NAME).o
MOD_PATH=drivers/uio/

all: $(MOD_NAME).ko

$(MOD_NAME).ko:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

install: $(MOD_NAME).ko
	@if ! test $$(whoami) = "root"; then echo "Expect root user"; false; fi
	gzip $(MOD_NAME).ko
	cp $(MOD_NAME).ko.gz /usr/lib/modules/$(shell uname -r)/kernel/$(MOD_PATH)
