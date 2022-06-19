FROM python:3.10

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /server
COPY . .

RUN pip3 install -r requirements.txt

RUN python3 ReusableLearningAppServer/manage.py collectstatic --no-input

RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8000
CMD ["python3", "ReusableLearningAppServer/manage.py", "runserver", "0.0.0.0:8000"]
