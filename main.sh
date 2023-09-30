# Clone Upstream
git clone https://github.com/roc-streaming/roc-toolkit -b v0.2.5
rm -rfv ./roc-toolkit/debian
cp -rvf ./debian ./roc-toolkit/
cd ./roc-toolkit

for i in ../patches/*.patch; do patch -Np1 -i $i ;done

LOGNAME=root dh_make --createorig -y -l -p roc-toolkit_0.2.5

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
