FROM python:3.10

RUN mkdir /home/ansible
COPY requirements.txt /home/ansible
COPY rsa /home/ansible/
COPY runme.sh /home/ansible/
RUN chmod +x /home/ansible/runme.sh && \
	chmod 600 /home/ansible/rsa && \
	useradd -d /home/ansible ansible && \
	chown -R ansible: /home/ansible && \
	mkdir /opt/ansible
USER ansible
RUN pip3 install -r /home/ansible/requirements.txt 
COPY ansible/ /opt/ansible
WORKDIR /opt/ansible
ENV ANSIBLE_HOST_KEY_CHECKING False
CMD /home/ansible/runme.sh
