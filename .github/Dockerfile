FROM python:3.11.3-slim

ENV JULIA_CI true
ENV JULIA_NUM_THREADS "auto"
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND "Null"
ENV JULIA_PATH /usr/local/julia/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia:1.8.5 ${JULIA_PATH} ${JULIA_PATH}

# System packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Python dependencies
COPY requirements.txt .
RUN pip install --upgrade --no-cache-dir pip wheel setuptools && pip install --no-cache-dir -r requirements.txt

COPY *.toml ./
COPY src/ src
RUN JULIA_PROJECT="" julia --color=yes -e 'import Pkg; Pkg.Registry.update(); Pkg.add(["Literate", "PrettyTables"])' && \
    JULIA_PROJECT=@. julia --color=yes -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

CMD ["jupyter-book"]
