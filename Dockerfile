FROM debian:latest

# install deps
RUN apt update && apt upgrade -y && apt install -y curl gpg ca-certificates tar dirmngr

ADD init.sh /

EXPOSE 33700
ENTRYPOINT ["/bin/bash"]
CMD ["/init.sh"]
LABEL name="nyancoin-node" version="2.0" description="Nyancoin fullnode container based off Debian"
