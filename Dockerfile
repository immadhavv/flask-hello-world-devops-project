FROM python:3.9.12
MAINTAINER Niranjan Madhavan D "niranjan.madhavan.d@gmail.com"
COPY app.py test.py /app/
WORKDIR /app
RUN pip install flask pytest flake8 #This downloads all the dependencies
CMD ["python", "app.py"]
