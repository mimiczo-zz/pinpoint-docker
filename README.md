# Pinpoint-docker
Docker for Pinpoint. You can see the repository on [mimiczo/pinpoint-docker](https://hub.docker.com/r/mimiczo/pinpoint-docker).

# About

* Ubuntu 14.04
* Oracle Java 8
* Maven 3.3.3
* Pinpoint 1.5.1
* Hbase 1.0.2

# Installation

```
    docker pull mimiczo/pinpoint-docker
```

# Usage Test Application Agent

```
   docker run -i -t -p 28080:28080 -p 28081:28081 -p 28082:28082 \
    --cap-add SYS_PTRACE --security-opt apparmor:unconfined mimiczo/pinpoint:1.5.1 bash
```

# Usage External Application Agent

```
   docker run -i -t -p 28080:28080 \
    -p 29994:29994 -p 29995:29995/udp -p 29996:29996/udp \
    --cap-add SYS_PTRACE --security-opt apparmor:unconfined mimiczo/pinpoint:1.5.1 bash
```

# Start Pinpoint Daemons

```
quickstart/bin/start-hbase.sh
quickstart/bin/init-hbase.sh

quickstart/bin/start-collector.sh
quickstart/bin/start-web.sh
quickstart/bin/start-testapp.sh
```

# Quickstart

for Details, please refer to the [quick-start guide](https://github.com/naver/pinpoint/blob/master/quickstart/README.md).

# License

Copyright (c) mimiczo. [LICENSE.txt](https://github.com/mimiczo/pinpoint-docker/license.txt).
Dockerfile references from [yous/pinpoint](https://hub.docker.com/r/yous/pinpoint).
