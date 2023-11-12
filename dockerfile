FROM python:3.9.3-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN apk add --no-cache zlib-dev && \
     pip install --upgrade pip && \
     python3 -m pip install --upgrade pip
COPY ./requirements.txt /usr/src/app
RUN pip install -r requirements.txt && \
     pip install crispy-bootstrap4 && \
     python3 -m pip install --upgrade Pillow

# copy project
COPY . /usr/src/app

EXPOSE 8000

# CMD ["python", "django_web_app/manage.py", "test"]


CMD ["python", "django_web_app/manage.py", "runserver", "0.0.0.0:8000"]
