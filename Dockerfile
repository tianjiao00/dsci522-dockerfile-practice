# Use the Jupyter team's minimal-notebook as the base image
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Copy environment.yml for additional dependencies (if needed)
COPY environment.yml /tmp/environment.yml

# Copy the conda.lock file to the container
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Install packages from the conda.lock file
RUN mamba update --quiet --file /tmp/conda-linux-64.lock \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"