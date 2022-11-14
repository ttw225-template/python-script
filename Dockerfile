FROM python:3.10-slim

# Setting Language Environment Variables
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Update pip3 to the latest version
RUN python3 -m pip install --upgrade pip

# Install dependencies
RUN pip3 install --upgrade pipenv
COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock
RUN pipenv install --deploy --system

# Copy src files
COPY ./src /src
WORKDIR /src

# Create User
RUN useradd -ms /bin/bash user
RUN chown -R user:user /src
USER user

# Default Command
ENTRYPOINT [ "python3", "app.py" ]
CMD [ "example_parameters" ]
