set root=%cd%

// libiio
mkdir deps
wget https://github.com/analogdevicesinc/libiio/releases/download/v0.21/libiio-0.21.g565bf68-Windows.zip -O libiio-win.zip
unzip libiio-win.zip
cp -r libiio*/MS64/libiio.dll deps/
cp -r libiio*/MS64/libiio.exp deps/
cp -r libiio*/MS64/libiio.lib deps/
mkdir deps\include
cp -r libiio*/include/* deps/include/


// libm2k
git clone -b matlab-new-api https://github.com/analogdevicesinc/libm2k.git
cd libm2k
mkdir build
cd build
cmake -DENABLE_CSHARP=OFF -DENABLE_PYTHON=OFF -DIIO_LIBRARIES:FILEPATH="%root%\deps\libiio.lib" -DIIO_INCLUDE_DIRS:PATH="%root%\deps\include" -DCMAKE_CONFIGURATION_TYPES=RELEASE -G "Visual Studio 15 Win64" ..

cmake --build . --config Release
cd ../..
cp libm2k/build/libm2k.dll deps/
cp libm2k/build/libm2k.exp deps/
cp libm2k/build/libm2k.lib deps/
cp -r libm2k/include/* deps/include/

// Cleanup
rm -rf libiio*
rm -rf libm2k
rm -rf libiio-win.zip
mv deps libm2k

