# syntax=docker/dockerfile:1

# ================================
# Build image
# ================================
FROM swift:6.2-noble AS build

WORKDIR /build

RUN mkdir /staging

RUN --mount=type=bind,source=Sources,target=/build/Sources \
    --mount=type=bind,source=Package.swift,target=/build/Package.swift \
    --mount=type=bind,source=Package.resolved,target=/build/Package.resolved \
    --mount=type=cache,target=/build/.build \
    swift build -c release \
        --product App \
        --static-swift-stdlib \
        -Xswiftc --enable-incremental-file-hashing \
        -Xlinker -ljemalloc && \
    cp "$(swift build -c release --show-bin-path)/App" /staging

# ================================
# Run image
# ================================
FROM ubuntu:noble
WORKDIR /app
COPY --from=build /staging /app
EXPOSE 8080
ENTRYPOINT ["./App"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]