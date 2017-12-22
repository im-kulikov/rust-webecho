# Builder:
FROM ekidd/rust-musl-builder as builder

COPY . /home/rust/src

WORKDIR /home/rust/src

RUN set -x \
    && export RUST_BACKTRACE=1 \
    && sudo chown -R rust:rust . \
    && mkdir -p /home/rust/src/target/release/ \
    && cargo build --release

FROM scratch

COPY --from=builder /home/rust/src/target/x86_64-unknown-linux-musl/release/rust-webecho /

EXPOSE 3000

CMD ["/rust-webecho"]