FROM ubuntu

RUN \
apt-get update && \
apt-get install -y mongodb-org && \
rm -rf /var/lib/apt/lists/*
  
# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["mongod"]

# Expose ports.
EXPOSE 27017