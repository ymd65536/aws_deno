FROM public.ecr.aws/amazonlinux/amazonlinux:2.0.20230119.1-arm64v8

RUN amazon-linux-extras install -y

# yum update & install
RUN yum update -y \
  && yum install \
  systemd \
  tar \
  unzip \
  sudo \
  -y

# create user
RUN useradd "ec2-user" && echo "ec2-user ALL=NOPASSWD: ALL" >> /etc/sudoers

# curl -Lo test "https://github.com/denoland/deno_install/archive/refs/tags/v0.1.4.zip"
RUN curl -fsSL https://deno.land/install.sh | sh
ENV PATH $PATH:$HOME/.deno/bin

# deno install
ENV PATH $PATH:$HOME/.deno/bin

WORKDIR /home/ec2-user
CMD ["/sbin/init"]
