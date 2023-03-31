FROM ghcr.io/sosiristseng/docker-jupyterbook:0.15.1.1

ENV JULIA_CI true
ENV JULIA_NUM_THREADS "auto"
# Use built-in python
ENV JULIA_CONDAPKG_BACKEND "Null"
ENV JULIA_PATH /usr/local/julia/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia:1.8.5 ${JULIA_PATH} ${JULIA_PATH}

# Python env
COPY requirements.txt .
RUN pip install -U pip setuptools wheel && pip install --no-cache-dir -r requirements.txt

# Julia environment
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes --project=@. -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'
