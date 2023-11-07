FROM python:3.9.3-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN apk add --no-cache zlib-dev
RUN pip install --upgrade pip 
COPY ./requirements.txt /usr/src/app
RUN pip install -r requirements.txt
RUN pip install crispy-bootstrap4

# copy project
COPY . /usr/src/app

EXPOSE 8000

# CMD ["python", "django_web_app/manage.py", "makemigrations"]


CMD ["python", "django_web_app/manage.py", "runserver", "0.0.0.0:8000"]
