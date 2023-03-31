FROM ghcr.io/sosiristseng/juliabook:1.8.5.3

# Python env
COPY requirements.txt .
RUN pip install -U pip setuptools wheel && pip install --no-cache-dir -r requirements.txt

# Julia environment
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes --project=@. -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'
