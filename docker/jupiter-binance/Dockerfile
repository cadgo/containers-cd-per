FROM jupyter/datascience-notebook
WORKDIR /home/jovyan
RUN mkdir .aws/
ARG AWS_ACCESS
ARG AWS_SECRET
RUN echo -e "[default]\naws_access_key_id=$AWS_ACCESS\naws_secret_access_key=$AWS_SECRET" > /home/jovyan/.aws/credentials
RUN echo -e "[default]\nregion=us-east-1" > /home/jovyan/.aws/config
RUN sed -i 's/# c.NotebookApp.iopub_data_rate_limit = 1000000/c.notebookapp.iopub_ data_ rate_ limit = 1000000000/g' /home/jovyan/.jupyter/jupyter_notebook_config.py 
RUN conda install -c anaconda boto3 
#RUN pip install python-binance boto3 
