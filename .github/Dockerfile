FROM ghcr.io/sosiristseng/docker-jupyterbook:0.15.1.1 as base

# Julia
ENV JULIA_CI true
ENV JULIA_NUM_THREADS "auto"
ENV JULIA_PATH /usr/local/julia/
ENV JULIA_DEPOT_PATH /srv/juliapkg/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia:1.8.5 ${JULIA_PATH} ${JULIA_PATH}

FROM base

WORKDIR /app

# Julia environment
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes --project=@. -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

CMD ["jupyter-book"]
