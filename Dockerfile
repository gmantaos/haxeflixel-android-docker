FROM gmantaos/haxeflixel:4.6.0

LABEL maintainer="gmantaos@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# root folder for SDK and NDK installations
ENV SDK_HOME /opt/

# install dependencies for running 32-bit
RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get -qqy install libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

########################################################
#              Java JDK 8
########################################################
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN apt-get -qq update && \
    apt-get -qqy install openjdk-8-jdk --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

########################################################
#              Android SDK
########################################################
ENV ANDROID_SDK_VERSION 25.2.4
RUN apt-get -qq update && \
    apt-get -qqy install unzip --no-install-recommends && \
    curl -L "http://dl.google.com/android/repository/tools_r${ANDROID_SDK_VERSION}-linux.zip" > android-sdk.zip && \
    unzip -q android-sdk.zip -d ${SDK_HOME}/android-sdk && \
    rm android-sdk.zip && \
    apt-get -qqy remove unzip && \
    rm -rf /var/lib/apt/lists/*

# set env variables
ENV ANDROID_HOME ${SDK_HOME}/android-sdk
ENV ANDROID_SDK ${SDK_HOME}/android-sdk
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

# accept licenses
RUN mkdir -p "$ANDROID_SDK/licenses" && \
    echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_SDK/licenses/android-sdk-license" && \
    echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_SDK/licenses/android-sdk-preview-license"

# install Android SDK components
ENV ANDROID_VERSION 25
ENV ANDROID_TOOLS_VERSION 25.0.2
ENV ANDROID_COMPONENTS platform-tools,build-tools-${ANDROID_TOOLS_VERSION},android-${ANDROID_VERSION}
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-android-support

RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_COMPONENTS}"; \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_COMPONENTS}"


########################################################
#              Android NDK
########################################################
ENV ANDROID_NDK_VERSION r13b
ENV ANDROID_NDK_HOME ${SDK_HOME}/android-ndk
ENV ANDROID_NDK_ROOT ${ANDROID_NDK_HOME}
ENV PATH ${ANDROID_NDK_HOME}:$PATH

RUN apt-get -qq update && \
    apt-get -qqy install unzip --no-install-recommends && \
    curl -L "http://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip" -o android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip -d ${SDK_HOME} && \
    mv ${SDK_HOME}/android-ndk-${ANDROID_NDK_VERSION} ${SDK_HOME}/android-ndk && \
    rm -rf android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    apt-get -qqy remove unzip && \
    rm -rf /var/lib/apt/lists/*

########################################################
#              Configure Lime
########################################################
RUN lime config ANDROID_SDK $ANDROID_SDK
RUN lime config JAVA_HOME $JAVA_HOME
RUN lime config ANDROID_NDK_ROOT $ANDROID_NDK_ROOT
RUN lime config ANDROID_SETUP true
