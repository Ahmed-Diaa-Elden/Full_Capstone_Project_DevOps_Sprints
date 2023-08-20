FROM python:3.9

WORKDIR /app

COPY MySQL-and-Python/FlaskApp /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the Flask app port
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
