## Steps to initialize environment
1. Open a terminal on the root directory of the project
2. Load environment with `nix-shell`
3. Clone the zmk repo with `git clone https://github.com/zmkfirmware/zmk.git`
4. Enter the zmk project directory with `cd zmk`
5. Start west project with `west init -l app/ && west update && west zephyr-export`

## Steps to build firmware
1. Open a terminal on the root directory of the project
2. Enter the app directory with `cd zmk/app`
3. Build the totem firmware for the left half with `west build -p -b seeeduino_xiao_ble -- -DSHIELD=totem_left -DZMK_CONFIG="../../config" && mv build/zephyr/zmk.uf2 ../../uf2/totem-left.uf2 && rm -rf build`
4. Build the totem firmware for the right half with `west build -p -b seeeduino_xiao_ble -- -DSHIELD=totem_right -DZMK_CONFIG="../../config" && mv build/zephyr/zmk.uf2 ../../uf2/totem-right.uf2 && rm -rf build`
5. Build the klor firmware for the left half with `west build -p -b nice_nano_v2 -- -DSHIELD=klor_left -DZMK_CONFIG="../../config" && mv build/zephyr/zmk.uf2 ../../uf2/klor-left.uf2 && rm -rf build`
6. Build the klor firmware for the right half with `west build -p -b nice_nano_v2 -- -DSHIELD=klor_right -DZMK_CONFIG="../../config" && mv build/zephyr/zmk.uf2 ../../uf2/klor-right.uf2 && rm -rf build`
7. You will find the `uf2` files in the root directory of the project

## Steps to flash firmeware
1. Open a terminal on the root directory of the project
2. Connect the half that you want to flash to the computer and press the reset button twice quickly to go to bootloader mode
3. Mount the drive and copy the firmware to it with `mkdir -p mnt && sudo mount $(lsblk -Sno path,model | grep -F 'nRF UF2' | cut -d' ' -f1) mnt && sudo cp uf2/FILENAME.uf2 mnt`, replacing `FILENAME` to the file that correctly maps to the board and half you have connected
4. When the process is finished, the command `ls mnt` should return empty. If it returns a list of files, wait and try again in 10 seconds
