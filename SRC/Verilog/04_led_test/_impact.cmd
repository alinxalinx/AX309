loadProjectFile -file "C:\Xilinx\auto_project.ipf"
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
setMode -bs
setMode -bs
setMode -bs
setMode -bs
setMode -bs
deleteDevice -position 1
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -pff
setMode -pff
addConfigDevice  -name "led_tset" -path "E:\Project\AX516\verilog\led_test"
setSubmode -pffspi
setAttribute -configdevice -attr multibootBpiType -value ""
addDesign -version 0 -name "0"
setMode -pff
addDeviceChain -index 0
setMode -pff
addDeviceChain -index 0
setAttribute -configdevice -attr compressed -value "FALSE"
setAttribute -configdevice -attr compressed -value "FALSE"
setAttribute -configdevice -attr autoSize -value "FALSE"
setAttribute -configdevice -attr fileFormat -value "mcs"
setAttribute -configdevice -attr fillValue -value "FF"
setAttribute -configdevice -attr swapBit -value "FALSE"
setAttribute -configdevice -attr dir -value "UP"
setAttribute -configdevice -attr multiboot -value "FALSE"
setAttribute -configdevice -attr multiboot -value "FALSE"
setAttribute -configdevice -attr spiSelected -value "TRUE"
setAttribute -configdevice -attr spiSelected -value "TRUE"
addPromDevice -p 1 -size 16384 -name 16M
setMode -pff
setMode -pff
setMode -pff
setMode -pff
addDeviceChain -index 0
setMode -pff
addDeviceChain -index 0
setSubmode -pffspi
setMode -pff
setAttribute -design -attr name -value "0000"
addDevice -p 1 -file "E:/Project/AX516/verilog/led_test/led_test.bit"
setMode -pff
setSubmode -pffspi
generate
setCurrentDesign -version 0
setMode -bs
setMode -bs
setMode -bs
setCable -port auto
Identify -inferir 
identifyMPM 
attachflash -position 1 -spi "W25Q128FV"
assignfiletoattachedflash -position 1 -file "E:/Project/AX516/verilog/led_test/led_tset.mcs"
Program -p 1 -dataWidth 1 -spionly -e -v -loadfpga 
Program -p 1 -dataWidth 1 -spionly -e -v -loadfpga 
assignFile -p 1 -file "E:/Project/AX516/verilog/key_test/key_test.bit"
Program -p 1 
setMode -bs
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
saveProjectFile -file "C:\Xilinx\\auto_project.ipf"
setMode -bs
setMode -pff
setMode -bs
deleteDevice -position 1
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
deletePromDevice -position 1
setCurrentDesign -version 0
deleteDevice -position 1
deleteDesign -version 0
setCurrentDesign -version -1
