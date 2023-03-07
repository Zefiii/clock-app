FROM python:3.10

RUN mkdir /opt/backend && useradd backend
COPY requirements.txt /opt/backend
RUN chown -R backend: /opt/backend && mkdir /home/backend && chown -R backend: /home/backend
USER backend
RUN pip3 install -r /opt/backend/requirements.txt 
ENV PATH="$PATH:/home/backend/.local/bin"
COPY app.py /opt/backend
WORKDIR /opt/backend
ENV FLASK_RUN_HOST 0.0.0.0
CMD flask run
