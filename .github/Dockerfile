FROM python:3.11.3-slim

ENV JULIA_CI true
ENV JULIA_NUM_THREADS "auto"
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND "Null"
ENV JULIA_PATH /usr/local/julia/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia:1.9.0 ${JULIA_PATH} ${JULIA_PATH}

# Python dependencies
COPY requirements.txt .
RUN pip install --upgrade --no-cache-dir pip wheel setuptools && pip install --no-cache-dir -r requirements.txt

# Julia env
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN JULIA_PROJECT="" julia --color=yes -e 'import Pkg; Pkg.Registry.update(); Pkg.add(["Literate", "PrettyTables"])' && \
    JULIA_PROJECT=@. julia --color=yes -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

CMD ["julia"]
