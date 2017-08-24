#!/bin/bash
if [ -z $THREADS ]; then
  THREADS=`nproc`
fi

installCheck () {
  g++ check_opencv.cpp -o check_opencv
  if [[ $? -ne 0 ]]; then
    return 1
  else
    rm check_opencv
    return 0
  fi
}

if installCheck "$0"; then
  echo "OpenCV already installed, skipping"
  exit 0
fi

set -e

if [ ! -d opencv ]; then
  git clone -b 2.4 --single-branch --depth 1 https://github.com/opencv/opencv.git
fi
cd opencv

git checkout 2.4
git pull
mkdir -p build
cd build

if [ -z "$JAVA_HOME" ]; then
  export JAVA_HOME=`find /usr/lib/jvm/ -mindepth 1 -maxdepth 1 -type d | head -1`
fi

cmake -D INSTALL_CREATE_DISTRIB=ON -D CMAKE_BUILD_TYPE=RELEASE -D BUILD_NEW_PYTHON_SUPPORT=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON \
  -D BUILD_opencv_apps=ON -D WITH_V4L=ON -D WITH_OPENGL=ON -D ENABLE_FAST_MATH=1 -D WITH_TBB=ON -D CUDA_FAST_MATH=1 -D WITH_CUBLAS=1 -D WITH_CUDA=ON -D WITH_NVCUVID=ON \
  -D ENABLE_PRECOMPILED_HEADERS=OFF -D CMAKE_INSTALL_PREFIX=/usr ..
make -j$THREADS

DEF_VER=`apt-cache search libopencv-features2d | grep -Poe "2.4v\d+"`
if [ -z "$DEF_VER" ]; then
  echo "Default OpenCV version could not be determined for your operating system!!! Is your operating system supported???"
  exit 1
fi

ACT_VER=`cat ./build/version_string.tmp | grep -Poe "2\.4\.\d+\.\d+-\d+"`
ACT_REL=`echo $ACT_VER | grep -Poe "(?<=-)\d+"`
ACT_VER=`echo $ACT_VER | grep -Poe "[\d\.]+(?=-)"`
if [ -z "$ACT_VER" ] || [ -z "$ACT_REL" ]; then
  echo "Actual OpenCV version could not be determined from build files!!! Must be a temporary error..."
  cd ..
  rm -rf build
  exit 1
fi

commit=`git log | grep -Poe "(?<=commit )[a-zA-Z0-9]+" | head -1`
date=`git log | grep -Pe "Date" | head -1`

echo "GitHub build of OpenCV 2.4 libraries. Latest commit: https://github.com/opencv/opencv/commit/$commit. $date" > description-pak

checkinstall --default --pkgname=libopencv-dev --pkgversion=$ACT_VER --pkgrelease=$ACT_REL --pkgsource=${PWD%/build} --maintainer="OpenCV" --nodoc --requires="libc6 \(\>= 2.14\),libgcc1 \(\>= 1:3.0\),pkg-config" \
  --provides=libcvaux-dev,libcv-dev,libhighgui-dev,libopencv2.4-java,libopencv2.4-jni,libopencv-apps0d,libopencv-apps-dev,libopencv-calib3d$DEF_VER,libopencv-calib3d-dev,libopencv-contrib$DEF_VER,libopencv-contrib-dev,libopencv-core$DEF_VER,libopencv-core-dev,libopencv-dev,libopencv-features2d$DEF_VER,libopencv-features2d-dev,libopencv-flann$DEF_VER,libopencv-flann-dev,libopencv-gpu$DEF_VER,libopencv-gpu-dev,libopencv-highgui$DEF_VER,libopencv-highgui-dev,libopencv-imgproc$DEF_VER,libopencv-imgproc-dev,libopencv-legacy$DEF_VER,libopencv-legacy-dev,libopencv-ml$DEF_VER,libopencv-ml-dev,libopencv-objdetect$DEF_VER,libopencv-objdetect-dev,libopencv-ocl$DEF_VER,libopencv-ocl-dev,libopencv-photo$DEF_VER,libopencv-photo-dev,libopencv-stitching$DEF_VER,libopencv-stitching-dev,libopencv-superres$DEF_VER,libopencv-superres-dev,libopencv-ts$DEF_VER,libopencv-ts-dev,libopencv-video$DEF_VER,libopencv-video-dev,libopencv-videostab$DEF_VER,libopencv-videostab-dev,opencv-data,opencv-doc,python-opencv,python-opencv-apps
  --replaces=libcvaux-dev,libcv-dev,libhighgui-dev,libopencv2.4-java,libopencv2.4-jni,libopencv-apps0d,libopencv-apps-dev,libopencv-calib3d$DEF_VER,libopencv-calib3d-dev,libopencv-contrib$DEF_VER,libopencv-contrib-dev,libopencv-core$DEF_VER,libopencv-core-dev,libopencv-dev,libopencv-features2d$DEF_VER,libopencv-features2d-dev,libopencv-flann$DEF_VER,libopencv-flann-dev,libopencv-gpu$DEF_VER,libopencv-gpu-dev,libopencv-highgui$DEF_VER,libopencv-highgui-dev,libopencv-imgproc$DEF_VER,libopencv-imgproc-dev,libopencv-legacy$DEF_VER,libopencv-legacy-dev,libopencv-ml$DEF_VER,libopencv-ml-dev,libopencv-objdetect$DEF_VER,libopencv-objdetect-dev,libopencv-ocl$DEF_VER,libopencv-ocl-dev,libopencv-photo$DEF_VER,libopencv-photo-dev,libopencv-stitching$DEF_VER,libopencv-stitching-dev,libopencv-superres$DEF_VER,libopencv-superres-dev,libopencv-ts$DEF_VER,libopencv-ts-dev,libopencv-video$DEF_VER,libopencv-video-dev,libopencv-videostab$DEF_VER,libopencv-videostab-dev,opencv-data,opencv-doc,python-opencv,python-opencv-apps
  --conflicts=libcvaux-dev,libcv-dev,libhighgui-dev,libopencv2.4-java,libopencv2.4-jni,libopencv-apps0d,libopencv-apps-dev,libopencv-calib3d$DEF_VER,libopencv-calib3d-dev,libopencv-contrib$DEF_VER,libopencv-contrib-dev,libopencv-core$DEF_VER,libopencv-core-dev,libopencv-dev,libopencv-features2d$DEF_VER,libopencv-features2d-dev,libopencv-flann$DEF_VER,libopencv-flann-dev,libopencv-gpu$DEF_VER,libopencv-gpu-dev,libopencv-highgui$DEF_VER,libopencv-highgui-dev,libopencv-imgproc$DEF_VER,libopencv-imgproc-dev,libopencv-legacy$DEF_VER,libopencv-legacy-dev,libopencv-ml$DEF_VER,libopencv-ml-dev,libopencv-objdetect$DEF_VER,libopencv-objdetect-dev,libopencv-ocl$DEF_VER,libopencv-ocl-dev,libopencv-photo$DEF_VER,libopencv-photo-dev,libopencv-stitching$DEF_VER,libopencv-stitching-dev,libopencv-superres$DEF_VER,libopencv-superres-dev,libopencv-ts$DEF_VER,libopencv-ts-dev,libopencv-video$DEF_VER,libopencv-video-dev,libopencv-videostab$DEF_VER,libopencv-videostab-dev,opencv-data,opencv-doc,python-opencv,python-opencv-apps

set +e

if installCheck "$0"; then
  echo "OpenCV installed";
