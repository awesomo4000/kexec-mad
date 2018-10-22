KDIR  ?= $(HOME)/src/linux-3.18-msm
CROSS ?= armv7-unknown-linux-gnueabihf-
ARCH  ?= arm

EXTRA_CFLAGS += -DCONFIG_KEXEC -DCONFIG_ARM -Wall -Wno-unused-function

LDFLAGS=-static 

obj-m += kexec_load.o

kexec-mod-y := kexec.o machine_kexec.o msm_kexec.o relocate_kernel.o

kexec_load-objs := kexec.o machine_kexec.o msm_kexec.o relocate_kernel.o

all:
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS) -C $(KDIR) M=$(PWD) 
	modinfo kexec_load.ko

clean:
	rm -rf *.o *.ko *.d .*.o.cmd .*.ko.cmd *.order .tmp_versions Module.symvers Modules.order *.mod.c
