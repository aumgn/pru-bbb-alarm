DT = am335x-boneblack

.PHONY: all
all: $(DT).dtb

$(DT).dtb: $(DT).dts
	dtc -I dts -O dtb $< -o $@

.PHONY: install
install: $(DT).dtb
	@if ! test $$(whoami) = "root"; then echo "Expect root user"; false; fi
	cp $(DT).dtb /boot/dtbs/
	chown root:root /boot/dtbs/$(DT).dtb
