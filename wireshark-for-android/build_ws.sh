# MobileInsight Vagrant Installation Script
# Copyright (c) 2020 MobileInsight Team
# Author: Yuanjie Li, Zengwen Yuan, Yunqi Guo
# Version: 2.0

source ~/envsetup.sh

echo "Compiling wireshark for Android"
cd  ~/wireshark-3.4.0
cmake -DCMAKE_PREFIX_PATH=${PREFIX} -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a -DANDROID_NATIVE_API_LEVEL=26 -DCMAKE_LIBRARY_PATH=${PREFIX} -DGLIB2_LIBRARY=${PREFIX}/lib/libglib-2.0.so -DGLIB2_MAIN_INCLUDE_DIR=${PREFIX}/include/glib-2.0 -DGLIB2_INTERNAL_INCLUDE_DIR=${PREFIX}/lib/glib-2.0/include -DGMODULE2_LIBRARY=${PREFIX}/lib/libgmodule-2.0.so -DGMODULE2_INCLUDE_DIR=${PREFIX}/include/glib-2.0 -DGTHREAD2_LIBRARY=${PREFIX}/lib/libgthread-2.0.so -DGTHREAD2_INCLUDE_DIR=${PREFIX}/include/glib-2.0 -DGCRYPT_LIBRARY=${PREFIX}/lib/libgcrypt.a -DGCRYPT_INCLUDE_DIR=${PREFIX}/include -DGCRYPT_ERROR_LIBRARY=${PREFIX}/lib/libgpg-error.a -DCARES_LIBRARY=${PREFIX}/lib/libcares.a -DCARES_INCLUDE_DIR=${PREFIX}/include -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a -DANDROID_NATIVE_API_LEVEL=26 -DENABLE_gnutls=OFF -DENABLE_plugins=OFF -DENABLE_pcap=OFF -DENABLE_libgcrypt-prefix=OFF -DBUILD_wireshark=OFF -DBUILD_packet-editor=OFF -DBUILD_profile-build=OFF -DBUILD_tshark=OFF -DBUILD_editcap=OFF -DBUILD_capinfos=OFF -DBUILD_captype=OFF -DBUILD_mergecap=OFF -DBUILD_reordercap=OFF -DBUILD_text2pcap=OFF -DBUILD_dftest=OFF -DBUILD_randpkt=OFF -DBUILD_dumpcap=OFF -DBUILD_rawshark=OFF -DBUILD_sharkd=OFF -DBUILD_tfshark=OFF -DBUILD_pcap-ng-default=OFF -DBUILD_androiddump=OFF -DBUILD_sshdump=OFF -DBUILD_ciscodump=OFF -DBUILD_randpktdump=OFF -DBUILD_udpdump=OFF .

grep -rwl '&& lemon' * | xargs -i@ sed -i 's/\&\& lemon/\&\& ~\/lemon/g' @
make
sudo make install