#!/bin/bash
#
# Uncomment commented lines for kernel with modules
#
export DEVICE=flo
export ZWLIEW_VERSION=r$1

export KERNELDIR=/home/zwliew/android/kernel
export DEVICEDIR=$KERNELDIR/$DEVICE
export MKBOOTIMGDIR=$KERNELDIR/mkbootimg_tools
export OUTDIR=$DEVICEDIR/out

#export OUTDIR=$DEVICEDIR/out/$DEVICE

cd $DEVICEDIR

make zwliew_defconfig
time make -j4 > ../a
cp arch/arm/boot/zImage $MKBOOTIMGDIR/$DEVICE/zImage
cp -r ramdisk $MKBOOTIMGDIR/$DEVICE

# find . -name "*.ko" -exec cp {} $OUTDIR/system/lib/modules \;

if [ "$2" = "1" ]
then
  make mrproper
fi

cd $MKBOOTIMGDIR

./mkboot $DEVICE boot.img
mv boot.img $OUTDIR/boot.img

cd $DEVICE

rm -r ramdisk
rm zImage

# cd $OUTDIR/system/lib/modules

# mv wlan.ko prima/prima_wlan.ko

cd $OUTDIR

mv boot.img zwliew_Kernel-$DEVICE-$ZWLIEW_VERSION.img

# zip -r zwliew_Kernel-$DEVICE-$ZWLIEW_VERSION.zip META-INF
# zip -r zwliew_Kernel-$DEVICE-$ZWLIEW_VERSION.zip system
# zip zwliew_Kernel-$DEVICE-$ZWLIEW_VERSION.zip boot.img

cd $DEVICEDIR