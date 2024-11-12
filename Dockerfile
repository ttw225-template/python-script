FROM python:3.13-slim

# Setting Language Environment Variables
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Change the working directory to the `src` directory
WORKDIR /src

# Install dependencies and check if environment dependencies match uv.lock
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen

# Copy the project into the image
COPY ./src /src

# Create User
RUN useradd -ms /bin/bash user
RUN chown -R user:user /src
USER user

# Default Command
ENTRYPOINT [ "uv", "run", "python3", "app.py" ]
# CMD [ "example_parameters" ]
