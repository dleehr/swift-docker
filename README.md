# swift-docker

Dockerfile to install [swift](https://swift.org) in an Ubuntu-based docker container

## Usage

    $ docker run -it dleehr/swift
    swift@09d60d218729:~$ swift
    Welcome to Swift version 2.2-dev (LLVM 46be9ff861, Clang 4deb154edc, Swift 778f82939c). Type :help for assistance.
      1> 3+3
    $R0: Int = 6
      2>

## Notes

Uses Apple's Ubuntu snapshot, which includes swift, swiftc, and swift build. Inside the container, swift is installed beneath `/opt/swift`, and owned by user `swift`.

See [Dockerfile](Dockerfile) for further details.
