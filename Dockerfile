FROM ubuntu:latest
LABEL maintainer="sombochea@cubetiqs.com"

# RUN sudo mode with root access
USER root

# Install required packages by sdkman
RUN apt-get update && apt-get install -y curl zip unzip

# Create non-root user
RUN useradd -rm -d /home/cubetiq -s /bin/bash -g root -G sudo -u 1001 cubetiq

# Build with non-root access
USER cubetiq
WORKDIR /home/cubetiq

# Install sdkman
RUN curl -s "https://get.sdkman.io" | bash

# Install java
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk version"

# Set environment variables
ARG SDK_JAVA_VERSION=22.3.r19-grl
# ENV SDK_JAVA_VERSION 22.3.r19-grl

# Install java
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java $SDK_JAVA_VERSION"

# Set environment variables for current user
ENV HOME /home/cubetiq
ENV JAVA_HOME="$HOME/.sdkman/candidates/java/current"
ENV PATH="$PATH:$JAVA_HOME/bin"

# Verify installation
RUN echo "export JAVA_HOME=$JAVA_HOME" >> $HOME/.bashrc
RUN echo "export PATH=$PATH" >> $HOME/.bashrc
RUN java -version

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Set default command
CMD ["java"]