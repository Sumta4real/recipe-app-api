#define the base image 
FROM python:3.9-alpine3.13 
#define the maintainer- the person that would be managing the app
LABEL maintainer="londonappdeveloper.com"
#londonappdeveloper.com

#recommended when you 
ENV PYTHONUNBUFFERED 1

#copy specified file from local to the container
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt  /tmp/requirements.dev.txt
COPY ./app /app 
#sets the default working directory on our docker image
WORKDIR /app
#expose port 8000 to from our container to our machine when we run our container 
EXPOSE 8000

#define build argument called 'DEV' and sets the default value to false
ARG DEV=false
#add a run command that would install some dependencies on our machine
    #create virtual environment
RUN python -m venv /py && \
    #specify the full path of the virtul environment, then install pip
    /py/bin/pip install --upgrade pip && \
    #install the list of requiremnets inside the docker image
    /py/bin/pip install -r /tmp/requirements.txt && \
    #shell script to a code if a condition is satisfied (run dev dependencies if dev argument is true)
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
        fi && \
    #remove the tmp directory. To avoid having extra dependencies on our image once its been created
    rm -rf /tmp && \
    #add a new user . Since its best practice not to run your application using the root user 
    adduser \
        #we don't create a password for this user
        --disabled-password \
        #don't create a home directory for the user
        --no-create-home \
        #specify the name of the user
        django-user

#update the environment variable. It sp
ENV PATH="/py/bin:$PATH"

#specifies the user we are switching to. Prior to now, we have been using the root user
USER django-user





