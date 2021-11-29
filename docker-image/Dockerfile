FROM opengatecollaboration/gate:8.2

# Run the following commands as super user (root):
USER root

ENV MONTE_CARLO_SIMULATIONS /monte-carlo-simulations
ENV MONTE_CARLO_TESTS /tests/func
ENV SCRIPT_PATH /usr/local/bin
ENV OUTPUT_PATH /output

# Install graphic libraries to avoid root(cern) error
# packages for centos "libSM libX11 libXext libXpm libXft"
RUN yum update -y && yum install -y libSM libX11 libXext libXpm libXft
#RUN apt-get update && apt-get install -y libx11-6 libxext6 libxpm4 libxft2 libsm6 libtiff5
# Setup output folder
RUN mkdir /output && chmod 777 /output

# Create a user that does not have root privileges
ARG username=physicist
RUN useradd --create-home --home-dir /home/${username} ${username}
ENV HOME /home/${username}

RUN chown -R ${username} /output

WORKDIR /home/${username}

# Switch to our newly created user
#USER ${username}
COPY --chown=${username} monte-carlo-simulations /monte-carlo-simulations
COPY --chown=${username} tests/ /tests
COPY --chown=${username} scripts/ /usr/local/bin/


RUN chown -R ${username} /home/${username}
#Gate 9.0
#ENV PATH $PATH:/gate/gate_9.0-install/bin
#RUN echo "source /geant4/geant4.10.06.p01-install/bin/geant4.sh" >> ~/.bashrc
#RUN echo "source /cern/root-install/bin/thisroot.sh" >> ~/.bashrc

ENV PATH $PATH:/gate/gate_8.2-install/bin
RUN echo "source /geant4/geant4.10.05-install/bin/geant4.sh" >> ~/.bashrc
RUN echo "source /cern/root-install/bin/thisroot.sh" >> ~/.bashrc

ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint.sh"]
#CMD ["bash", "-lc", "./run_tests.sh"]

