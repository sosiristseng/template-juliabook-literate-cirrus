FROM python:3.12.0b2-slim as base

ENV JULIA_CI true
ENV JULIA_NUM_THREADS "auto"
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND "Null"
ENV JULIA_PATH /usr/local/julia/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia:1.9.0 ${JULIA_PATH} ${JULIA_PATH}

FROM base

# Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Julia environment
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --project="" --color=yes -e 'import Pkg; Pkg.add(["Literate", "PrettyTables"])' && \
    julia --project=@. --color=yes -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'
