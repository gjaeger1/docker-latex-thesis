FROM fedora:31

# Install software
ENV DEBIAN_FRONTEND=noninteractive 

RUN dnf install -y git wget unzip gtkmm30-devel plplot-devel boost-devel lcov graphviz doxygen valgrind yaml-cpp-devel meson eigen3-devel libunwind-devel automake libtool make gcc-g++ gsl-devel cmake pkg-config openmpi-devel clang texlive-scheme-full

#RUN apt-get install -y git libgtkmm-3.0-dev libplplot-dev wget unzip python3-pip libboost-all-dev lcov libxml2-utils tzdata graphviz doxygen valgrind libyaml-cpp-dev ninja-build libeigen3-dev libunwind-dev
#RUN pip3 install meson

# set system time
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Add git.informatik.tu-freiberg.de key
RUN mkdir /root/.ssh/
RUN ssh-keyscan git.informatik.tu-freiberg.de >> /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN mkdir /custom
WORKDIR /custom


# Clone and build gtkmm-plplot
WORKDIR /custom
RUN wget latex.tu-freiberg.de/download/TUBAF-LaTeX-v.2.5.1-ohne-Hausschrift.zip
RUN unzip TUBAF-LaTeX-v.2.5.1-ohne-Hausschrift.zip -d tubaf-latex
RUN cp −r tubaf-latex/texmf /usr/share/texlive/texmf-dist
RUN texhash −−quiet

WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
